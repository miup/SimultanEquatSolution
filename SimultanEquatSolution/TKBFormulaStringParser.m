//
//  TKBFormulaStringParser.m
//  SimultanEquatSolution
//
//  Created by kazuya on 7/24/14.
//  Copyright (c) 2014 COINS Project AID. All rights reserved.
//

#import "TKBFormulaStringParser.h"
#import "NSString+isConsistSpecificString.h"

@implementation TKBFormulaStringParser

- (void)parseWithFormulaString:(NSString *)formulaString
{
    _firstCoefficient  = 1;
    _secondCoefficient = 1;
    
    NSInteger multiCount = 0;
    NSInteger addOrSubCount = 0;
 
    NSLog(@"%@", formulaString);
    _complete = NO;
    
    //３文字以下はありえない
    if (formulaString.length < 3) return;
    
    for (int i = 0; i < formulaString.length; i++) {
        
        NSString *curChar = [formulaString substringWithRange:NSMakeRange(i, 1)];
        NSLog(@"%@", curChar);
        if ([curChar isDigit] && _addOrSubstruct == 0) {
            int j = i;
            do {
                j++;
            } while (j < formulaString.length && [[formulaString substringWithRange:NSMakeRange(j, 1)] isDigit]);
            NSLog(@"first:%@", [formulaString substringWithRange:NSMakeRange(i, j -i)]);
            _firstCoefficient = [[formulaString substringWithRange:NSMakeRange(i, j -i)] integerValue];
            i = j -1;
            continue;
        }
        
        //firstFormulaに何も入っていない状態で丸数字が来たらそのまま代入
        if ([curChar isEqualToString:@"①"] && _firstFormula == 0) {
            _firstFormula = 1;
            continue;
        }
        if ([curChar isEqualToString:@"②"] && _firstFormula == 0) {
            _firstFormula = 2;
            continue;
        }
        
        
        //①*3 - ①*2 などを省くために①と②がどちらも出ていることを確認
        if ([curChar isEqualToString:@"①"] && _firstFormula == 2) _secondFormula = 1;
        if ([curChar isEqualToString:@"②"] && _firstFormula == 1) _secondFormula = 2;
        
        //同じ式を②回使っていたらbreak;
        if ([curChar isEqualToString:@"①"] && _firstFormula == 1) break;
        if ([curChar isEqualToString:@"②"] && _firstFormula == 2) break;
        
        if ([curChar isDigit] && _addOrSubstruct != 0) {
            int j = i;
            do {
                j++;
            } while (j < formulaString.length && [[formulaString substringWithRange:NSMakeRange(j, 1)] isDigit]);
            NSLog(@"second:%@", [formulaString substringWithRange:NSMakeRange(i, j -i)]);
            _secondCoefficient = [[formulaString substringWithRange:NSMakeRange(i, j -i)] integerValue];
            i = j -1;
            if (i == formulaString.length -1) break;
        }
        
        if ([curChar isEqualToString:@"+"]) {
            _addOrSubstruct = addOrSubtractAdd;
            addOrSubCount++;
        }
        if ([curChar isEqualToString:@"-"]) {
            _addOrSubstruct = addOrSubtractSubstruct;
            addOrSubCount++;
        }
        
        if ([curChar isEqualToString:@"×"]) multiCount++;
        
    }
    _complete = [self isComplete];
    if (multiCount > 2) _complete = NO;
    if (addOrSubCount > 1) _complete = NO;
}

- (BOOL) isComplete
{
    if (_firstCoefficient == 0) return NO;
    if (_secondCoefficient == 0) return NO;
    if (_firstFormula == 0) return NO;
    if (_secondFormula == 0) return NO;
    if (_addOrSubstruct == 0) return NO;
    
    return YES;
}

- (void)display
{
    if (_complete == NO) {
        NSLog(@"不正な入力orパース失敗");
    }
    
    NSString *addOrSub = @"";
    if (_addOrSubstruct == addOrSubtractAdd) addOrSub = @"+";
    else if (_addOrSubstruct == addOrSubtractSubstruct) addOrSub = @"-";
    
    NSLog(@"%ld * %ld %@ %ld * %ld", _firstCoefficient, _firstFormula, addOrSub, _secondCoefficient, _secondFormula);
    
}


@end
