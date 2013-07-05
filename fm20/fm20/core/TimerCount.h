//
//  TimerCount.h
//  fm20
//
//  Created by 壹 心理 on 13-6-13.
//  Copyright (c) 2013年 壹心理. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITimer.h"
#import "Facade.h"
#import "Utility.h"

@interface TimerCount : NSObject <ITimer> {
    NSTimer *timer1;
    NSTimer *timer2;
    NSString *timerRemain;
    int countPerSec;
    Facade *facade;
}

+(TimerCount *)getInstance;
@property NSString *timerRemain;

@end
