//
//  NSString+isConsistSpecificString.m
//  SimultanEquatSolution
//
//  Created by kazuya on 7/24/14.
//  Copyright (c) 2014 COINS Project AID. All rights reserved.
//

#import "NSString+isConsistSpecificString.h"

@implementation NSString (isConsistSpecificString)

- (BOOL)isDigit
{
    if ([self isEqualToString:@""]) return NO;
    NSCharacterSet *digitCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSCharacterSet *aCharacterSet = [NSCharacterSet characterSetWithCharactersInString:self];
    return [digitCharSet isSupersetOfSet:aCharacterSet];
}

- (BOOL)consistsOf:(NSCharacterSet *)characterSet
{
    if([self isEqualToString:@""]) return NO;
    NSScanner *aScanner = [NSScanner localizedScannerWithString:self];
    [aScanner setCharactersToBeSkipped:nil];
    
    [aScanner scanCharactersFromSet:characterSet intoString:NULL];
    return [aScanner isAtEnd];
}

- (BOOL)isNumberOfFormula
{
    if ([self isEqualToString:@""]) return NO;
    NSCharacterSet *digitCharSet = [NSCharacterSet characterSetWithCharactersInString:@"①②"];
    NSCharacterSet *aCharacterSet = [NSCharacterSet characterSetWithCharactersInString:self];
    return [digitCharSet isSupersetOfSet:aCharacterSet];
}

@end
