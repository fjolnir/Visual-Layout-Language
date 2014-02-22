#import "VLLParser.h"
@import ObjectiveC.runtime;

#define YY_CTX_MEMBERS \
    const char *inputBuf; \
    NSMutableArray *stack, *orientationStack, *viewStack, *rootViews; \
    NSMutableDictionary *views; \
    VLLView *container;

#define YY_INPUT(ctx, buf, result, max_size) \
{ \
    if(*ctx->inputBuf != '\0') { \
        *buf = *ctx->inputBuf++; \
        result = 1; \
    } else \
        result = 0; \
}
#include "vll_parse.m"

@interface VLLParser () {
    NSMutableData *_vllData;
    NSBundle *_bundle;
    NSMutableArray *_rootViews;
}
@end
@implementation VLLParser
+ (VLLParser *)vllWithVLLName:(NSString * const)aVLLName bundle:(NSBundle * const)aBundle
{
    NSURL * const url = [aBundle  URLForResource:aVLLName
                                   withExtension:@"vll"];
    return [self vllWithVLLData:[NSData dataWithContentsOfURL:url] bundle:aBundle];
}

+ (VLLParser *)vllWithVLLData:(NSData * const)aData bundle:(NSBundle * const)aBundle
{
    return [[[self alloc] initWithData:aData bundle:aBundle] autorelease];
}

- (id)initWithData:(NSData * const)aData bundle:(NSBundle * const)aBundle
{
    if(!aData || !(self = [super init])) {
        [self release];
        return nil;
    }

    _bundle = [aBundle retain];
    
    _vllData = [aData mutableCopy];
    [_vllData setLength:_vllData.length+1]; // NULL
    NSLog(@"VLL:\n%s", _vllData.bytes);
    
    return self;
}

- (void)dealloc
{
    [_bundle release];
    [_vllData release];
    [super dealloc];
}

- (NSArray *)instantiate:(NSDictionary **)aoViews inView:(VLLView *)aContainer
{
    yycontext ctx;
    memset(&ctx, 0, sizeof(yycontext));
    ctx.inputBuf = _vllData.bytes;
    ctx.stack    = [NSMutableArray array];
    ctx.viewStack = aContainer
                  ? [NSMutableArray arrayWithObject:aContainer]
                  : [NSMutableArray array];
    ctx.orientationStack = [NSMutableArray array];
    ctx.views    = [NSMutableDictionary dictionary];
    ctx.rootViews = [NSMutableArray array];
    ctx.container = aContainer;
    while(yyparse(&ctx));
    if(aoViews) *aoViews = ctx.views;
    [aContainer updateConstraints];
    return ctx.rootViews;
}

@end
