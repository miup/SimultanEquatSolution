//
//  TKBSEQuestion.h
//  SimultanEquatSolution
//
//  Created by kazuya on 7/5/14.
//  Copyright (c) 2014 COINS Project AID. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKBSimaltanEquatFormula.h"

@interface TKBSEQuestion : NSObject

@property TKBSimaltanEquatFormula *se1;
@property TKBSimaltanEquatFormula *se2;

@property NSInteger solutionX;
@property NSInteger solutionY;

+ (TKBSEQuestion *)SEQuestionWithMaxCoefficient:(NSInteger)maxCoefficient allowFraction:(BOOL)allowFraction;

- (NSString *)toStringWithNumberOfFormula:(NSInteger)numberOfFormula;

- (void)display;


- (NSDictionary *)multipleFormulaWithNumberOfFormula:(NSUInteger)numberOfFormula multipleNumber:(NSUInteger)multipleNumber;
@end
