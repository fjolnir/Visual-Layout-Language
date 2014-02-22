#import "NSString+VLLExtensions.h"

@implementation NSString (VLLExtensions)
- (NSString *)vll_capitalizedString
{
    if([self length] <= 1)
        return [self capitalizedString];
    else
        return [[[self substringToIndex:1] uppercaseString] stringByAppendingString:[self substringFromIndex:1]];
}
@end
