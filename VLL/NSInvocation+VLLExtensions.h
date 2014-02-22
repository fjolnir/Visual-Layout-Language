@import Foundation;

@interface NSInvocation (VLLExtensions)
- (void)vll_setArgument:(id)aArg atIndex:(NSInteger)aIdx;
- (id)vll_getReturnValue;
@end
