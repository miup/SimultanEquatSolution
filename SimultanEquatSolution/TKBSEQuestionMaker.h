//
//  TKBSEQuestionMaker.h
//  SimultanEquatSolution
//
//  Created by kazuya on 7/5/14.
//  Copyright (c) 2014 COINS Project AID. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKBSEQuestion.h"

typedef enum SEQuestionType {

    SEQuestionTypeAddBack = 0,
    SEQuestionTypeSubstitution
    
} SEQuestionType;


@interface TKBSEQuestionMaker : NSObject

@property NSInteger maxCoefficient;
@property BOOL allowFraction;



+ (TKBSEQuestionMaker *)SEQuestionMakerWithMaxCoefficient:(NSInteger)maxCoefficient allowFraction:(BOOL)allowFraction;
- (TKBSEQuestion *)makeSEQuestion;
@end
