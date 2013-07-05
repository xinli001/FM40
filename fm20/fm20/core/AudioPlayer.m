//
//  AudioPlayer.m
//  fm
//
//  Created by 黄力强 on 12-12-24.
//  Copyright (c) 2012年 黄力强. All rights reserved.
//

#import "AudioPlayer.h"

static AudioPlayer *instance;

@implementation AudioPlayer

@synthesize duration;

+(AudioPlayer *)getInstance {
    if (instance == nil) {
        instance = [[self alloc] init];
    }
    return instance;
}

- (id)init {
    if (self = [super init]) {
        duration = 0;
        
        // playback
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        [audioSession setActive:YES error:nil];
        
        webView = [[UIWebView alloc] init];
        [webView setAllowsInlineMediaPlayback:YES];
        [webView setMediaPlaybackRequiresUserAction:NO];
        [webView setDelegate:self];
        
        NSString *dir = [Utility getBundleDirectory];
        NSString *filepath = [dir stringByAppendingPathComponent:@"index.html"];
        NSString *html = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
        dir = [Utility getCachesDirectory];
        NSURL *baseUrl = [NSURL fileURLWithPath:dir isDirectory:YES];
        [webView loadHTMLString:html baseURL:baseUrl];
    }
    return self;
}

- (void)start:(NSString *)mp3url {
    //mp3url = @"303.mp3";
    if (mp3url == nil) {
        return;
    }
    [self stop];
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"playUrl('%@')", mp3url]];
    [self createLoadDataTimer];
    [self createPlayingTimer];
//    if ([result isEqualToString:@"true"]) {
//        [self createLoadDataTimer];
//        [self createPlayingTimer];
//    } else {
//        NSLog(result);
//    }
}

- (BOOL)playOrPause {
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:@"playOrPause()"];
    if ([result isEqualToString:@"true"]) {
        return YES;
    }
    return NO;
}

- (void)pause{
    [webView stringByEvaluatingJavaScriptFromString:@"pause()"];
}

- (void)stop {
    [self stopLoadDataTimer];
    [self stopPlayingTimer];
    duration = 0;
}

- (void)setCurrentTime:(float)ct {
    NSString *script = [NSString stringWithFormat:@"setCurrentTime(%f)",ct];
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:script];
}

- (void)initPlayer {
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:@"initPlayer()"];
    
    if ([result isEqualToString:@"true"]) {
        [self sendNotification:AUDIOPLAYERINIT];
    }
}

- (void)createLoadDataTimer {
    NSTimeInterval interval = 0.5;
    loadDataTimer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(onLoadingData) userInfo:nil repeats:YES];
}

- (void)onLoadingData {
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:@"isLoadeddata()"];
    if ([result isEqualToString:@"true"]) {
        [self stopLoadDataTimer];
        NSString *durationStr = [webView stringByEvaluatingJavaScriptFromString:@"getDuration()"];
        duration = [durationStr doubleValue];
        [self sendNotification:AUDIOPLAYERLOADEDDATA body:durationStr];
    }
}

- (void)stopLoadDataTimer {
    if (loadDataTimer) {
        [loadDataTimer invalidate];
        loadDataTimer = nil;
    }
}

- (void)createPlayingTimer {
    NSTimeInterval interval = 0.5;
    playingTimer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(onPlaying) userInfo:nil repeats:YES];
}

- (void)onPlaying {
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:@"isEnded()"];
    if ([result isEqualToString:@"true"]) {
        [self stopPlayingTimer];
        [self sendNotification:AUDIOPLAYERENDED];
    } else {
        NSString *ctStr = [webView stringByEvaluatingJavaScriptFromString:@"getCurrentTime()"];
        [self sendNotification:AUDIOPLAYERPLAYING body:ctStr];
    }
}

- (void)stopPlayingTimer {
    if (playingTimer) {
        [playingTimer invalidate];
        playingTimer = nil;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self initPlayer];
}

@end
