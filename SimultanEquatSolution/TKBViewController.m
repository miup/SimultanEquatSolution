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

@interface TKBViewController () <TKBSESolveViewControllerDelegate, TKBSEAnswerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *simaltanEquation1Label;
@property (weak, nonatomic) IBOutlet UILabel *simaltanEquation2Label;
@property (weak, nonatomic) IBOutlet UIView *columnCalcView1;
@property (weak, nonatomic) IBOutlet UIView *columnCalcView2;
@property (weak, nonatomic) IBOutlet UILabel *substitutionLabel;
@property (weak, nonatomic) IBOutlet UILabel *substitutionLabel2;
@property (weak, nonatomic) IBOutlet UIButton *xValueButton;
@property (weak, nonatomic) IBOutlet UIButton *yValueButton;
@property (weak, nonatomic) IBOutlet UIButton *xSubstituteButton;
@property (weak, nonatomic) IBOutlet UIButton *ySubstituteButton;
@property (weak, nonatomic) IBOutlet UILabel *correctOrNotLabel;
@property BOOL isColumnCalc;
@property NSInteger curViewNumber;
@property NSInteger curSubstitutionLabelNum;
@end


@implementation TKBViewController {
    TKBPopoverContext *_answerPopoverContect;
    TKBPopoverContext *_solvePopoverContect;
    TKBSEQuestion *_seq;
    NSArray *_occupiedOrder;
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
    _occupiedOrder = @[@0, @0, @0, @0];
    _curSubstitutionLabelNum = 1;
    _isColumnCalc = YES;
    _correctOrNotLabel.text = @"";
    [_xValueButton setTitle:@"" forState:UIControlStateNormal];
    [_yValueButton setTitle:@"" forState:UIControlStateNormal];
    [_xValueButton.titleLabel setFont:[UIFont systemFontOfSize:40]];
    [_yValueButton.titleLabel setFont:[UIFont systemFontOfSize:40]];
    [[_xValueButton layer]      setBorderWidth:1];
    [[_yValueButton layer]      setBorderWidth:1];
    [[_xValueButton layer]      setBorderColor:[[UIColor blackColor] CGColor]];
    [[_yValueButton layer]      setBorderColor:[[UIColor blackColor] CGColor]];
    _curViewNumber = 1;
    _answerPopoverContect = [TKBPopoverContext sharedPopoverContext];
    _solvePopoverContect  = [TKBPopoverContext sharedPopoverContext];
    _substitutionLabel.text = @"";
    _substitutionLabel2.text = @"";
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

- (IBAction)didTapXValueButton:(id)sender {
    TKBSEAnswerViewController *contentViewController = [[TKBSEAnswerViewController alloc] initWithNibName:NSStringFromClass([TKBSEAnswerViewController class])
                                                                                                   bundle:[NSBundle mainBundle]];
    
    contentViewController.isX = YES;
    contentViewController.delegate = self;
    [_solvePopoverContect presentPopoverWithContentViewController:contentViewController
                                                         fromRect:((UIButton *)sender).frame
                                                           inView:self.view
                                         permittedArrowDirections:UIPopoverArrowDirectionDown
                                                         animated:YES];
    
}

- (IBAction)didTapYValueButton:(id)sender {
    TKBSEAnswerViewController *contentViewController = [[TKBSEAnswerViewController alloc] initWithNibName:NSStringFromClass([TKBSEAnswerViewController class])
                                                                                                   bundle:[NSBundle mainBundle]];
    
    contentViewController.isX = NO;
    contentViewController.delegate = self;
    [_solvePopoverContect presentPopoverWithContentViewController:contentViewController
                                                         fromRect:((UIButton *)sender).frame
                                                           inView:self.view
                                         permittedArrowDirections:UIPopoverArrowDirectionDown
                                                         animated:YES];

}

- (IBAction)didTapXSubstituteButton:(id)sender {
    
    if ([_xValueButton.titleLabel.text isInteger]) {
        switch (_curSubstitutionLabelNum) {
            case 1:
                _substitutionLabel.text = [_seq.se1 toStringSubstitutionToVarIsX:YES substituteNumber:[_xValueButton.titleLabel.text integerValue]];
                _curSubstitutionLabelNum = 2;
                break;
                
            case 2:
                _substitutionLabel2.text = [_seq.se1 toStringSubstitutionToVarIsX:YES substituteNumber:[_xValueButton.titleLabel.text integerValue]];
                _curSubstitutionLabelNum = 1;
            default:
                break;
        }
        _isColumnCalc = NO;
    }
    
    
}

- (IBAction)didTapYSubstituteButton:(id)sender {
    if ([_yValueButton.titleLabel.text isInteger]) {
        switch (_curSubstitutionLabelNum) {
            case 1:
                _substitutionLabel.text = [_seq.se1 toStringSubstitutionToVarIsX:NO substituteNumber:[_yValueButton.titleLabel.text integerValue]];
                _curSubstitutionLabelNum = 2;
                break;
                
            case 2:
                _substitutionLabel2.text = [_seq.se1 toStringSubstitutionToVarIsX:NO substituteNumber:[_yValueButton.titleLabel.text integerValue]];
                _curSubstitutionLabelNum = 1;
            default:
                break;
        }
        _isColumnCalc = NO;
    }
}

- (IBAction)didTapAnswerButton:(id)sender {
    if ([_xValueButton.titleLabel.text integerValue] == _seq.solutionX && [_yValueButton.titleLabel.text integerValue] == _seq.solutionY)
        _correctOrNotLabel.text = @"O";
    else
        _correctOrNotLabel.text = @"X";
}

- (IBAction)didTapBackButton:(id)sender {
    NSLog(@"%@", [_columnCalcView2.subviews firstObject]);
    if (_isColumnCalc) {
        switch (_curViewNumber) {
            case 1:
                if ([_columnCalcView2.subviews count] != 0) {
                    [[_columnCalcView2.subviews firstObject] removeFromSuperview];
                    _curViewNumber = 2;
                }
                break;
                
            case 2:
                [[_columnCalcView1.subviews firstObject] removeFromSuperview];
                _curViewNumber = 1;
                break;
            default:
                break;
        }
    } else {
        switch (_curSubstitutionLabelNum) {
            case 1:
                if (![_substitutionLabel2.text isEqualToString:@""]) {
                    _substitutionLabel2.text = @"";
                    _curSubstitutionLabelNum = 2;
                }
                break;
                
            case 2:
                _substitutionLabel.text = @"";
                _curSubstitutionLabelNum = 1;
                
            default:
                break;
        }
        
        
    }
    
    
}

- (IBAction)didTapNextButton:(id)sender {
    _seq = [TKBSEQuestion SEQuestionWithMaxCoefficient:6 allowFraction:NO];
    [self prepareView];
    [[_columnCalcView1.subviews firstObject] removeFromSuperview];
    [[_columnCalcView2.subviews firstObject] removeFromSuperview];
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
    switch (viewNumber) {
        case 1:
            [[[_columnCalcView1 subviews] firstObject] removeFromSuperview];
            break;
            
        case 2:
            [[[_columnCalcView2 subviews] firstObject] removeFromSuperview];
            break;
            
        default:
            break;
    }
    if (!parser.complete) {
        switch (viewNumber) {
            case 1:
            {
                UILabel *errorLabel = [[UILabel alloc] initWithFrame:_columnCalcView1.bounds];
                errorLabel.textAlignment = NSTextAlignmentCenter;
                errorLabel.text = [NSString stringWithFormat:@"エラー:①×(数字) (+or-) ②×(数字)\nのような形で入力してください"];
                errorLabel.numberOfLines = 2;
                errorLabel.font = [UIFont systemFontOfSize:20];
                [_columnCalcView1 addSubview:errorLabel];
            }
                break;
                
            case 2:
            {
                UILabel *errorLabel = [[UILabel alloc] initWithFrame:_columnCalcView1.bounds];
                errorLabel.textAlignment = NSTextAlignmentCenter;
                errorLabel.text = [NSString stringWithFormat:@"エラー:①×(数字) (+or-) ②×(数字)\nのような形で入力してください"];
                errorLabel.numberOfLines = 2;
                errorLabel.font = [UIFont systemFontOfSize:20];
                [_columnCalcView2 addSubview:errorLabel];
            }
                break;
            default:
                break;
        }
        return;
    }
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
        _curViewNumber = 2;
    } else {
        [_columnCalcView2 addSubview:colmnCalcView];
        _curViewNumber = 1;
    }
    
    _isColumnCalc = YES;
}

- (void)dismissViewController:(TKBSEAnswerViewController *)vc
{
    if (vc.isX) [_xValueButton setTitle:vc.answer forState:UIControlStateNormal];
    else        [_yValueButton setTitle:vc.answer forState:UIControlStateNormal];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
