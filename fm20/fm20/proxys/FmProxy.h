//
//  FmProxy.h
//  fm
//
//  Created by 黄力强 on 12-12-24.
//  Copyright (c) 2012年 黄力强. All rights reserved.
//

#import "HttpClient.h"

@interface FmProxy : NSObject

+ (void)getFmList:(NSInteger)offset rows:(NSInteger)rows handler:(jsonHandler)handler;
+ (void)incsharenum:(NSInteger)fmid;
+ (void)userLogin:(NSDictionary *)aParams handler:(jsonHandler)handler ;
+ (void)getFavoriteList:(NSInteger)offset rows:(NSInteger)rows token:(NSString *)token handler:(jsonHandler)handler;
+ (void)getFavoriteList:(NSInteger)page pageSize:(NSInteger)pageSize token:(NSString *)token handler:(jsonHandler)handler;
+ (void)addFavorite:(NSInteger)fmid token:(NSString *)token handler:(jsonHandler)handler;
+ (void)checkFavorite:(NSInteger)fmid token:(NSString *)token handler:(jsonHandler)handler;
+ (void)deleteFavorite:(NSInteger)fmid token:(NSString *)token handler:(jsonHandler)handler;
+ (void)addtoken:(NSString *)token handler:(jsonHandler)handler;
+ (void)registerUser:(NSDictionary *)aParams handler:(jsonHandler)handler;

@end
