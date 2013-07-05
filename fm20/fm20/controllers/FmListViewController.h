//
//  FmListViewController.h
//  fm
//
//  Created by 黄力强 on 12-12-26.
//  Copyright (c) 2012年 黄力强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FmTVDataSouce.h"
#import "DownloadTVDataSource.h"
#import "FavoriteTVDataSource.h"
#import "IMediator.h"
#import "Facade.h"
#import "WebImage.h"
#import "Constant.h"
#import "LoginViewController.h"

@interface FmListViewController : UIViewController <IMediator> {
    Facade *facade;
    WebImage *coverWebImage;
    NSString *showTag;
    FmTVDataSouce *fmTVDataSource;
    DownloadTVDataSource *downloadTVDataSource;
    FavoriteTVDataSource *favoriteTVDataSource;
}
@property (weak, nonatomic) IBOutlet UIButton *fmListBtn;
@property (weak, nonatomic) IBOutlet UIButton *downloadListBtn;
@property (weak, nonatomic) IBOutlet UIButton *favoriteListBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBtn;
@property (weak, nonatomic) IBOutlet UIView *fmListView;
@property (weak, nonatomic) IBOutlet UIView *downloadListView;
@property (weak, nonatomic) IBOutlet UIView *favoriteListView;
@property (weak, nonatomic) IBOutlet UITableView *downloadTV;
@property (weak, nonatomic) IBOutlet UITableView *fmTV;
@property (weak, nonatomic) IBOutlet UITableView *favoriteTV;
@property (weak, nonatomic) IBOutlet UIButton *editTopBtn;
@property (weak, nonatomic) IBOutlet UIImageView *editImage;

- (IBAction)fmListBtnClick:(id)sender;
- (IBAction)downloadListBtnClick:(id)sender;
- (IBAction)favoriteBtnClick:(id)sender;
- (IBAction)editBtnClick:(id)sender;
- (IBAction)backBtnClick:(id)sender;

@end
