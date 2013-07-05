//
//  FmListViewController.m
//  fm
//
//  Created by 黄力强 on 12-12-26.
//  Copyright (c) 2012年 黄力强. All rights reserved.
//

#import "FmListViewController.h"

@interface FmListViewController ()

@end

static NSString *FMLISTTAG = @"fmlisttag";
static NSString *DOWNLOADLISTTAG = @"downloadlisttag";
static NSString *FAVORITELISTTAG = @"favoritelisttag";

@implementation FmListViewController

@synthesize fmListView, fmTV, fmListBtn, downloadListView, downloadTV, favoriteListBtn, favoriteListView, downloadListBtn, favoriteTV, editBtn, editTopBtn, editImage;

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
    facade = [Facade getInstance];
    [facade addMediator:self];

    [self showListByTag:FMLISTTAG];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showListByTag:(NSString *)tag {
    fmListView.hidden = YES;
    downloadListView.hidden = YES;
    favoriteListView.hidden = YES;
    
    fmListBtn.backgroundColor = nil;
    downloadListBtn.backgroundColor = nil;
    favoriteListBtn.backgroundColor = nil;
    
    [self resetEditStatus];
    
    if ([tag isEqualToString:FMLISTTAG]) {
        editTopBtn.hidden = YES;
        editImage.hidden = YES;
        showTag = FMLISTTAG;
        self.navigationItem.title = JIEMULIEBIAO;
        fmListView.hidden = NO;
        if (fmTVDataSource == nil) {
            fmTVDataSource = [[FmTVDataSouce alloc] initWithTableView:fmTV];
        } else {
            [self showFmTVCellSelect:facade.fmvo];
        }
        fmListBtn.backgroundColor = [Utility blueColor];
        editBtn.enabled = NO;
    }
    if ([tag isEqualToString:DOWNLOADLISTTAG]) {
        editTopBtn.hidden = NO;
        editImage.hidden = NO;
        showTag = DOWNLOADLISTTAG;
        self.navigationItem.title = XIAZAILIEBIAO;
        downloadListView.hidden = NO;
        if (downloadTVDataSource == nil) {
            downloadTVDataSource = [[DownloadTVDataSource alloc] initWithTableView:downloadTV];
        } else {
            [self showFmTVCellSelect:facade.fmvo];
        }
        downloadListBtn.backgroundColor = [Utility blueColor];
        editBtn.enabled = YES;
    }
    if ([tag isEqualToString:FAVORITELISTTAG]) {
        editTopBtn.hidden = NO;
        editImage.hidden = NO;
        showTag = FAVORITELISTTAG;
        self.navigationItem.title = SHOUCANGLIEBIAO;
        favoriteListView.hidden = NO;
        if (favoriteTVDataSource == nil) {
            favoriteTVDataSource = [[FavoriteTVDataSource alloc] initWithTableView:favoriteTV];
        } else {
            [self showFmTVCellSelect:facade.fmvo];
        }
        favoriteListBtn.backgroundColor = [Utility blueColor];
        editBtn.enabled = NO;
    }
}

- (void)resetEditStatus {
    fmTV.editing = NO;
    downloadTV.editing = NO;
    favoriteTV.editing = NO;
    editBtn.title = EDITTEXT;
}

- (void)showFmTVCellSelect:(FmVO *)fmvo {
    if (facade.fmType == 0 && showTag == FMLISTTAG) {
        [fmTVDataSource setTVCellSelect:fmvo];
    }
    if (facade.fmType == 1 && showTag == DOWNLOADLISTTAG) {
        [downloadTVDataSource setTVCellSelect:fmvo];
    }
    if (facade.fmType == 2 && showTag == FAVORITELISTTAG) {
        [favoriteTVDataSource setTVCellSelect:fmvo];
    }
}

- (IBAction)fmListBtnClick:(id)sender {
    [self showListByTag:FMLISTTAG];
}

- (IBAction)downloadListBtnClick:(id)sender {
    [self showListByTag:DOWNLOADLISTTAG];
}

- (IBAction)favoriteBtnClick:(id)sender {
    if (![Utility isLogin]) {
        facade.loginCallbackType = 3;
        [self performSegueWithIdentifier:@"loginView" sender:self];
    } else {
        [self showListByTag:FAVORITELISTTAG];
    }
}

- (IBAction)editBtnClick:(id)sender {
    if (showTag == DOWNLOADLISTTAG) {
        if (downloadTV.editing) {
            downloadTV.editing = NO;
//            editBtn.title = EDITTEXT;
        } else {
            downloadTV.editing = YES;
//            editBtn.title = CANCELTEXT;
        }
    }
    if (showTag == FAVORITELISTTAG) {
        if (favoriteTV.editing) {
            favoriteTV.editing = NO;
        } else {
            favoriteTV.editing = YES;
        }
    }
}

- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
   // [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleNotification:(Notification *)notification {
    NSString *name = notification.name;
    
    if (name == FMLOADSUCCESS) {
        [self showFmTVCellSelect:notification.body];
    }
    if (name == DOWNLOADDONE) {
        if (downloadTVDataSource) {
            [downloadTVDataSource refreshFmList];
        }
    }
    if (name == DOWNLOADFAILED) {
        if (downloadTVDataSource) {
            [downloadTVDataSource refreshFmList];
        }
    }
    if (name == FAVORITECHANGE) {
        if (favoriteTVDataSource) {
            [favoriteTVDataSource refreshFmList];
        }
    }
    if (name == LOGINSUCCESS) {
        if (facade.loginCallbackType == 3) {
            [self favoriteBtnClick:nil];
            facade.loginCallbackType = 0;
        }
    }
}

-(NSString *)mediatorName {
    return @"FmListViewController";
}

- (void)viewDidUnload {
    [self setFmListView:nil];
    [self setDownloadListView:nil];
    [self setFavoriteListView:nil];
    [self setFmTV:nil];
    [self setDownloadTV:nil];
    [self setFavoriteTV:nil];
    [facade removeMediator:[self mediatorName]];
    [self setFmListBtn:nil];
    [self setDownloadListBtn:nil];
    [self setFavoriteListBtn:nil];
    [self setEditBtn:nil];
    [self setEditBtn:nil];
    [self setEditImage:nil];
    [super viewDidUnload];
}
@end
