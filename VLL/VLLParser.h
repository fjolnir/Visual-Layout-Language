@import Foundation;

#if TARGET_OS_IPHONE
#define VLLView UIView
#define VLLColor UIColor
#define VLLLayoutConstraintAxisHorizontal UILayoutConstraintAxisHorizontal
#define VLLLayoutConstraintAxisVertical UILayoutConstraintAxisVertical
#else
#define VLLView NSView
#define VLLColor NSColor
typedef NS_ENUM(NSInteger, VLLLayoutConstraintAxis) {
    VLLLayoutConstraintAxisHorizontal = 0,
    VLLLayoutConstraintAxisVertical = 1
};
#endif

@interface VLLParser : NSObject
+ (VLLParser *)vllWithVLLName:(NSString *)aVLLName bundle:(NSBundle *)aBundle;
+ (VLLParser *)vllWithVLLData:(NSData * const)aData bundle:(NSBundle * const)aBundle;

- (id)initWithData:(NSData * const)aData bundle:(NSBundle * const)aBundle;

- (NSArray *)instantiate:(NSDictionary **)aoViews inView:(VLLView *)aContainer;
@end
