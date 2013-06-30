//
//  NSString+Encode.m
//  eap
//
//  Created by 黄力强 on 13-6-26.
//  Copyright (c) 2013年 壹 心理. All rights reserved.
//

#import "NSString+Encode.h"

@implementation NSString (Encode)

+(NSString *)urlEncode:(NSDictionary *)params {
    if (params == nil) {
        return nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key in [params allKeys]) {
        id obj = [params objectForKey:key];
        if (obj) {
            [array addObject:[NSString stringWithFormat:@"%@=%@",key,obj]];
        }
    }
    return [array componentsJoinedByString:@"&"];
}

-(NSString *)urlEncode:(NSDictionary *)params {
    NSString *query = [NSString urlEncode:params];
    if (query == nil) {
        return self;
    }
    return [NSString stringWithFormat:@"%@?%@", self, query];
}

@end
