//
//  NSString+Encode.h
//  eap
//
//  Created by 黄力强 on 13-6-26.
//  Copyright (c) 2013年 壹 心理. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encode)

+(NSString *)urlEncode:(NSDictionary *)params;
-(NSString *)urlEncode:(NSDictionary *)params;

@end
