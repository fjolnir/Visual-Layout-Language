#import "FAAppDelegate.h"
#import <VLL/VLLParser.h>

@interface NSView (VLLTest)
- (NSArray *)vll_recursiveConstraints;
@end

@implementation NSView (VLLTest)

- (NSArray *)vll_recursiveConstraints
{
    NSMutableArray *constraints = [self.constraints mutableCopy];
    for(NSView *view in self.subviews) {
        [constraints addObjectsFromArray:[view vll_recursiveConstraints]];
    }
    return constraints;
}

@end

@implementation FAAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSUserDefaults standardUserDefaults] setObject:@YES
                                              forKey:@"NSConstraintBasedLayoutVisualizeMutuallyExclusiveConstraints"];
    VLLParser * parser = [VLLParser vllWithVLLName:@"test"
                                            bundle:[NSBundle mainBundle]];
    NSDictionary *views;
    [parser instantiate:&views inView:_window.contentView];
    [_window visualizeConstraints:[_window.contentView vll_recursiveConstraints]];
    NSLog(@"%@ -- %@", views, [_window.contentView vll_recursiveConstraints]);
}

@end
