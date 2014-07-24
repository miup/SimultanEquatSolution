//
//  TKBFormulaStringParser.h
//  SimultanEquatSolution
//
//  Created by kazuya on 7/24/14.
//  Copyright (c) 2014 COINS Project AID. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum addOrSubtract {
    addOrSubtractAdd = 1,
    addOrSubtractSubstruct = -1
} addOrSubtract;

@interface TKBFormulaStringParser : NSObject

- (void)parseWithFormulaString:(NSString *)formulaString;
- (void)display;

@property NSInteger firstFormula;
@property NSInteger secondFormula;
@property NSInteger firstCoefficient;
@property NSInteger secondCoefficient;
@property addOrSubtract addOrSubstruct;
@property BOOL complete;

@end
