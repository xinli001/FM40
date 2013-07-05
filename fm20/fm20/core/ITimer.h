//
//  ITimer.h
//  fm20
//
//  Created by 壹 心理 on 13-6-13.
//  Copyright (c) 2013年 壹心理. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ITimer <NSObject>

-(void) startCount:(int)duration;
-(void) stopCount;
-(void) cancelTimer;

@end
