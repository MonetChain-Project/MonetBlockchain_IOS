//
//  AvatarImg.m
//  MonetBlockchain
//
//  Created by Rain on 15/9/11.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.

#import "AvatarImg.h"

@implementation AvatarImg

+ (UIImage *)avatarImgFromAddress:(Address *)address {
    return [self imageNamed:[NSString stringWithFormat:@"avatar-%@.png",[self getNumFromAddress:address]]];
}

+ (NSString *)getNumFromAddress:(Address *)address {
    NSString *str = [address.checksumAddress substringWithRange:NSMakeRange(2,1)];
    if ([str isEqualToString:@"0"]) {
        return @"00";
    } else if ([str isEqualToString:@"1"]) {
        return @"01";
    } else if ([str isEqualToString:@"2"]) {
        return @"02";
    } else if ([str isEqualToString:@"3"]) {
        return @"03";
    } else if ([str isEqualToString:@"4"]) {
        return @"04";
    } else if ([str isEqualToString:@"5"]) {
        return @"05";
    } else if ([str isEqualToString:@"6"]) {
        return @"06";
    } else if ([str isEqualToString:@"7"]) {
        return @"07";
    } else if ([str isEqualToString:@"8"]) {
        return @"08";
    } else if ([str isEqualToString:@"9"]) {
        return @"09";
    } else if ([str isEqualToString:@"a"] || [str isEqualToString:@"A"]) {
        return @"10";
    } else if ([str isEqualToString:@"b"] || [str isEqualToString:@"B"]) {
        return @"11";
    } else if ([str isEqualToString:@"c"] || [str isEqualToString:@"C"]) {
        return @"12";
    } else if ([str isEqualToString:@"d"] || [str isEqualToString:@"D"]) {
        return @"13";
    } else if ([str isEqualToString:@"e"] || [str isEqualToString:@"E"]) {
        return @"14";
    } else if ([str isEqualToString:@"f"] || [str isEqualToString:@"F"]) {
        return @"15";
    } else {
        return @"00";
    }
}

@end
