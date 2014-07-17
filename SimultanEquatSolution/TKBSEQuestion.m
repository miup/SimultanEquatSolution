//
//  TKBSEQuestion.m
//  SimultanEquatSolution
//
//  Created by kazuya on 7/5/14.
//  Copyright (c) 2014 COINS Project AID. All rights reserved.
//

#import "TKBSEQuestion.h"

@interface TKBSEQuestion ()

@end

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
    NSInteger x = arc4random() % (maxCoefficient * 2 + 1) -maxCoefficient;
    NSInteger y = arc4random() % (maxCoefficient * 2 + 1) -maxCoefficient;
    _solutionX = x;
    _solutionY = y;
    NSInteger SE1 = 0;
    NSInteger SE2 = 0;
    
    do {
        NSInteger x1Coefficient = arc4random() % (maxCoefficient * 2 + 1) -maxCoefficient;
        NSInteger y1Coefficient = arc4random() % (maxCoefficient * 2 + 1) -maxCoefficient;
        NSInteger x2Coefficient = arc4random() % (maxCoefficient * 2 + 1) -maxCoefficient;
        NSInteger y2Coefficient = arc4random() % (maxCoefficient * 2 + 1) -maxCoefficient;
        
        NSInteger constant1 = x1Coefficient * _solutionX + y1Coefficient * _solutionY;
        NSInteger constant2 = x2Coefficient * _solutionX + y2Coefficient * _solutionY;
        
        SE1 = x1Coefficient * _solutionX + y1Coefficient * _solutionY - constant1;
        SE2 = x2Coefficient * _solutionX + y2Coefficient * _solutionY - constant2;
        [_se1 setXCoefficient:x1Coefficient yCoefficient:y1Coefficient constant:constant1];
        [_se1 setXCoefficient:x2Coefficient yCoefficient:y2Coefficient constant:constant2];
        
    } while (SE1 != SE2 || _se1.xCoefficient == 0 || _se1.yCoefficient == 0 || _se2.xCoefficient == 0 || _se2.yCoefficient == 0 || [self isParallel]);
    
    
}

- (NSString *)toStringWithNumberOfFormula:(NSInteger)numberOfFormula
{
    switch (numberOfFormula) {
        case 1:
            if (_se1.yCoefficient < 0) return [NSString stringWithFormat:@"%ldx %ldy = %ld", _se1.xCoefficient, _se1.yCoefficient, _se1.constant];
            else                    return [NSString stringWithFormat:@"%ldx + %ldy = %ld", _se1.xCoefficient, _se1.yCoefficient, _se1.constant];
            break;
        case 2:
            if (_se2.yCoefficient < 0) return [NSString stringWithFormat:@"%ldx %ldy = %ld", _se2.xCoefficient, _se2.yCoefficient, _se2.constant];;
            else                    return [NSString stringWithFormat:@"%ldx + %ldy = %ld", _se2.xCoefficient, _se2.yCoefficient, _se2.constant];
            break;
        default:
            return @""; //numberofFormulaがおかしい
            break;
    }
}

- (void)display
{
    //連立方程式の表示
    NSLog(@"SE1:%ldx + %ldy = %ld", _se1.xCoefficient, _se1.yCoefficient, _se1.constant);
    NSLog(@"SE2:%ldx + %ldy = %ld", _se2.xCoefficient, _se2.yCoefficient, _se2.constant);
    NSLog(@"x = %ld, y = %ld", _solutionX, _solutionY);
    
}

//一致、または平行移動になっているかどうか
- (BOOL) isParallel
{
    NSInteger delta = _se1.xCoefficient * _se2.yCoefficient -_se2.xCoefficient * _se1.yCoefficient;
    return delta == 0 ? TRUE : FALSE;
}

- (TKBSimaltanEquatFormula *)multipleFormulaWithNumberOfFormula:(NSUInteger)numberOfFormula multipleNumber:(NSUInteger)multipleNumber
{
    TKBSimaltanEquatFormula *retval = [[TKBSimaltanEquatFormula alloc] init];
    
    
    return retval;
}


@end
