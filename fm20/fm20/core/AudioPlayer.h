//
//  AudioPlayer.h
//  fm
//
//  Created by 黄力强 on 12-12-24.
//  Copyright (c) 2012年 黄力强. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "NotificationDelegate.h"
#import "Utility.h"
#import "Constant.h"

@interface AudioPlayer : NotificationDelegate <UIWebViewDelegate> {
    UIWebView *webView;
    NSTimer *playerTimer;
    NSTimer *loadDataTimer;
    NSTimer *playingTimer;
    double duration;
}

@property(nonatomic) double duration;

+(AudioPlayer *)getInstance;
- (void)start:(NSString *)mp3url;
- (BOOL)playOrPause;
- (void)setCurrentTime:(float)ct;
- (void)pause;

@end
