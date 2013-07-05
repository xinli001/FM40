//
//  HttpClient.h
//  eap
//
//  Created by 黄力强 on 13-6-25.
//  Copyright (c) 2013年 壹 心理. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Encode.h"
#import "ExtType.h"
#import "DataDelegate.h"

@interface HttpClient : NSObject

+(void)get:(NSString *)url handler:(requestHandler)handler;

+(void)get:(NSString *)url jsonHandler:(jsonHandler)handler;

+(void)get:(NSString *)url params:(NSDictionary *)params jsonHandler:(jsonHandler)handler;

+(void)get:(NSString *)url programHandler:(ProgramHandler)programHandler finishHandler:(FinishHandler)finishHandler errorHandler:(ErrorHandler)errorHandler;

+(void)get:(NSString *)url params:(NSDictionary *)params programHandler:(ProgramHandler)programHandler finishHandler:(FinishHandler)finishHandler errorHandler:(ErrorHandler)errorHandler;

+(void)get:(NSString *)url params:(NSDictionary *)params handler:(requestHandler)handler;

+(void)post:(NSString *)url params:(NSDictionary *)params handler:(requestHandler)handler;

+(void)post:(NSString *)url params:(NSDictionary *)params jsonHandler:(jsonHandler)handler;

@end
