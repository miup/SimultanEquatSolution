//
//  TKBSEQuestion.h
//  SimultanEquatSolution
//
//  Created by kazuya on 7/5/14.
//  Copyright (c) 2014 COINS Project AID. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKBSEQuestion : NSObject

@property NSInteger x1Coefficient;
@property NSInteger y1Coefficient;
@property NSInteger constant1;
@property NSInteger x2Coefficient;
@property NSInteger y2Coefficient;
@property NSInteger constant2;
@property NSInteger solutionX;
@property NSInteger solutionY;


+ (TKBSEQuestion *)SEQuestionWithMaxCoefficient:(NSInteger)maxCoefficient allowFraction:(BOOL)allowFraction;

- (NSString *)toStringWithNumberOfFormula:(NSInteger)numberOfFormula;

- (void)display;

@end
