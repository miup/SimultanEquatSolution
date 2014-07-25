//
//  TKBSEAnswerViewController.h
//  SimultanEquatSolution
//
//  Created by KazuyaMIURA on 7/17/14.
//  Copyright (c) 2014 COINS Project AID. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TKBSEAnswerViewControllerDelegate;


@interface TKBSEAnswerViewController : UIViewController

@property (weak, nonatomic) id <TKBSEAnswerViewControllerDelegate> delegate;
@property NSString *answer;
@property BOOL isX;

@end


@protocol TKBSEAnswerViewControllerDelegate <NSObject>

- (void)dismissViewController:(TKBSEAnswerViewController *)vc;

@end