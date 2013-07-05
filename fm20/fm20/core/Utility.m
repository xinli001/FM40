//
//  Utility.m
//  fm
//
//  Created by 黄力强 on 12-12-22.
//  Copyright (c) 2012年 黄力强. All rights reserved.
//

#import "Utility.h"

@implementation Utility

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

+(NSString *)URLEncodedString:(NSString *)string {
    NSString *result = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                    (CFStringRef)string,
                                                                                    NULL,
                                                                                    CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                    kCFStringEncodingUTF8);
	return result;
}

+(NSString *)urlEncode:(NSString *)url params:(NSDictionary *)params {
    NSString *query = [self urlEncode:params];
    if (query == nil) {
        return url;
    }
    return [NSString stringWithFormat:@"%@?%@", url, query];
}

+(NSString *)getDocumentDirectory {
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = [dirs objectAtIndex:0];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:dir]) {
        NSError *error;
        [fm createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return dir;
}

+(NSData *)loadFromDocumentDirectory:(NSString *)filename {
    NSString *dir = [self getDocumentDirectory];
    NSString *filepath = [dir stringByAppendingPathComponent:filename];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    return data;
}

+(NSString *)getCachesDirectory {
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *dir = [dirs objectAtIndex:0];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:dir]) {
        NSError *error;
        [fm createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return dir;
}

+(NSData *)loadFromCachesDirectory:(NSString *)filename {
    NSString *dir = [self getCachesDirectory];
    NSString *filepath = [dir stringByAppendingPathComponent:filename];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    return data;
}

+(BOOL)writeToDocumentDirectory:(NSString *)filename data:(NSData *)data {
    NSString *dir = [self getDocumentDirectory];
    NSString *filepath = [dir stringByAppendingPathComponent:filename];
    BOOL result = [data writeToFile:filepath atomically:YES];
    return result;
}

+(BOOL)writeToCachesDirectory:(NSString *)filename data:(NSData *)data {
    NSString *dir = [self getCachesDirectory];
    NSString *filepath = [dir stringByAppendingPathComponent:filename];
    BOOL result = [data writeToFile:filepath atomically:YES];
    return result;
}

+(BOOL)deleteCachesFile:(NSString *)filename {
    NSString *dir = [self getCachesDirectory];
    NSString *filepath = [dir stringByAppendingPathComponent:filename];
    NSFileManager *fileMr = [NSFileManager defaultManager];
    return [fileMr removeItemAtPath:filepath error:nil];
}

+(NSString *)getBundleDirectory {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *dir = [bundle resourcePath];
    return dir;
}

+(NSURL *)getBundleResource:(NSString *)filename extension:(NSString *)extension {
    NSBundle *bundle = [NSBundle mainBundle];
    return [bundle URLForResource:filename withExtension:extension];
}

+(NSData *)loadFromBundleDirectory:(NSString *)filename {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *dir = [bundle resourcePath];
    NSString *filepath = [dir stringByAppendingPathComponent:filename];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    return data;
}

+(NSString *)toClockFormat:(NSInteger)val {
    NSInteger minu = val / 60;
    NSInteger sec = val % 60;
    return [NSString stringWithFormat:@"%02d:%02d", minu, sec];
}

+(NSString *)toTimeUpClockFormat:(NSInteger)countPerSec {
    NSInteger hour = countPerSec/3600;
    NSInteger min  = (countPerSec%3600)/60;
    NSInteger sec  = countPerSec%60;
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hour,min, sec];
}

+(id)dataToJsonObj:(NSData *)data {
    NSError *error;
    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    return obj;
}

+(NSData *)dictToJsonData:(NSDictionary *)dict {
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    return data;
}

+(UIColor *)blueColor {
    return [UIColor colorWithRed:51.0/255 green:102.0/255 blue:153.0/255 alpha:1];
}

+(UIColor *)tableBgColor {
    return [UIColor colorWithRed:61/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
}

+(UIColor *)lgrayColor {
    return [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.8];
}

+(NSString *)dictToJsonString:(NSDictionary *)dict slug:(BOOL)slug {
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key in [dict allKeys]) {
        if (slug) {
            [array addObject:[NSString stringWithFormat:@"'%@':'%@'",key,[dict objectForKey:key]]];
        } else {
            [array addObject:[NSString stringWithFormat:@"'%@':%@",key,[dict objectForKey:key]]];
        }
    }
    return [NSString stringWithFormat:@"{%@}",[array componentsJoinedByString:@","]];
}

+(NSString *)dictArrayToJsonString:(NSArray *)_array {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in _array) {
        [array addObject:[self dictToJsonString:dict slug:YES]];
    }
    return [NSString stringWithFormat:@"[%@]",[array componentsJoinedByString:@","]];
}

+(NSString *)trim:(NSString *)string {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+(NSString *)getAccessToken {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:@"token"];
    return token;
}

+(NSString *)getNickname {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *nickname = [ud objectForKey:@"nickname"];
    return nickname;
}

+(BOOL)isLogin {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    BOOL isLogin = [ud boolForKey:@"login"];
    return isLogin;
}

+(void)logout {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:NO forKey:@"login"];
}

+(NSInteger)checkNetWork {
    if ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable) {
        return 1;
    }
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable) {
        return 2;
    }
    return 0;
}

@end
