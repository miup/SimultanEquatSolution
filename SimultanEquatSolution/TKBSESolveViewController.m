//
//  TKBSESolveViewController.m
//  SimultanEquatSolution
//
//  Created by KazuyaMIURA on 7/17/14.
//  Copyright (c) 2014 COINS Project AID. All rights reserved.
//

#import "TKBSESolveViewController.h"

@interface TKBSESolveViewController ()
@property (weak, nonatomic) IBOutlet UILabel *formulaLabel;
@property (weak, nonatomic) IBOutlet UIView *buttonsView;

@end

@implementation TKBSESolveViewController {
    NSMutableArray *_buttons;
    int _margin;
    NSInteger _buttonsRow;
    NSInteger _buttonsColumn;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self prepareViews];
}

- (void)prepareViews
{
    _margin = 10;
    _buttonsColumn = 5;
    _buttonsRow    = 4;
    
    //数式ラベルの文字を初期化
    _formulaLabel.text = @"";
    
    //superview:ボタンを乗せるview
    for (int i = 0; i < _buttonsRow; i++) {
        for (int j = 0; j < _buttonsColumn; j++) {
            UIButton *aButton = [[UIButton alloc] init];
            if ((i == 2 && j == 3) || (i == 0 && j == 3) || (i == 2 && j == 4)) {
                //確定ボタンの作成
                [aButton setFrame:CGRectMake((_buttonsView.bounds.size.width - 3 * _margin)/_buttonsColumn * j + _margin * j,
                                             (_buttonsView.bounds.size.height - 4 * _margin)/_buttonsRow * i + _margin * i,
                                             (_buttonsView.bounds.size.width -3 * _margin)/_buttonsColumn,
                                             (_buttonsView.bounds.size.height -4 * _margin)/_buttonsRow * 2 + _margin)];
            } else if ((i == 3 && j == 3) || (i == 1 && j == 3) || (i == 3 && j == 4)) {
                continue;
            }
            else {
                [aButton setFrame:CGRectMake((_buttonsView.bounds.size.width - 3 * _margin)/_buttonsColumn * j + _margin * j,
                                             (_buttonsView.bounds.size.height - 4 * _margin)/_buttonsRow * i + _margin * i,
                                             (_buttonsView.bounds.size.width -3 * _margin)/_buttonsColumn,
                                             (_buttonsView.bounds.size.height -4 * _margin)/_buttonsRow)];
            }
            aButton.tag = (i + 1) * 10 + (j + 1);
            [_buttons addObject:aButton];
            [[aButton layer] setBorderColor:[[UIColor blackColor] CGColor]];
            [[aButton layer] setBorderWidth:1];
            [_buttonsView addSubview:aButton];
            [aButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
            [self setButtonTitle:aButton];
            [aButton.titleLabel setFont:[UIFont systemFontOfSize:30]];
        }
    }
}

- (void)tappedButton:(UIButton *)button
{
    NSString *lastChar = @"";
    if (![_formulaLabel.text isEqualToString:@""]) lastChar = [_formulaLabel.text substringWithRange:NSMakeRange(_formulaLabel.text.length -1, 1)];
    switch (button.tag) {
    
        //数字ボタン
        case 41:
        case 42:
        case 43:
        case 31:
        case 32:
        case 33:
        case 21:
        case 22:
        case 23:
            if (![lastChar isNumberOfFormula])
                _formulaLabel.text = [_formulaLabel.text stringByAppendingString:button.titleLabel.text];
            break;
            
        //演算子ボタン
        case 11:
        case 12:
        case 13:
            if (![_formulaLabel.text isEqualToString:@""] && ([lastChar isDigit] || [lastChar isNumberOfFormula]))
                _formulaLabel.text = [_formulaLabel.text stringByAppendingString:button.titleLabel.text];
            break;
            
        //数式番号ボタン
        case 14:
            if(![lastChar isNumberOfFormula] && ![lastChar isDigit])
                 _formulaLabel.text = [_formulaLabel.text stringByAppendingString:@"①"];
            break;
        case 34:
            if(![lastChar isNumberOfFormula] && ![lastChar isDigit])
                _formulaLabel.text = [_formulaLabel.text stringByAppendingString:@"②"];
            break;
        
        //AC
        case 15:
            _formulaLabel.text = @"";
            break;
            
        //C
        case 25:
            if (![_formulaLabel.text isEqualToString:@""]) _formulaLabel.text = [_formulaLabel.text substringWithRange:NSMakeRange(0, _formulaLabel.text.length -1)];
            break;
        //return
        case 35:
            [self didTappedReturnBtton];
            break;
        default:
            break;
    }
}

- (void)setButtonTitle:(UIButton *)button
{
    [button setTitle:[NSString stringWithFormat:@"%ld", button.tag] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    switch (button.tag) {
        case 11:
            [button setTitle:[NSString stringWithFormat:@"+"] forState:UIControlStateNormal];
            break;
        case 12:
            [button setTitle:[NSString stringWithFormat:@"-"] forState:UIControlStateNormal];
            break;
        case 13:
            [button setTitle:[NSString stringWithFormat:@"×"] forState:UIControlStateNormal];
            break;
        case 15:
            [button setTitle:[NSString stringWithFormat:@"AC"] forState:UIControlStateNormal];
            break;
        case 21:
            [button setTitle:[NSString stringWithFormat:@"7"] forState:UIControlStateNormal];
            break;
        case 22:
            [button setTitle:[NSString stringWithFormat:@"8"] forState:UIControlStateNormal];
            break;
        case 23:
            [button setTitle:[NSString stringWithFormat:@"9"] forState:UIControlStateNormal];
            break;
        case 25:
            [button setTitle:[NSString stringWithFormat:@"C"] forState:UIControlStateNormal];
            break;
        case 31:
            [button setTitle:[NSString stringWithFormat:@"4"] forState:UIControlStateNormal];
            break;
        case 32:
            [button setTitle:[NSString stringWithFormat:@"5"] forState:UIControlStateNormal];
            break;
        case 33:
            [button setTitle:[NSString stringWithFormat:@"6"] forState:UIControlStateNormal];
            break;
        case 41:
            [button setTitle:[NSString stringWithFormat:@"1"] forState:UIControlStateNormal];
            break;
        case 42:
            [button setTitle:[NSString stringWithFormat:@"2"] forState:UIControlStateNormal];
            break;
        case 43:
            [button setTitle:[NSString stringWithFormat:@"3"] forState:UIControlStateNormal];
            break;
        case 35:
            [button setTitle:[NSString stringWithFormat:@"Return"] forState:UIControlStateNormal];
            break;
        case 14:
            [button setTitle:[NSString stringWithFormat:@"①式"] forState:UIControlStateNormal];
            break;
        case 34:
            [button setTitle:[NSString stringWithFormat:@"②式"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
}

- (void)didTappedReturnBtton
{
    if ([self.delegate respondsToSelector:@selector(didTappetReturnButton:)]) {
        [self.delegate didTappetReturnButton:self];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
