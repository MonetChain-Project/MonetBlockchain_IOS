//
//  NATModel.h
//  NAToken
//
//  Created by Rain on 17/8/2.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NATModel : NSObject

@property (nonatomic, strong) NSString *imgName;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *price;

- (id)initWithDict:(NSDictionary *)dict;

@end
