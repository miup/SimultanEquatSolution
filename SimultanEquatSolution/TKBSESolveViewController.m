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
    _margin = 15;
    
    //superview:ボタンを乗せるview
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 3; j++) {
            UIButton *aButton = [[UIButton alloc] initWithFrame:CGRectMake((_buttonsView.bounds.size.width - 2 * _margin)/3 * j + _margin * j,
                                                                           (_buttonsView.bounds.size.height - 4 * _margin)/5 * i + _margin * i,
                                                                           (_buttonsView.bounds.size.width -2 * _margin)/3,
                                                                           (_buttonsView.bounds.size.height -4 * _margin)/5)];
            aButton.tag = (i + 1) * 10 + (j + 1);
            [_buttons addObject:aButton];
            [[aButton layer] setBorderColor:[[UIColor blackColor] CGColor]];
            [[aButton layer] setBorderWidth:1];
            [_buttonsView addSubview:aButton];
            [aButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
            [aButton setTitle:[NSString stringWithFormat:@"%ld", aButton.tag] forState:UIControlStateNormal];
            [aButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}

- (void)tappedButton:(UIButton *)button
{
    
}

- (void)setButtonTitle:(UIButton *)button
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
