//
//  FAViewController.m
//  VLL
//
//  Created by Fjölnir Ásgeirsson on 3/1/14.
//  Copyright (c) 2014 Fjölnir Ásgeirsson. All rights reserved.
//

#import "FAViewController.h"
#import <VLL/VLLParser.h>

@interface FAViewController ()

@end

@implementation FAViewController

- (void)loadView
{
    self.view = [UIView new];
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    VLLParser * const vll = [VLLParser vllWithVLLName:NSStringFromClass([self class])
                                               bundle:[NSBundle bundleForClass:[self class]]];
    [vll instantiate:NULL inView:self.view];
    NSLog(@"%@", self.view.constraints);
}

@end
