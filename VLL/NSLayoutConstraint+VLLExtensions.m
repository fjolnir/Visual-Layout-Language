#import "NSLayoutConstraint+VLLExtensions.h"

#define VLLAxisToDimension(axis) (axis) == VLLLayoutConstraintAxisHorizontal ? NSLayoutAttributeWidth \
                                                                             : NSLayoutAttributeHeight
#define VLLAxisToLeadingEdge(axis) (axis) == VLLLayoutConstraintAxisHorizontal ? NSLayoutAttributeLeading \
                                                                               : NSLayoutAttributeTop
#define VLLAxisToTrailingEdge(axis) (axis) == VLLLayoutConstraintAxisHorizontal ? NSLayoutAttributeTrailing \
                                                                                : NSLayoutAttributeBottom
@implementation NSLayoutConstraint (VLLExtensions)

+ (NSArray *)vll_addLeadingEdgeConstraintsForAxis:(VLLLayoutConstraintAxis const)aAxis
                                          view:(VLLView * const)aView
                                     superview:(VLLView * const)aSuperView
                                     relatedBy:(NSLayoutRelation const)aRelation
                                    multiplier:(CGFloat const)aMultiplier
                                      constant:(CGFloat const)aConstant
                                      priority:(VLLLayoutPriority const)aPriority
{
    NSMutableArray * const constraints = [NSMutableArray array];
    
    if(aAxis & VLLLayoutConstraintAxisHorizontal)
        [constraints addObject:[NSLayoutConstraint
                                constraintWithItem:aView
                                attribute:VLLAxisToLeadingEdge(VLLLayoutConstraintAxisHorizontal)
                                relatedBy:aRelation
                                toItem:aSuperView
                                attribute:VLLAxisToLeadingEdge(VLLLayoutConstraintAxisHorizontal)
                                multiplier:aMultiplier
                                constant:aConstant]];
    
    if(aAxis & VLLLayoutConstraintAxisVertical)
        [constraints addObject:[NSLayoutConstraint
                                constraintWithItem:aView
                                attribute:VLLAxisToLeadingEdge(VLLLayoutConstraintAxisVertical)
                                relatedBy:aRelation
                                toItem:aSuperView
                                attribute:VLLAxisToLeadingEdge(VLLLayoutConstraintAxisVertical)
                                multiplier:aMultiplier
                                constant:aConstant]];
    
    if(aPriority > 0)
        [constraints setValue:@(aPriority) forKey:@"priority"];

    [aSuperView addConstraints:constraints];
    return constraints;
}

+ (NSArray *)vll_addTrailingEdgeConstraintsForAxis:(VLLLayoutConstraintAxis const)aAxis
                                           view:(VLLView * const)aView
                                      superview:(VLLView * const)aSuperView
                                      relatedBy:(NSLayoutRelation const)aRelation
                                     multiplier:(CGFloat const)aMultiplier
                                       constant:(CGFloat const)aConstant
                                       priority:(VLLLayoutPriority const)aPriority
{
    NSMutableArray * const constraints = [NSMutableArray array];
    
    if(aAxis & VLLLayoutConstraintAxisHorizontal)
        [constraints addObject:[NSLayoutConstraint
                                constraintWithItem:aSuperView
                                attribute:VLLAxisToTrailingEdge(VLLLayoutConstraintAxisHorizontal)
                                relatedBy:aRelation
                                toItem:aView
                                attribute:VLLAxisToTrailingEdge(VLLLayoutConstraintAxisHorizontal)
                                multiplier:aMultiplier
                                constant:aConstant]];
    
    if(aAxis & VLLLayoutConstraintAxisVertical)
        [constraints addObject:[NSLayoutConstraint
                                constraintWithItem:aSuperView
                                attribute:VLLAxisToTrailingEdge(VLLLayoutConstraintAxisVertical)
                                relatedBy:aRelation
                                toItem:aView
                                attribute:VLLAxisToTrailingEdge(VLLLayoutConstraintAxisVertical)
                                multiplier:aMultiplier
                                constant:aConstant]];
    
    if(aPriority > 0)
        [constraints setValue:@(aPriority) forKey:@"priority"];

    [aSuperView addConstraints:constraints];
    return constraints;
}

+ (NSArray *)vll_addSpacingConstraintsForAxis:(VLLLayoutConstraintAxis const)aAxis
                                 firstView:(VLLView * const)aViewA
                                secondView:(VLLView * const)aViewB
                                 relatedBy:(NSLayoutRelation const)aRelation
                                multiplier:(CGFloat const)aMultiplier
                                  constant:(CGFloat const)aConstant
                                  priority:(VLLLayoutPriority const)aPriority
{
    NSMutableArray * const constraints = [NSMutableArray array];
    
    if(aAxis & VLLLayoutConstraintAxisHorizontal)
        [constraints addObject:[NSLayoutConstraint
                                constraintWithItem:aViewA
                                attribute:VLLAxisToLeadingEdge(VLLLayoutConstraintAxisHorizontal)
                                relatedBy:aRelation
                                toItem:aViewB
                                attribute:VLLAxisToTrailingEdge(VLLLayoutConstraintAxisHorizontal)
                                multiplier:aMultiplier
                                constant:aConstant]];
    
    if(aAxis & VLLLayoutConstraintAxisVertical)
        [constraints addObject:[NSLayoutConstraint
                                constraintWithItem:aViewA
                                attribute:VLLAxisToLeadingEdge(VLLLayoutConstraintAxisVertical)
                                relatedBy:aRelation
                                toItem:aViewB
                                attribute:VLLAxisToTrailingEdge(VLLLayoutConstraintAxisVertical)
                                multiplier:aMultiplier
                                constant:aConstant]];
    
    if(aPriority > 0)
        [constraints setValue:@(aPriority) forKey:@"priority"];
    
    [aViewA.superview addConstraints:constraints];
    return constraints;
}

+ (NSArray *)vll_addSizeConstraintsForAxis:(VLLLayoutConstraintAxis const)aAxis
                                 onView:(VLLView * const)aView
                       toViewOrConstant:(id)aSource
                              relatedBy:(NSLayoutRelation const)aRelation
                             multiplier:(CGFloat const)aMultiplier
                               priority:(VLLLayoutPriority const)aPriority
{
    NSMutableArray * const constraints = [NSMutableArray array];
    
    BOOL const sourceIsView = [aSource isKindOfClass:[VLLView class]];
    if(aAxis & VLLLayoutConstraintAxisHorizontal)
        [constraints addObject:[NSLayoutConstraint
                                constraintWithItem:aView
                                attribute:VLLAxisToDimension(VLLLayoutConstraintAxisHorizontal)
                                relatedBy:aRelation
                                toItem:sourceIsView ? aSource : nil
                                attribute:sourceIsView ? VLLAxisToDimension(VLLLayoutConstraintAxisHorizontal)
                                                       : NSLayoutAttributeNotAnAttribute
                                multiplier:aMultiplier
                                constant:sourceIsView ? 0 : [aSource floatValue]]];
    
    if(aAxis & VLLLayoutConstraintAxisVertical)
        [constraints addObject:[NSLayoutConstraint
                                constraintWithItem:aView
                                attribute:VLLAxisToDimension(VLLLayoutConstraintAxisVertical)
                                relatedBy:aRelation
                                toItem:sourceIsView ? aSource : nil
                                attribute:sourceIsView ? VLLAxisToDimension(VLLLayoutConstraintAxisVertical)
                                                       : NSLayoutAttributeNotAnAttribute
                                multiplier:aMultiplier
                                constant:sourceIsView ? 0 : [aSource floatValue]]];
    
    if(aPriority > 0)
        [constraints setValue:@(aPriority) forKey:@"priority"];
    
    if(sourceIsView)
        [aView.superview addConstraints:constraints];
    else
        [aView addConstraints:constraints];
    return constraints;
}


@end
