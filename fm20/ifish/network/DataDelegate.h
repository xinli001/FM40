//
//  DataDelegate.h
//  fm20
//
//  Created by 黄力强 on 13-7-5.
//  Copyright (c) 2013年 xinli001. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ProgramHandler)(NSURLConnection *conn, NSInteger length);
typedef void(^FinishHandler)(NSURLConnection *conn, NSData *data);
typedef void(^ErrorHandler)(NSURLConnection *conn, NSError *error);

@interface DataDelegate : NSObject <NSURLConnectionDataDelegate> {
    NSMutableData *_receiveData;
}

@property (nonatomic, copy) ProgramHandler programHandler;
@property (nonatomic, copy) ErrorHandler errorHandler;
@property (nonatomic, copy) FinishHandler finishHandler;

@end
