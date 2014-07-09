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
    int x = (arc4random() % 19) -9;
    int y = (arc4random() % 19) -9;
    _solutionX = x;
    _solutionY = y;
    NSInteger SE1 = 0;
    NSInteger SE2 = 0;
    do {
        _x1Coefficient = arc4random() % (maxCoefficient * 2 + 1) -maxCoefficient;
        _y1Coefficient = arc4random() % (maxCoefficient * 2 + 1) -maxCoefficient;
        _x2Coefficient = arc4random() % (maxCoefficient * 2 + 1) -maxCoefficient;
        _y2Coefficient = arc4random() % (maxCoefficient * 2 + 1) -maxCoefficient;
        
        _constant1 = _x1Coefficient * _solutionX + _y1Coefficient * _solutionY;
        _constant2 = _x2Coefficient * _solutionX + _y2Coefficient * _solutionY;
        
        SE1 = _x1Coefficient * _solutionX + _y1Coefficient * _solutionY - _constant1;
        SE2 = _x2Coefficient * _solutionX + _y2Coefficient * _solutionY - _constant2;
        
    } while (SE1 != SE2 || _x1Coefficient == 0 || _y1Coefficient == 0 || _x2Coefficient == 0 || _y2Coefficient == 0 || [self isParallelWithMaxCoefficient:maxCoefficient]);
    
    
}

- (void)display
{
    //連立方程式の表示
    NSLog(@"SE1:%ldx + %ldy = %ld", _x1Coefficient, _y1Coefficient, _constant1);
    NSLog(@"SE2:%ldx + %ldy = %ld", _x2Coefficient, _y2Coefficient, _constant2);
    NSLog(@"x = %ld, y = %ld", _solutionX, _solutionY);
    
}

//一致、または平行移動になっているかどうか
- (BOOL) isParallelWithMaxCoefficient:(NSInteger)maxCoefficient
{
    
    for (int i = (int)-maxCoefficient; i < maxCoefficient; i++) {
        for (int j = (int)-maxCoefficient; j < maxCoefficient; j++) {
            if (i * _x1Coefficient == j * _x2Coefficient && i * _y1Coefficient == _y2Coefficient && i != 0 && j != 0) return TRUE;
        }
    }
    return false;
}

@end
