//
//  NSString+isConsistSpecificString.h
//  SimultanEquatSolution
//
//  Created by kazuya on 7/24/14.
//  Copyright (c) 2014 COINS Project AID. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (isConsistSpecificString)

// 数字のみで構成されていればYESを戻す
- (BOOL)isDigit;
// characterSetに含まれる文字のみで構成されていればYESを戻す
- (BOOL)consistsOf:(NSCharacterSet *)characterSet;

- (BOOL)isNumberOfFormula;

- (BOOL)isInteger;
@end
