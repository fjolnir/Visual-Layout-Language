#import "NSInvocation+VLLExtensions.h"
@import ObjectiveC.runtime;

@implementation NSInvocation (VLLExtensions)

- (void)vll_setArgument:(id const)aArg atIndex:(NSInteger const)aIdx
{
    const char *type = [self.methodSignature getArgumentTypeAtIndex:aIdx];
	if(*type == 'r') type++;
    
#define UNBOX(val, extractionSelector) ({ \
    typeof([aArg extractionSelector]) __buf__ = [aArg extractionSelector]; \
    &__buf__; \
})
    switch(*type) {
        case _C_ID:
        case _C_CLASS:
            [self setArgument:(void *)&aArg atIndex:aIdx];
            break;
        case _C_CHR:
            [self setArgument:UNBOX(aArg, charValue) atIndex:aIdx];
            break;
        case _C_UCHR:
            [self setArgument:UNBOX(aArg, unsignedCharValue) atIndex:aIdx];
            break;
        case _C_SHT:
            [self setArgument:UNBOX(aArg, shortValue) atIndex:aIdx];
            break;
        case _C_USHT:
            [self setArgument:UNBOX(aArg, unsignedShortValue) atIndex:aIdx];
            break;
        case _C_INT:
            [self setArgument:UNBOX(aArg, intValue) atIndex:aIdx];
            break;
        case _C_UINT:
            [self setArgument:UNBOX(aArg, unsignedIntValue) atIndex:aIdx];
            break;
        case _C_LNG:
            [self setArgument:UNBOX(aArg, longValue) atIndex:aIdx];
            break;
        case _C_ULNG:
            [self setArgument:UNBOX(aArg, unsignedLongValue) atIndex:aIdx];
            break;
        case _C_LNG_LNG:
            [self setArgument:UNBOX(aArg, longLongValue) atIndex:aIdx];
            break;
        case _C_ULNG_LNG:
            [self setArgument:UNBOX(aArg, unsignedLongLongValue) atIndex:aIdx];
            break;
        case _C_FLT:
            [self setArgument:UNBOX(aArg, floatValue) atIndex:aIdx];
            break;
        case _C_DBL:
            [self setArgument:UNBOX(aArg, doubleValue) atIndex:aIdx];
            break;
        case _C_BOOL:
            [self setArgument:UNBOX(aArg, boolValue) atIndex:aIdx];
            break;
        case _C_SEL: {
            SEL selector = NSSelectorFromString(aArg);
            [self setArgument:&selector atIndex:aIdx];
            break;
        }
        default:
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:@"Type not supported for unboxing"
                                         userInfo:nil];
    }
}

- (id)vll_getReturnValue
{
    if(self.methodSignature.methodReturnLength == 0)
        return nil;
    const char *type = [self.methodSignature methodReturnType];
	if(*type == 'r') type++;
    
    void *buf = alloca(self.methodSignature.methodReturnLength);
    [self getReturnValue:buf];
    switch(*type) {
        case _C_ID:
        case _C_CLASS:
            return *(__strong id *)buf;
        case _C_CHR:
            return @(*(char *)buf);
        case _C_UCHR:
            return @(*(unsigned char *)buf);
        case _C_SHT:
            return @(*(short *)buf);
        case _C_USHT:
            return @(*(unsigned short *)buf);
        case _C_INT:
            return @(*(int *)buf);
        case _C_UINT:
            return @(*(unsigned int *)buf);
        case _C_LNG:
            return @(*(long *)buf);
        case _C_ULNG:
            return @(*(unsigned long *)buf);
        case _C_LNG_LNG:
            return @(*(long long *)buf);
        case _C_ULNG_LNG:
            return @(*(unsigned long long *)buf);
        case _C_FLT:
            return @(*(float *)buf);
        case _C_DBL:
            return @(*(double *)buf);
        case _C_BOOL:
            return @(*(BOOL *)buf);
        case _C_SEL:
            return NSStringFromSelector(*(SEL *)buf);
        default:
            return nil;
    }

}
@end
