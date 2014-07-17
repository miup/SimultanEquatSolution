//
//  TKBSimaltanEquatFormula.h
//  SimultanEquatSolution
//
//  Created by kazuya on 7/17/14.
//  Copyright (c) 2014 COINS Project AID. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKBSimaltanEquatFormula : NSObject

@property NSInteger xCoefficient;
@property NSInteger yCoefficient;
@property NSInteger constant;

- (void)setXCoefficient:(NSInteger)xCoefficient yCoefficient:(NSInteger)yCoefficient constant:(NSInteger)constant;
-(TKBSimaltanEquatFormula *)multipleFormulaWithMultipleNumber:(NSInteger)multipleNumber;
- (void)display;


@end
