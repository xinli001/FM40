//
//  ShowViewController.h
//  fm
//
//  Created by 黄力强 on 12-12-22.
//  Copyright (c) 2012年 黄力强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "IMediator.h"
#import "Facade.h"
#import "FmProxy.h"
#import "FmVODelegate.h"
#import "DownloadDelegate.h"
#import "FavVODelegate.h"
#import "WebImage.h"
#import "AudioPlayer.h"
#import "Constant.h"
#import "LoginViewController.h"
#import "MobClick.h"
#import "SHSRedirectSharer.h"
#import "SHSRedirectViewController.h"
#import "UpdateDelegate.h"
#import "UpdateAlertDelegate.h"
#import "Reachability.h"
#import "DataDelegate.h"
#import "FmDataReceiver.h"
#import <ShareSDK/ShareSDK.h>

@interface ShowViewController : UIViewController <IMediator, UIAlertViewDelegate> {
    Facade *facade;
    DataList *dataList;
    WebImage *coverWebImage;
    AudioPlayer *player;
    NSArray *bgImages;
    double duration;
    BOOL isLocked;
    BOOL hadFavorite;
    BOOL hadInitFmList;
    NSInteger loginFlag;
    NSInteger objid;
    NSString *objopt;
    NSInteger alertType;
    NSInteger playIndex;
    Reachability *reachability;
}
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *fmView;
@property (weak, nonatomic) IBOutlet UIImageView *bgIV;
@property (weak, nonatomic) IBOutlet UIImageView *coverIV;
@property (weak, nonatomic) IBOutlet UIButton *prevBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *playPauseBtn;
@property (weak, nonatomic) IBOutlet UILabel *wsLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *leftLbl;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UISlider *playingHS;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIView *loadFailView;
@property (weak, nonatomic) IBOutlet UIView *nofmView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

- (IBAction)refreshBtnClick:(id)sender;
- (IBAction)playPauseBtnClick:(id)sender;
- (IBAction)prevBtnClick:(id)sender;
- (IBAction)nextBtnClick:(id)sender;
- (IBAction)downloadBtnClick:(id)sender;
- (IBAction)favoriteBtnClick:(id)sender;
- (IBAction)shareBtnClick:(id)sender;
- (IBAction)playingHSChanged:(id)sender;
- (IBAction)listBtnClick:(id)sender;
- (IBAction)optionBtnClick:(id)sender;

-(NSString *)mediatorName;

- (void)reachabilityChanged:(NSNotification *)notification;

@end
