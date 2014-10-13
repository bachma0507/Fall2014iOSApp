//
//  NewViewController.m
//  Fall2014IOSApp
//
//  Created by Barry on 10/12/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    NSLog(@"%@ (%p) - %@", NSStringFromClass([self class]), self, NSStringFromSelector(_cmd));
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    NSLog(@"%@ (%p) - %@", NSStringFromClass([self class]), self, NSStringFromSelector(_cmd));
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@ (%p) - %@", NSStringFromClass([self class]), self, NSStringFromSelector(_cmd));
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@ (%p) - %@", NSStringFromClass([self class]), self, NSStringFromSelector(_cmd));
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    NSLog(@"%@ (%p) - %@", NSStringFromClass([self class]), self, NSStringFromSelector(_cmd));
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    NSLog(@"%@ (%p) - %@", NSStringFromClass([self class]), self, NSStringFromSelector(_cmd));
}


@end