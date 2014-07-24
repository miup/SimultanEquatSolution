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
    
    _complete = NO;
    
    //３文字以下はありえない
    if (formulaString.length < 3) return;
    
    for (int i = 0; i < formulaString.length; i++) {
        NSString *curChar = [formulaString substringWithRange:NSMakeRange(i, 1)];
        if (i == 0 && [curChar isDigit]) {
            int j = 1;
            while ([[formulaString substringWithRange:NSMakeRange(j, 1)] isDigit]) {
                j++;
            }
            _firstCoefficient = [[formulaString substringWithRange:NSMakeRange(0, j)] integerValue];
            i = i + j;
        }
        
        if (i == 0 && [curChar isEqualToString:@"①"]) _firstFormula = 1;
        if (i == 0 && [curChar isEqualToString:@"②"]) _firstFormula = 2;
        
    }
}

@end
