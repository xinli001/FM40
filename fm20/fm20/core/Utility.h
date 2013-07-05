//
//  Utility.h
//  fm
//
//  Created by 黄力强 on 12-12-22.
//  Copyright (c) 2012年 黄力强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface Utility : NSObject

+(NSString *)urlEncode:(NSDictionary *)params;
+(NSString *)urlEncode:(NSString *)url params:(NSDictionary *)params;
+(NSString *)URLEncodedString:(NSString *)string;
+(NSString *)getDocumentDirectory;
+(NSData *)loadFromDocumentDirectory:(NSString *)filename;
+(BOOL)writeToDocumentDirectory:(NSString *)filename data:(NSData *)data;
+(NSData *)loadFromBundleDirectory:(NSString *)filename;
+(NSString *)getBundleDirectory;
+(NSURL *)getBundleResource:(NSString *)filename extension:(NSString *)extension;
+(NSString *)toClockFormat:(NSInteger)val;
+(id)dataToJsonObj:(NSData *)data;
+(NSData *)dictToJsonData:(NSDictionary *)dict;
+(UIColor *)blueColor;
+(UIColor *)tableBgColor;
+(UIColor *)lgrayColor;
+(NSString *)dictToJsonString:(NSDictionary *)dict slug:(BOOL)slug;
+(NSString *)dictArrayToJsonString:(NSArray *)_array;
+(NSString *)trim:(NSString *)string;
+(NSString *)getAccessToken;
+(BOOL)isLogin;
+(void)logout;
+(NSString *)getNickname;
+(NSInteger)checkNetWork;
+(NSString *)getCachesDirectory;
+(NSData *)loadFromCachesDirectory:(NSString *)filename;
+(BOOL)writeToCachesDirectory:(NSString *)filename data:(NSData *)data;
+(BOOL)deleteCachesFile:(NSString *)filename;
+(NSString *)toTimeUpClockFormat:(NSInteger)countPerSec;

@end
