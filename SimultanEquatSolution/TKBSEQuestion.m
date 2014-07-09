//
//  TKBSEQuestion.m
//  SimultanEquatSolution
//
//  Created by kazuya on 7/5/14.
//  Copyright (c) 2014 COINS Project AID. All rights reserved.
//

#import "TKBSEQuestion.h"

@implementation TKBSEQuestion


- (TKBSEQuestion *)initWithMaxCoefficient:(NSInteger)maxCoefficient allowFraction:(BOOL)allowFraction
{
    self = [super init];
    if (self) {
        //方程式の作成
        [self makeSEQuestionWithMaxCoefficient:maxCoefficient allowFraction:allowFraction];
    }
    return self;
}

+ (TKBSEQuestion *)SEQuestionWithMaxCoefficient:(NSInteger)maxCoefficient allowFraction:(BOOL)allowFraction
{
    return [[TKBSEQuestion alloc] initWithMaxCoefficient:maxCoefficient allowFraction:allowFraction];
}

- (void)makeSEQuestionWithMaxCoefficient:(NSInteger)maxCoefficient allowFraction:(BOOL)allowFraction
{
    // 解として-9~9までのランダムの数値を作成
    _solutionX = arc4random() % 19 -9;
    _solutionY = arc4random() % 19 -9;
    NSInteger SE1 = 0;
    NSInteger SE2 = 0;
    do {
        _x1Coefficient = arc4random() % (maxCoefficient * 2 + 1) -maxCoefficient;
        _y1Coefficient = arc4random() % (maxCoefficient * 2 + 1) -maxCoefficient;
        _x2Coefficient = arc4random() % (maxCoefficient * 2 + 1) -maxCoefficient;
        _y2Coefficient = arc4random() % (maxCoefficient * 2 + 1) -maxCoefficient;
        
        _constant1 = arc4random() % (maxCoefficient * 2 + 1) -maxCoefficient;
        _constant2 = arc4random() % (maxCoefficient * 2 + 1) -maxCoefficient;
        
        SE1 = _x1Coefficient * _solutionX + _y1Coefficient * _solutionY - _constant1;
        SE2 = _x2Coefficient * _solutionX + _y2Coefficient * _solutionY - _constant2;
        
    } while (SE1 != SE2);
    
    
}

- (void)display
{
    //途中　連立方程式の表示
    NSLog(@"%ld x + ", _x1Coefficient);
    
    
}

@end
