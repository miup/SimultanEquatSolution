//
//  TKBPopoverContext.h
//  UIPopoverContextSample
//
//  Created by Yusuke Iwama on 2/28/14.
//  Copyright (c) 2014 University of Tsukuba. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 TKBPopoverContext is a stack-based manager of UIPopoverController instances. It presents popover and pushes it to the stack, and pops it when it is dismissed. Poped UIPopoverController instance will be dealloced to prevent it from leaking. When inconsistency in stack occurs, it dismisses all the popovers being presented.
 */
@interface TKBPopoverContext : NSObject <UIPopoverControllerDelegate>

/** Returens singleton shared popover context. */
+ (TKBPopoverContext *)sharedPopoverContext;

/**
 Displays the popover and anchors it to the specified location in the view.
@param contentViewController The view controller which is displays as the content in the popover.
@param rect The rectangle in view at which to anchor the popover window.
@param view The view containing the anchor rectangle for the popover.
@param arrowDirections The arrow directions the popover is permitted to use. You can use this value to force the popover to be positioned on a specific side of the rectangle. However, it is generally better to specify UIPopoverArrowDirectionAny and let the popover decide the best placement. You must not specify UIPopoverArrowDirectionUnknown for this parameter.
@param animated Specify YES to animate the presentation of the popover or NO to display it immediately.
@code
TKBPopoverContext *popoverContext = [TKBPopoverContext sharedPopoverContext];
[popoverContext presentPopoverWithContentViewController:aViewController fromRect:aRect inView:aView permittedArrowDirections:directions animated:animated];
@endcode
 */
- (void)presentPopoverWithContentViewController:(UIViewController *)contentViewController fromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated;

/**
 Dismisses the popover programmatically.

 You can use this method to dismiss the top-most popover on stack programmatically in response to taps inside the popover window.
@code
TKBPopoverContext *popoverContext = [TKBPopoverContext sharedPopoverContext];
[popoverContext dismissPopoverAnimated:animated];
@endcode
 Taps outside of the popover’s contents automatically dismiss the popover.
@param animated Specify YES to animate the dismissal of the popover or NO to dismiss it immediately.
*/
- (void)dismissPopoverAnimated:(BOOL)animated;


/**
 Dismisses all the popovers in context's stack programmatically.
 
 You can use this method to dismiss all the popovers in stack programmatically in response to taps inside the popover window.
 @code
 TKBPopoverContext *popoverContext = [TKBPopoverContext sharedPopoverContext];
 [popoverContext dismissAllPopoversAnimated:animated];
 @endcode
 Taps outside of the popover’s contents automatically dismiss the popover.
 @param animated Specify YES to animate the dismissal of the popover or NO to dismiss it immediately.
 */
- (void)dismissAllPopoversAnimated:(BOOL)animated;

/**
 Returns the number of UIPopoverController controler instances in context's stack.
@return The number of UIPopoverController instances in context's stack.
 */
- (NSUInteger)numberOfPopovers;

@end
