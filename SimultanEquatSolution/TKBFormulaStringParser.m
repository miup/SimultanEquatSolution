//
//  TKBFormulaStringParser.m
//  SimultanEquatSolution
//
//  Created by kazuya on 7/24/14.
//  Copyright (c) 2014 COINS Project AID. All rights reserved.
//

#import "TKBFormulaStringParser.h"

@implementation TKBFormulaStringParser


- (void)parseWithFormulaString:(NSString *)formulaString
{
    _complete = NO;
    
    //３文字以下はありえない
    if (formulaString.length < 3) return;
    
    for (int i = 0; i < formulaString.length; i++) {
        NSString *curChar = [formulaString substringWithRange:NSMakeRange(i, 0)];
    }
    
}

@end
