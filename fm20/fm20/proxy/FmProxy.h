//
//  FmProxy.h
//  fm
//
//  Created by 黄力强 on 12-12-24.
//  Copyright (c) 2012年 黄力强. All rights reserved.
//

#import "HttpClient.h"

@interface FmProxy : NSObject

+ (void)getFmList:(NSInteger)offset rows:(NSInteger)rows handler:(requestHandler)handler;
+ (void)incsharenum:(NSInteger)fmid;
+ (void)userLogin:(NSDictionary *)aParams;
+ (void)getFavoriteList:(NSInteger)offset rows:(NSInteger)rows token:(NSString *)token handler:(requestHandler)handler;
+ (void)getFavoriteList:(NSInteger)page pageSize:(NSInteger)pageSize token:(NSString *)token handler:(requestHandler)handler;

@end
