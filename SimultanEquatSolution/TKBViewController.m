//
//  TKBViewController.m
//  SimultanEquatSolution
//
//  Created by kazuya on 7/3/14.
//  Copyright (c) 2014 COINS Project AID. All rights reserved.
//

#import "TKBViewController.h"
#import "TKBSEQuestion.h"
#import "TKBPopoverContext.h"
#import "TKBSESolveViewController.h"
#import "TKBSEAnswerViewController.h"

@interface TKBViewController ()
@property (weak, nonatomic) IBOutlet UILabel *simaltanEquation1Label;
@property (weak, nonatomic) IBOutlet UILabel *simaltanEquation2Label;

@end

@implementation TKBViewController {
    
}
 
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    TKBSEQuestion *seq = [TKBSEQuestion SEQuestionWithMaxCoefficient:6 allowFraction:NO];
    [seq display];
    _simaltanEquation1Label.text = [seq toStringWithNumberOfFormula:1];
    _simaltanEquation2Label.text = [seq toStringWithNumberOfFormula:2];

    [[seq.se1 multipleFormulaWithMultipleNumber:3] display];
    
}

- (IBAction)didTapSolveButton:(id)sender
{
    //加減法用のポップオーバーの表示
    TKBPopoverContext *solvePopoverContext = [TKBPopoverContext sharedPopoverContext];
    [solvePopoverContext presentPopoverWithContentViewController:[[TKBSESolveViewController alloc] initWithNibName:NSStringFromClass([TKBSESolveViewController class]) bundle:[NSBundle mainBundle]]
                                                                                                          fromRect:((UIButton *)sender).frame
                                                                                                            inView:self.view
                                                                                          permittedArrowDirections:UIPopoverArrowDirectionDown
                                                                                                          animated:YES];
}

- (IBAction)didTapAnswerButton:(id)sender
{
    //解答用のポップオーバーの表示
    TKBPopoverContext *answerPopoverContect = [TKBPopoverContext sharedPopoverContext];
    [answerPopoverContect presentPopoverWithContentViewController:[[TKBSEAnswerViewController alloc] initWithNibName:NSStringFromClass([TKBSEAnswerViewController class]) bundle:[NSBundle mainBundle]]
                                                                                                            fromRect:((UIButton *)sender).frame
                                                                                                              inView:self.view
                                                                                            permittedArrowDirections:UIPopoverArrowDirectionDown
                                                                                                            animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
