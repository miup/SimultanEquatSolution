//
//  TKBPopoverContext.m
//  UIPopoverContextSample
//
//  Created by Yusuke Iwama on 2/28/14.
//  Copyright (c) 2014 University of Tsukuba. All rights reserved.
//

#import "TKBPopoverContext.h"

@implementation TKBPopoverContext {
    NSMutableArray *_popoverControllers;
}

+ (TKBPopoverContext *)sharedPopoverContext
{
    static TKBPopoverContext *sharedPopoverContext = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPopoverContext = [[TKBPopoverContext alloc] init];
    });
    
    return sharedPopoverContext;
}

- (id)init
{
    self = [super init];
    if (self) {
        _popoverControllers = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Public Instance Methods.

- (void)presentPopoverWithContentViewController:(UIViewController *)contentViewController fromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)directions animated:(BOOL)animated
{
    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:contentViewController];
    popoverController.delegate = self;
    popoverController.popoverContentSize = contentViewController.view.frame.size;
    popoverController.backgroundColor    = contentViewController.view.backgroundColor;
    [popoverController presentPopoverFromRect:rect inView:view permittedArrowDirections:directions animated:animated];
    [self pushPopoverController:popoverController];
}

- (void)dismissPopoverAnimated:(BOOL)animated
{
    if ([_popoverControllers count] > 0) {
        [[_popoverControllers lastObject] dismissPopoverAnimated:animated];
        [self popPopoverController];
    }
}

- (void)dismissAllPopoversAnimated:(BOOL)animated
{
    while ([_popoverControllers count] > 0) {
        [self dismissPopoverAnimated:animated];
    }
}

- (NSUInteger)numberOfPopovers
{
    return [_popoverControllers count];
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    if ([_popoverControllers count] > 0) {
        while (![[_popoverControllers lastObject] isEqual:popoverController]
               && [_popoverControllers count] > 0) {
            // Dealloc all popovers on the dismissed popover. If there's no object corresponds to caller, all popoverControllers will be dealloced. That case can occur when user taps close button on the contentViewController being presented immediately after tapping outsize of the popover which has it. It's because first tap deallocs the top-most popover controller.
            [[_popoverControllers lastObject] dismissPopoverAnimated:NO];
            [self popPopoverController];
        }
        [self popPopoverController];
    }
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    if ([_popoverControllers count] > 0) {
        if ([popoverController isEqual:[_popoverControllers lastObject]]) {
            popoverController.contentViewController.view.userInteractionEnabled = NO;
            return YES;
        }
    }
    return NO;
}


#pragma mark - Private Instance Methods.
- (void)pushPopoverController:(UIPopoverController *)popoverController
{
    [_popoverControllers addObject:popoverController];
//    NSLog(@"Popover count = %ld", (long)[self numberOfPopovers]);
}

- (void)popPopoverController
{
    [_popoverControllers removeLastObject];
//    NSLog(@"Popover count = %ld", (long)[self numberOfPopovers]);
}

@end
