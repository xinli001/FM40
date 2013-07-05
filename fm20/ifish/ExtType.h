//
//  ExtType.h
//  eap
//
//  Created by 黄力强 on 13-6-26.
//  Copyright (c) 2013年 壹 心理. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^requestHandler)(NSURLResponse *response, NSData *data, NSError *error);
typedef void(^jsonHandler)(NSURLResponse *response, NSDictionary *dict, NSError *error);

@interface ExtType : NSObject

@end
