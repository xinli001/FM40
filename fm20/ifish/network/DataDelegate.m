//
//  DataDelegate.m
//  fm20
//
//  Created by 黄力强 on 13-7-5.
//  Copyright (c) 2013年 xinli001. All rights reserved.
//

#import "DataDelegate.h"

@implementation DataDelegate

@synthesize programHandler, finishHandler, errorHandler;

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _receiveData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_receiveData appendData:data];
    programHandler(connection, _receiveData.length);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    finishHandler(connection, _receiveData);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    errorHandler(connection, error);
}

@end
