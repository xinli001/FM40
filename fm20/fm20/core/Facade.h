//
//  Facade.h
//  fm
//
//  Created by 黄力强 on 12-12-22.
//  Copyright (c) 2012年 黄力强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ITimer.h"
#import "Utility.h"
#import "Constant.h"
#import "MobClick.h"
#import "FmProxy.h"

@interface Facade : NSObject {
    NSInteger fmType;
    BOOL tvLocked;
    NSInteger fmPage;
    NSInteger fmPageSize;
}

@property(nonatomic) NSInteger fmType;
@property(nonatomic) BOOL tvLocked;

+(Facade *)getInstance;

@end
