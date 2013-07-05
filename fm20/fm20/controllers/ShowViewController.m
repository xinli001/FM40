//
//  ShowViewController.m
//  fm
//
//  Created by 黄力强 on 12-12-22.
//  Copyright (c) 2012年 黄力强. All rights reserved.
//

#import "ShowViewController.h"

@interface ShowViewController ()

@end

@implementation ShowViewController

@synthesize coverIV, bgIV, nextBtn, prevBtn, playingHS, playPauseBtn, downloadBtn, favoriteBtn, shareBtn, wsLbl, leftLbl, contentLbl, bgView, fmView, loadingView, loadFailView, nofmView, titleLbl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [MobClick startWithAppkey:UMENGKEY];
    isLocked = NO;
    hadFavorite = NO;
    hadInitFmList = NO;
    playIndex = 0;
    coverWebImage = [[WebImage alloc] initWithImageView:coverIV async:NO];
    player = [AudioPlayer getInstance];
    facade = [Facade getInstance];
    [facade addMediator:self];
    dataList = [DataList getInstance];
    [self checkNetwork];
}

- (void)checkNetwork {
    NSInteger status = [Utility checkNetWork];
    if (status == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NOTICETEXT message:NONETWORKTEXT delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        facade.fmType = 1;
    } else {
//        [MobClick checkUpdate];
//        [self checkUpdate];
    }
    if (status == 2) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NOTICETEXT message:@"你现在使用的是3G网络，节目比较大，建议使用WIFI收听" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)randomBackgroundImage {
    NSInteger i = arc4random() % 10 + 1;
    NSString *name = [NSString stringWithFormat:@"%d.jpg", i];
    UIImage *image = [UIImage imageNamed:name];
    bgIV.image = image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTVCellSelect:(NSString *)index {
    playIndex = [index integerValue];
    [self playIndexFm];
}

- (void)getFmById:(NSInteger)fmid {
    isLocked = YES;
    objid = fmid;
    FmVODelegate *delegate = [[FmVODelegate alloc] init];
    [FmProxy getFmById:fmid delegate:delegate];
    loadingView.hidden = NO;
}

- (void)loadFmList {
    SEL handler = nil;
    if (dataList.fmList.count == 0) {
        handler = @selector(playIndexFm);
        loadingView.hidden = NO;
    }
    FmDataReceiver *receiver = [[FmDataReceiver alloc] initWithFun:handler context:self];
    DataDelegate *delegate = [[DataDelegate alloc] initWithReceiver:receiver];
    NSInteger offset = dataList.fmList.count;
    NSInteger rows = 10;
    [FmProxy getFmList:offset rows:rows delegate:delegate];
}

- (void)loadDownloadFmList {
    NSData *data = [Utility loadFromDocumentDirectory:DOWNLOADLISTFILENAME];
    if (data) {
        NSDictionary *obj = [Utility dataToJsonObj:data];
        NSArray *items = [obj objectForKey:@"data"];
        for (NSDictionary *item in items) {
            FmVO *fmvo = [[FmVO alloc] initWithData:item];
            [dataList.downloadFmList addObject:fmvo];
        }
        [self playIndexFm];
    } else {
        nofmView.hidden = NO;
        facade.fmType = 0;
        [self didNetworkError];
    }
}

-(void)playIndexFm {
    loadingView.hidden = YES;
    FmVO *fmvo;
    if (facade.fmType == 0) {
        if (dataList.fmList.count == 0) {
            [self loadFmList];
            return;
        }
        playIndex = playIndex % dataList.fmList.count;
        fmvo = [dataList.fmList objectAtIndex:playIndex];
        if (playIndex == dataList.fmList.count - 1) {
            [self loadFmList];
        }
    }
    if (facade.fmType == 1) {
        if (dataList.downloadFmList.count == 0) {
            return;
        }
        playIndex = playIndex % dataList.downloadFmList.count;
        fmvo = [dataList.downloadFmList objectAtIndex:playIndex];
    }
    if (facade.fmType == 2) {
        if (dataList.favList.count == 0) {
            return;
        }
        playIndex = playIndex % dataList.favList.count;
        fmvo = [dataList.favList objectAtIndex:playIndex];
    }
    [self startPlayFm:fmvo];
}

-(void)startPlayFm:(FmVO *)fmvo {
    facade.tvLocked = NO;
    facade.fmvo = fmvo;
    [self showFmVO];
    [self checkFmFavorite];
    [self playFmVO];
}

- (void)getFavorite:(NSInteger)otherId opt:(NSString *)opt {
    isLocked = YES;
    objid = otherId;
    objopt = opt;
    FavVODelegate *delegate = [[FavVODelegate alloc] init];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:TOKEN];
    [FmProxy getFavorite:otherId opt:opt token:token delegate:delegate];
    loadingView.hidden = NO;
}

- (void)showFmVO {
    loadingView.hidden = YES;
    FmVO *fmvo = facade.fmvo;
    [coverWebImage setImageUrl:fmvo.cover];
    NSString *ws = [NSString stringWithFormat:@"文：%@  主播：%@",fmvo.word,fmvo.speak];
    wsLbl.text = ws;
    contentLbl.text = fmvo.content;
//    self.navigationItem.title = fmvo.title;
    self.titleLbl.text = fmvo.title;
    [self checkFmFavorite];
    [self checkFmDownload];
    [self randomBackgroundImage];
    [self showLockPage];
}

- (void)showLockPage {
    FmVO *fmvo = facade.fmvo;
    MPMediaItemArtwork *mart = [[MPMediaItemArtwork alloc] initWithImage:[coverWebImage getImage]];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:APPNAME forKey:MPMediaItemPropertyAlbumTitle];
    [dict setValue:mart forKey:MPMediaItemPropertyArtwork];
    [dict setValue:fmvo.title forKey:MPMediaItemPropertyTitle];
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = dict;
}

- (void)checkFmFavorite {
//    if (facade.fmType > 0) {
//        favoriteBtn.enabled = NO;
//        return;
//    }
//    favoriteBtn.enabled = YES;
    if (![Utility isLogin]) {
        hadFavorite = NO;
        return;
    }
    FmVO *fmvo = facade.fmvo;
    NSInteger fmid = fmvo.fmid;
    NSData *data = [FmProxy checkFavorite:fmid token:[Utility getAccessToken]];
    if (!data) {
        return;
    }
    NSDictionary *dict = [Utility dataToJsonObj:data];
    NSInteger code = [[dict objectForKey:@"code"] integerValue];
    if (code == 0) {
        hadFavorite = YES;
        [favoriteBtn setBackgroundImage:[UIImage imageNamed:@"favbtnred.png"] forState:UIControlStateNormal];
    } else {
        hadFavorite = NO;
        [favoriteBtn setBackgroundImage:[UIImage imageNamed:@"favbtn.png"] forState:UIControlStateNormal];
    }
}

- (void)checkFmDownload {
    if (facade.fmType == 1) {
        [downloadBtn setBackgroundImage:[UIImage imageNamed:@"downloadbtna.png"] forState:UIControlStateNormal];
        downloadBtn.enabled = NO;
        return;
    }
    if ([facade checkDownload:facade.fmvo]) {
        downloadBtn.enabled = NO;
        [downloadBtn setBackgroundImage:[UIImage imageNamed:@"downloadbtna.png"] forState:UIControlStateNormal];
    } else {
        downloadBtn.enabled = YES;
        [downloadBtn setBackgroundImage:[UIImage imageNamed:@"downloadbtn.png"] forState:UIControlStateNormal];
    }
}

- (void)playFmVO {
    [MobClick event:MUSICPLAY];
    [playPauseBtn setBackgroundImage:[UIImage imageNamed:@"playbtn.png"] forState:UIControlStateNormal];
    FmVO *fmvo = facade.fmvo;
    [player start:fmvo.url];
    duration = 0;
}

- (void)onAudioPlayerPlaying:(double)ct {
    [self leftTimeFormat:ct];
    if (duration > 0) {
        playingHS.value = ct;
    }
}

- (void)leftTimeFormat:(double)ct {
    NSInteger left = duration - ct;
    if (left < 0) {
        left = 0;
    }
    NSString *text = [NSString stringWithFormat:@"-%@", [Utility toClockFormat:left]];
    leftLbl.text = text;
}

- (void)didNetworkError {
    if ([Utility checkNetWork] == 0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        reachability = [Reachability reachabilityWithHostName:@"www.xinli001.com"];
        [reachability startNotifier];
    }
}

- (void)reachabilityChanged:(NSNotification *)notification {
//    reachability = [notification object];
    NetworkStatus status = [reachability currentReachabilityStatus];
    if (status != NotReachable) {
        [self refreshBtnClick:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
        nofmView.hidden = YES;
        loadFailView.hidden = YES;
    }
}

- (void)handleNotification:(Notification *)notification {
    NSString *name = notification.name;
    
    if (name == FMLOADSUCCESS) {
        facade.tvLocked = NO;
        facade.fmvo = notification.body;
        [self showFmVO];
        [self checkFmFavorite];
        [self checkFmDownload];
        [self playFmVO];
    }
    if (name == FMLOADFAILURE) {
        loadFailView.hidden = NO;
    }
    if (name == NETWORKERROR) {
        loadFailView.hidden = NO;
        [self didNetworkError];
    }
    if (name == AUDIOPLAYERINIT) {
        if (facade.fmType == 0) {
            [self loadFmList];
        } else {
            [self loadDownloadFmList];
        }
    }
    if (name == AUDIOPLAYERPLAYING) {
        loadFailView.hidden = YES;
        double ct = [notification.body doubleValue];
        [self onAudioPlayerPlaying:ct];
        [self showLockPage];
    }
    if (name == AUDIOPLAYERLOADEDDATA) {
        duration = [notification.body doubleValue];
        playingHS.maximumValue = duration;
        [playPauseBtn setBackgroundImage:[UIImage imageNamed:@"pausebtn.png"] forState:UIControlStateNormal];
        isLocked = NO;
    }
    if (name == TVCELLSELECT) {
        [self.navigationController popViewControllerAnimated:YES];
        [self didTVCellSelect:notification.body];
    }
    if (name == FMVOISDOWNLOADING) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NOTICETEXT message:FMVOISDOWNLOADINGTEXT delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [downloadBtn setBackgroundImage:[UIImage imageNamed:@"downloadbtna.png"] forState:UIControlStateNormal];
    }
    if (name == FMVOISDOWNLOADED) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NOTICETEXT message:FMVOISDOWNLOADEDTEXT delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    if (name == AUDIOPLAYERENDED) {
        [self nextBtnClick:nil];
    }
    if (name == APPUPDATEALERTBUTTONCLICK) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APPSTOPURL]];
    }
    if (name == LOGINSUCCESS) {
        if (facade.loginCallbackType == 1) {
            [self downloadBtnClick:nil];
            facade.loginCallbackType = 0;
        }
        if (facade.loginCallbackType == 2) {
            [self favoriteBtnClick:nil];
            facade.loginCallbackType = 0;
        }
        if (facade.loginCallbackType == 4) {
            [self nextBtnClick:nil];
            facade.loginCallbackType = 0;
        }
        if (facade.loginCallbackType == 5) {
            [self prevBtnClick:nil];
            facade.loginCallbackType = 0;
        }
    }
    if ([name isEqualToString:DOWNLOADFAILED]) {
        NSInteger uid = [notification.body integerValue];
        if (uid == facade.fmvo.fmid) {
            [downloadBtn setBackgroundImage:[UIImage imageNamed:@"downloadbtn.png"] forState:UIControlStateNormal];
        }
    }
    if([name isEqualToString:TIMEUPNOTIFICATION]){
        [player pause];
        [playPauseBtn setBackgroundImage:[UIImage imageNamed:@"playbtn.png"] forState:UIControlStateNormal];
        isLocked = NO;

    }
}

- (IBAction)refreshBtnClick:(id)sender {
    loadFailView.hidden = YES;
    [self playIndexFm];
}

- (IBAction)playPauseBtnClick:(id)sender {
    if (isLocked) {
        return;
    }
    BOOL isPlaying = [player playOrPause];
    if (isPlaying) {
        [playPauseBtn setBackgroundImage:[UIImage imageNamed:@"pausebtn.png"] forState:UIControlStateNormal];
    } else {
        [playPauseBtn setBackgroundImage:[UIImage imageNamed:@"playbtn.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)prevBtnClick:(id)sender {
    if (playIndex == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NOTICETEXT message:ISFIRSTFM delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    playIndex--;
    [self playIndexFm];
}

- (IBAction)nextBtnClick:(id)sender {
    if (facade.fmType != 1) {
        if (![Utility isLogin]) {
            facade.loginCallbackType = 4;
            [self performSegueWithIdentifier:LOGINVIEW sender:self];
            return;
        }
    }
    playIndex++;
    [self playIndexFm];
}

- (IBAction)downloadBtnClick:(id)sender {
    if (facade.fmType == 1) {
        return;
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    BOOL isLogin = [ud boolForKey:LOGIN];
    if (!isLogin) {
        facade.loginCallbackType = 1;
        [self performSegueWithIdentifier:LOGINVIEW sender:self];
    } else {
        [facade addDownloadQueue:facade.fmvo];
    }
}

- (IBAction)favoriteBtnClick:(id)sender {
//    if (facade.fmType > 0) {
//        return;
//    }
    BOOL isLogin = [Utility isLogin];
    if (!isLogin) {
        facade.loginCallbackType = 2;
        [self performSegueWithIdentifier:LOGINVIEW sender:self];
    } else {
        NSString *token = [Utility getAccessToken];
        if (hadFavorite) {
            NSData *data = [FmProxy deleteFavorite:facade.fmvo.fmid token:token];
            NSDictionary *dict = [Utility dataToJsonObj:data];
            NSInteger code = [[dict objectForKey:@"code"] integerValue];
            if (code > 0) {
                hadFavorite = NO;
                [favoriteBtn setBackgroundImage:[UIImage imageNamed:@"favbtn.png"] forState:UIControlStateNormal];
            }
        } else {
            NSData *data = [FmProxy addFavorite:facade.fmvo.fmid token:token];
            NSDictionary *dict = [Utility dataToJsonObj:data];
            NSInteger code = [[dict objectForKey:@"code"] integerValue];
            if (code == 0) {
                hadFavorite = YES;
                [favoriteBtn setBackgroundImage:[UIImage imageNamed:@"favbtnred.png"] forState:UIControlStateNormal];
            }
        }
        [facade sendNotification:[Notification withName:FAVORITECHANGE]];
    }
}

- (IBAction)shareBtnClick:(id)sender {
    [self showShareAlertView];
}

- (IBAction)playingHSChanged:(id)sender {
    [player setCurrentTime:playingHS.value];
}

- (IBAction)listBtnClick:(id)sender {
}

- (IBAction)optionBtnClick:(id)sender {
}

- (NSString *)mediatorName {
    return @"ShowViewController";
}

- (void)showShareAlertView {
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:CANCELTEXT otherButtonTitles:SHARETOWEIBOTEXT,SHARETOTQQTEXT,SHARETOQZONETEXT,SHARETODOUBANTEXT,SHARETORENRENTEXT, nil];
//    [alertView show];
//    alertType = 1;
    NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeSinaWeibo, ShareTypeTencentWeibo, ShareTypeWeixiSession, ShareTypeWeixiTimeline, ShareTypeRenren, nil];
    FmVO *fmvo = facade.fmvo;
    
    NSString *title = fmvo.title;
    NSString *url = [NSString stringWithFormat:@"http://m.xinli001.com/fm/%d/", fmvo.fmid];
    NSString *text = [NSString stringWithFormat:SHARETEXTFORMAT,fmvo.title,fmvo.content];
    
    id pushContent = [ShareSDK publishContent:text defaultContent:text image:coverWebImage.getImage imageQuality:0.8 mediaType:SSPublishContentMediaTypeNews title:fmvo.title url:url musicFileUrl:nil extInfo:nil fileData:nil];
    id<ISSImage> cover = [ShareSDK jpegImage:coverWebImage.getImage quality:0.8 fileName:nil];
    [pushContent addRenRenUnitWithName:title description:fmvo.content url:url message:text imageObject:cover caption:nil];
    
    [ShareSDK showShareActionSheet:self shareList:shareList content:pushContent statusBarTips:YES oneKeyShareList:[NSArray defaultOneKeyShareList] shareViewStyle:ShareViewStyleSimple shareViewTitle:SHARETEXT result:^(ShareType type, SSPublishContentState state, id<ISSStatusInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        
        if (state == SSPublishContentStateSuccess) {
            id<IAuthOptions> options = [ShareSDK authOptionsWithAutoAuth:YES authViewStyle:AuthViewStylePopup];
            if (type == ShareTypeSinaWeibo || type == ShareTypeTencentWeibo) {
                [ShareSDK followUserWithName:@"壹心理" shareType:type authOptions:options result:nil];
            }
            [FmProxy incsharenum:fmvo.fmid];
            NSLog(@"Success");
        }
        if (state == SSPublishContentStateFail) {
            NSString *msg = [NSString stringWithFormat:@"%d: %@", [error errorCode], [error errorDescription]];
            NSLog(@"Fail: %@", msg);
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertType == 2) {
        if (buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APPSTOPURL]];
        }
        return;
    }
    SHSRedirectSharer *sharer = [[SHSRedirectSharer alloc] init];
    switch (buttonIndex) {
        case 1:
            sharer.name = SHARETOWEIBONAME;
            break;
        case 2:
            sharer.name = SHARETOTQQNAME;
            break;
        case 3:
            sharer.name = SHARETOQZONENAME;
            break;
        case 4:
            sharer.name = SHARETODOUBANNAME;
            break;
        case 5:
            sharer.name = SHARETORENRENNAME;
            break;
        default:
            return;
            break;
    }
    FmVO *fmvo = facade.fmvo;
    NSString *text = [NSString stringWithFormat:SHARETEXTFORMAT,fmvo.title,fmvo.content];
    NSString *url = [sharer getShareUrlWithTitle:nil withText:text withURL:APPSTOPURL withImageURL:fmvo.cover];
    SHSRedirectViewController *controller = [[SHSRedirectViewController alloc] initWithUrl:url];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewDidUnload {
    [self setCoverIV:nil];
    [self setDownloadBtn:nil];
    [self setBgIV:nil];
    [self setPrevBtn:nil];
    [self setNextBtn:nil];
    [self setWsLbl:nil];
    [self setContentLbl:nil];
    [self setLeftLbl:nil];
    [self setDownloadBtn:nil];
    [self setFavoriteBtn:nil];
    [self setShareBtn:nil];
    [self setPlayPauseBtn:nil];
    [self setBgView:nil];
    [self setFmView:nil];
    [self setPlayingHS:nil];
    [self setLoadingView:nil];
    [self setLoadFailView:nil];
    [self setNofmView:nil];
    [self setTitleLbl:nil];
    [super viewDidUnload];
}
@end
