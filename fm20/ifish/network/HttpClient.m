//
//  HttpClient.m
//  eap
//
//  Created by 黄力强 on 13-6-25.
//  Copyright (c) 2013年 壹 心理. All rights reserved.
//

#import "HttpClient.h"

@implementation HttpClient

+(void)get:(NSString *)url handler:(requestHandler)handler {
    return [self get:url params:nil handler:handler];
}

+(void)get:(NSString *)url params:(NSDictionary *)params handler:(requestHandler)handler {
    NSString *requestUrl = [url urlEncode:params];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:handler];
}

+(void)post:(NSString *)url params:(NSDictionary *)params handler:(requestHandler)handler {
    NSString *query = [NSString urlEncode:params];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[query dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:handler];
}

@end
