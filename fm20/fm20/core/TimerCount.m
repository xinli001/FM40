//
//  TimerCount.m
//  fm20
//
//  Created by 壹 心理 on 13-6-13.
//  Copyright (c) 2013年 壹心理. All rights reserved.
//

#import "TimerCount.h"

static TimerCount *instance;

@implementation TimerCount

@synthesize timerRemain;

+(TimerCount *)getInstance{
    if(instance == nil){
        instance=[[self alloc]initWithFacade:[Facade getInstance]];
    }
    return instance;
}

-(id) initWithFacade:(Facade *)_facade {
    if (self = [super init]) {
        facade = _facade;
    }
    return self;
}

-(void) startCount:(int)duration {
    if(timer1.isValid==YES) {
        [self cancelTimer];
    }
    timer1=[NSTimer scheduledTimerWithTimeInterval:duration
                                           target:self
                                         selector:@selector(stopCount)
                                         userInfo:nil
                                          repeats:NO];
    countPerSec=duration;
    timer2=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    
}

-(void)stopCount
{
    [facade sendNotification:[Notification withName:TIMEUPNOTIFICATION]];
    [self cancelTimer];
}

-(void) cancelTimer {
    [timer1 invalidate];
    [timer2 invalidate];
}

- (void)timerFireMethod:(NSTimer *)timer
{
     NSString *timeremaincount = [NSString stringWithFormat:@"%@", [Utility toTimeUpClockFormat:countPerSec]];
    countPerSec=countPerSec-1;
    if(countPerSec<0){
        timerRemain=Nil;
    }
    else{
        timerRemain=timeremaincount;
    }
    [facade sendNotification:[Notification withName:REFRESHNOTIFICATION]];
}


@end
