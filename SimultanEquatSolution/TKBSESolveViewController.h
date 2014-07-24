//
//  TKBSESolveViewController.h
//  SimultanEquatSolution
//
//  Created by KazuyaMIURA on 7/17/14.
//  Copyright (c) 2014 COINS Project AID. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+isConsistSpecificString.h"

@protocol TKBSESolveViewControllerDelegate;

@interface TKBSESolveViewController : UIViewController

@property (nonatomic, weak) id <TKBSESolveViewControllerDelegate> delegate;
@property NSString *formulaString;

@end


@protocol TKBSESolveViewControllerDelegate <NSObject>

- (void)didTappetReturnButton:(TKBSESolveViewController *)vc;


@end