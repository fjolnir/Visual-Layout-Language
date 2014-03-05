#import <VLL/VLLParser.h>

@interface NSLayoutConstraint (VLLExtensions)
+ (NSArray *)vll_addLeadingEdgeConstraintsForAxis:(VLLLayoutConstraintAxis)aAxis
                                          view:(VLLView *)aView
                                     superview:(VLLView *)aSuperView
                                     relatedBy:(NSLayoutRelation)aRelation
                                    multiplier:(CGFloat)aMultiplier
                                      constant:(CGFloat)aConstant
                                      priority:(VLLLayoutPriority)aPriority;
+ (NSArray *)vll_addTrailingEdgeConstraintsForAxis:(VLLLayoutConstraintAxis)aAxis
                                           view:(VLLView *)aView
                                      superview:(VLLView *)aSuperView
                                      relatedBy:(NSLayoutRelation)aRelation
                                     multiplier:(CGFloat)aMultiplier
                                       constant:(CGFloat)aConstant
                                       priority:(VLLLayoutPriority)aPriority;
+ (NSArray *)vll_addSpacingConstraintsForAxis:(VLLLayoutConstraintAxis)aAxis
                                 firstView:(VLLView *)aViewA
                                secondView:(VLLView *)aViewB
                                 relatedBy:(NSLayoutRelation)aRelation
                                multiplier:(CGFloat)aMultiplier
                                  constant:(CGFloat)aConstant
                                  priority:(VLLLayoutPriority)aPriority;
+ (NSArray *)vll_addSizeConstraintsForAxis:(VLLLayoutConstraintAxis const)aAxis
                                 onView:(VLLView * const)aView
                       toViewOrConstant:(id)aSource
                              relatedBy:(NSLayoutRelation const)aRelation
                             multiplier:(CGFloat const)aMultiplier
                               priority:(VLLLayoutPriority const)aPriority;
@end
