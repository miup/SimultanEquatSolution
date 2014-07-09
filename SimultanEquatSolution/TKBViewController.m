//
//  TKBViewController.m
//  SimultanEquatSolution
//
//  Created by kazuya on 7/3/14.
//  Copyright (c) 2014 COINS Project AID. All rights reserved.
//

#import "TKBViewController.h"
#import "TKBSEQuestionMaker.h"

@interface TKBViewController ()

@end

@implementation TKBViewController {
    TKBSEQuestionMaker *_SEQMaker;
}
 
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _SEQMaker = [TKBSEQuestionMaker SEQuestionMakerWithMaxCoefficient:7 allowFraction:NO];
    TKBSEQuestion *seq = [_SEQMaker makeSEQuestion];
    [seq display];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
