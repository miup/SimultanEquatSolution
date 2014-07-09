//
//  TKBSEQuestionMaker.m
//  SimultanEquatSolution
//
//  Created by kazuya on 7/5/14.
//  Copyright (c) 2014 COINS Project AID. All rights reserved.
//

#import "TKBSEQuestionMaker.h"

@implementation TKBSEQuestionMaker {
    NSInteger _maxCoefficient;
    BOOL _allowFraction;
}

- (TKBSEQuestionMaker *)initWithMaxCoefficient:(NSInteger)maxCoefficient allowFraction:(BOOL)allowFraction
{
    self = [super init];
    if (self) {
        _maxCoefficient = maxCoefficient;
        _allowFraction  = allowFraction;
    }
    return  self;
}

+ (TKBSEQuestionMaker *)SEQuestionMakerWithMaxCoefficient:(NSInteger)maxCoefficient allowFraction:(BOOL)allowFraction
{
    return [[TKBSEQuestionMaker alloc] initWithMaxCoefficient:maxCoefficient allowFraction:allowFraction];
}


- (TKBSEQuestion *)makeSEQuestion
{
    return [TKBSEQuestion SEQuestionWithMaxCoefficient:_maxCoefficient allowFraction:_maxCoefficient];
}


@end
