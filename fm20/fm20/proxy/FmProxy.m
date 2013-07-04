//
//  FmProxy.m
//  fm
//
//  Created by 黄力强 on 12-12-24.
//  Copyright (c) 2012年 黄力强. All rights reserved.
//

#import "FmProxy.h"

static const NSString *baseUrl = @"http://bapi.xinli001.com/";
static const NSString *appKey = @"fa3d93e222340a2e4e9dcbba527ce6a4";

@implementation FmProxy

+ (void)getFmList:(NSInteger)offset rows:(NSInteger)rows handler:(requestHandler)handler {
    NSString *url = [NSString stringWithFormat:@"%@fm/broadcasts.json/", baseUrl];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[NSString stringWithFormat:@"%d", offset] forKey:@"offset"];
    [params setValue:[NSString stringWithFormat:@"%d", rows] forKey:@"rows"];
    [params setValue:appKey forKey:@"key"];
    [HttpClient get:url params:params handler:handler];
}

+ (void)incsharenum:(NSInteger)fmid {
    NSString *url = [NSString stringWithFormat:@"%@fm/incsharenum.json/", baseUrl];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[NSString stringWithFormat:@"%d", fmid] forKey:@"id"];
    [params setValue:appKey forKey:@"key"];
    [HttpClient get:url params:params handler:nil];
}

+ (void)userLogin:(NSDictionary *)aParams handler:(requestHandler)handler {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:aParams];
    NSString *url = [NSString stringWithFormat:@"%@users/get_token.json/", baseUrl];
    [params setValue:appKey forKey:@"key"];
    [HttpClient post:url params:params handler:handler];
}

+ (void)getFavoriteList:(NSInteger)offset rows:(NSInteger)rows token:(NSString *)token handler:(requestHandler)handler {
    NSString *url = [NSString stringWithFormat:@"%@users/fm_favs.json/", baseUrl];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[NSString stringWithFormat:@"%d", offset] forKey:@"offset"];
    [params setValue:[NSString stringWithFormat:@"%d", rows] forKey:@"rows"];
    [params setValue:appKey forKey:@"key"];
    [params setValue:token forKey:@"token"];
    [HttpClient get:url params:params handler:handler];
}

+ (void)getFavoriteList:(NSInteger)page pageSize:(NSInteger)pageSize token:(NSString *)token handler:(requestHandler)handler {
    NSInteger offset = (page - 1) * pageSize;
    NSString *url = [NSString stringWithFormat:@"%@users/fm_favs.json/", baseUrl];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[NSString stringWithFormat:@"%d", offset] forKey:@"offset"];
    [params setValue:[NSString stringWithFormat:@"%d", pageSize] forKey:@"rows"];
    [params setValue:appKey forKey:@"key"];
    [params setValue:token forKey:@"token"];
    [HttpClient get:url params:params handler:handler];
}

@end
