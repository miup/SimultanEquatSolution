//
//  TKBSEAnswerViewController.m
//  SimultanEquatSolution
//
//  Created by KazuyaMIURA on 7/17/14.
//  Copyright (c) 2014 COINS Project AID. All rights reserved.
//

#import "TKBSEAnswerViewController.h"

@interface TKBSEAnswerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UIView *buttonsView;

@end

@implementation TKBSEAnswerViewController {
    NSInteger _buttonsRow;
    NSInteger _buttonsColumn;
    NSInteger _margin;
    NSMutableArray *_buttons;
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

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.delegate respondsToSelector:@selector(dismissViewController:)]) {
        [self.delegate dismissViewController:self];
    }
}

- (void)prepareViews
{
    _answerLabel.text = @"";
    _margin = 15;
    _buttonsRow = 4;
    _buttonsColumn = 3;
    
    for (int i = 0; i < _buttonsRow; i++) {
        for (int j = 0; j < _buttonsColumn; j++) {
            UIButton *aButton = [[UIButton alloc] init];
            [aButton setFrame:CGRectMake((_buttonsView.bounds.size.width - (_buttonsColumn + 1) * _margin)/_buttonsColumn * j + _margin * (j + 1),
                                         (_buttonsView.bounds.size.height - (_buttonsRow + 1) * _margin)/_buttonsRow * i + _margin * (i + 1),
                                         (_buttonsView.bounds.size.width -(_buttonsColumn + 1) * _margin)/_buttonsColumn,
                                         (_buttonsView.bounds.size.height -(_buttonsRow + 1) * _margin)/_buttonsRow)];
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

- (void)setButtonTitle:(UIButton *)button
{
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    switch (button.tag) {
        case 11:
            [button setTitle:[NSString stringWithFormat:@"7"] forState:UIControlStateNormal];
            break;
        case 12:
            [button setTitle:[NSString stringWithFormat:@"8"] forState:UIControlStateNormal];
            break;
        case 13:
            [button setTitle:[NSString stringWithFormat:@"9"] forState:UIControlStateNormal];
            break;
        case 21:
            [button setTitle:[NSString stringWithFormat:@"4"] forState:UIControlStateNormal];
            break;
        case 22:
            [button setTitle:[NSString stringWithFormat:@"5"] forState:UIControlStateNormal];
            break;
        case 23:
            [button setTitle:[NSString stringWithFormat:@"6"] forState:UIControlStateNormal];
            break;
        case 31:
            [button setTitle:[NSString stringWithFormat:@"1"] forState:UIControlStateNormal];
            break;
        case 32:
            [button setTitle:[NSString stringWithFormat:@"2"] forState:UIControlStateNormal];
            break;
        case 33:
            [button setTitle:[NSString stringWithFormat:@"3"] forState:UIControlStateNormal];
            break;
        case 41:
            [button setTitle:[NSString stringWithFormat:@"C"] forState:UIControlStateNormal];
            break;
        case 42:
            [button setTitle:[NSString stringWithFormat:@"0"] forState:UIControlStateNormal];
            break;
        case 43:
            [button setTitle:[NSString stringWithFormat:@"-"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
    
    
    
    
    
}

- (void)tappedButton:(UIButton *)button
{
    NSString *firstChar;
    if (![_answerLabel.text isEqualToString:@""]) firstChar = [_answerLabel.text substringWithRange:NSMakeRange(0, 1)];
    else firstChar = @"";
    
    switch (button.tag) {
        //0以外の数字
        case 11:
        case 12:
        case 13:
        case 21:
        case 22:
        case 23:
        case 31:
        case 32:
        case 33:
            if (![firstChar isEqualToString:@"0"]) _answerLabel.text = [_answerLabel.text stringByAppendingString:button.titleLabel.text];
            break;
        //C
        case 41:
            if (![_answerLabel.text isEqualToString:@""]) _answerLabel.text = [_answerLabel.text substringWithRange:NSMakeRange(0, _answerLabel.text.length -1)];
            break;
           
        //0
        case 42:
            if (!([firstChar isEqualToString:@"0"] || ([firstChar isEqualToString:@"-"] && _answerLabel.text.length == 1)))
                _answerLabel.text = [_answerLabel.text stringByAppendingString:button.titleLabel.text];
            break;
        
        // -
        case 43:
            if ([_answerLabel.text isEqualToString:@""]) _answerLabel.text = @"-";
            break;
    }
    
    _answer = _answerLabel.text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
