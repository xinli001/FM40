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

+(void)get:(NSString *)url jsonHandler:(jsonHandler)handler {
    return [self get:url params:nil jsonHandler:handler];
}

+(void)get:(NSString *)url params:(NSDictionary *)params jsonHandler:(jsonHandler)handler {
    requestHandler _handler = ^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error == nil) {
            NSError *_error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&_error];
            handler(response, json, _error);
        } else {
            handler(response, nil, error);
        }
    };
    [self get:url params:params handler:_handler];
}

+(void)get:(NSString *)url programHandler:(ProgramHandler)programHandler finishHandler:(FinishHandler)finishHandler errorHandler:(ErrorHandler)errorHandler {
    [self get:url params:nil programHandler:programHandler finishHandler:finishHandler errorHandler:errorHandler];
}

+(void)get:(NSString *)url params:(NSDictionary *)params programHandler:(ProgramHandler)programHandler finishHandler:(FinishHandler)finishHandler errorHandler:(ErrorHandler)errorHandler {
    NSString *requestUrl = [url urlEncode:params];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
    DataDelegate *delegate = [[DataDelegate alloc] init];
    delegate.programHandler = programHandler;
    delegate.finishHandler = finishHandler;
    delegate.errorHandler = errorHandler;
    [NSURLConnection connectionWithRequest:request delegate:delegate];
}

+(void)post:(NSString *)url params:(NSDictionary *)params handler:(requestHandler)handler {
    NSString *query = [NSString urlEncode:params];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[query dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:handler];
}

+(void)post:(NSString *)url params:(NSDictionary *)params jsonHandler:(jsonHandler)handler {
    requestHandler _handler = ^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error == nil) {
            NSError *_error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&_error];
            handler(response, json, _error);
        } else {
            handler(response, nil, error);
        }
    };
    [self post:url params:params handler:_handler];
}

@end
