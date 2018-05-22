//
//  NAPersonalDataBase.h
//  MonetBlockchain
//
//  Created by Rain on 15/9/11.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.

#import <Foundation/Foundation.h>

#import "NAUserModel.h"

typedef void(^LoadAllDataComplete)(NSArray *dataArray);
typedef void(^LoadSigleDataComplete)(NAUserModel *model, NSString *error);

@interface NAPersonalDataBase : NSObject

+ (instancetype)sharedInstance;

- (void)getUserDataWithAddress:(NSString *)u_address complete:(LoadSigleDataComplete)complete;

- (void)insertUserDataWithModel:(NAUserModel *)model insertResult:(void(^)(BOOL result))insertResult;

- (void)updateUserDataWithModel:(NAUserModel *)model updateResult:(void(^)(BOOL result))updateResult;

- (void)deleteUserDataWithAddress:(NSString *)u_address deleteResult:(void(^)(BOOL result))deleteResult;

@end
