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
#import "TKBFormulaStringParser.h"
#import "TKBSEColumnCalcView.h"

@interface TKBViewController () <TKBSESolveViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *simaltanEquation1Label;
@property (weak, nonatomic) IBOutlet UILabel *simaltanEquation2Label;
@property (weak, nonatomic) IBOutlet UIView *columnCalcView1;
@property (weak, nonatomic) IBOutlet UIView *columnCalcView2;
@property (weak, nonatomic) IBOutlet UILabel *substitutionLabel;
@property NSInteger curViewNumber;

@end

@implementation TKBViewController {
    TKBPopoverContext *_answerPopoverContect;
    TKBPopoverContext *_solvePopoverContect;
    TKBSEQuestion *_seq;
}
 
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _seq = [TKBSEQuestion SEQuestionWithMaxCoefficient:6 allowFraction:NO];
    [self prepareView];
}

- (void)prepareView
{
    _curViewNumber = 1;
    _answerPopoverContect = [TKBPopoverContext sharedPopoverContext];
    _solvePopoverContect  = [TKBPopoverContext sharedPopoverContext];
    _substitutionLabel.text = @"";
    _simaltanEquation1Label.text = [NSString stringWithFormat:@"%@ ...①", [_seq toStringWithNumberOfFormula:1]];
    _simaltanEquation2Label.text = [NSString stringWithFormat:@"%@ ...②", [_seq toStringWithNumberOfFormula:2]];
    [_seq display];
}

- (IBAction)didTapSolveButton:(id)sender
{
    //加減法用のポップオーバーの表示
    TKBSESolveViewController *contentViewController = [[TKBSESolveViewController alloc] initWithNibName:NSStringFromClass([TKBSESolveViewController class])
                                                                                                 bundle:[NSBundle mainBundle]];
    contentViewController.delegate = self;
    
    [_solvePopoverContect presentPopoverWithContentViewController:contentViewController
                                                         fromRect:((UIButton *)sender).frame
                                                           inView:self.view
                                         permittedArrowDirections:UIPopoverArrowDirectionDown
                                                         animated:YES];
}

- (IBAction)didTapAnswerButton:(id)sender
{
    //解答用のポップオーバーの表示
    TKBSEAnswerViewController *contentViewController = [[TKBSEAnswerViewController alloc] initWithNibName:NSStringFromClass([TKBSEAnswerViewController class])
                                                                                                   bundle:[NSBundle mainBundle]];
    [_answerPopoverContect presentPopoverWithContentViewController:contentViewController
                                                          fromRect:((UIButton *)sender).frame
                                                            inView:self.view
                                          permittedArrowDirections:UIPopoverArrowDirectionDown
                                                          animated:YES];
    
    
}

- (void)didTappetReturnButton:(TKBSESolveViewController *)vc
{
    TKBFormulaStringParser *parser = [[TKBFormulaStringParser alloc] init];
    [parser parseWithFormulaString:vc.formulaString];
    [parser display];
    [_solvePopoverContect dismissAllPopoversAnimated:YES];
    TKBSimaltanEquatFormula *calculatedFormula = [_seq calcAddSubWithParser:parser];
    [calculatedFormula display];
    [self drawColmnCalcViewWithViewNumber:_curViewNumber parser:parser];
    
}

- (void)drawColmnCalcViewWithViewNumber:(NSInteger)viewNumber parser:(TKBFormulaStringParser *)parser
{
    TKBSEColumnCalcView *colmnCalcView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TKBSEColumnCalcView class]) owner:self options:nil] firstObject];
    TKBSimaltanEquatFormula *first = [[TKBSimaltanEquatFormula alloc] init];
    TKBSimaltanEquatFormula *second = [[TKBSimaltanEquatFormula alloc] init];
    
    if (parser.addOrSubstruct == addOrSubtractAdd) colmnCalcView.addOrSubLabel.text = @"+";
    else                                           colmnCalcView.addOrSubLabel.text = @"-";
    
    if (parser.firstFormula == 1) {
        first  = [_seq.se1 multipleFormulaWithMultipleNumber:parser.firstCoefficient];
        second = [_seq.se2 multipleFormulaWithMultipleNumber:parser.secondCoefficient];
    } else {
        first  = [_seq.se2 multipleFormulaWithMultipleNumber:parser.firstCoefficient];
        second = [_seq.se1 multipleFormulaWithMultipleNumber:parser.secondCoefficient];
    }
    
    colmnCalcView.formula1Label.text = [first toString];
    colmnCalcView.formula2Label.text = [second toString];
    colmnCalcView.resultLabel.text   = [[_seq calcAddSubWithParser:parser] toString];
    
    if (viewNumber == 1) {
        [_columnCalcView1 addSubview:colmnCalcView];
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
