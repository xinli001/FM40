//
//  Constant.h
//  fm
//
//  Created by 黄力强 on 12-12-26.
//  Copyright (c) 2012年 黄力强. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSInteger VERSION = 1;

static NSString *FMCELL = @"fmcell";
static NSString *LOADINGCELL = @"loadingcell";
static NSString *LOADMORETEXT = @"正在努力加载中";
static NSString *TVCELLSELECT = @"tvcellselect";
static NSString *FMTVCELLSELECT = @"fmtvcellselect";
static NSString *DOWNLOADTVCELLSELECT = @"downloadtvcellselect";
static NSString *FAVORITETVCELLSELECT = @"favoritetvcellselect";
static NSString *FMTV = @"fmtv";
static NSString *DOWNLOADTV = @"downloadtv";
static NSString *FAVORITETV = @"favoritetv";
static NSString *FMLOADSUCCESS = @"fmloadsuccess";
static NSString *FMLOADFAILURE = @"fmloadfailure";
static NSString *JIEMULIEBIAO = @"节目列表";
static NSString *XIAZAILIEBIAO = @"下载列表";
static NSString *SHOUCANGLIEBIAO = @"收藏列表";

static NSString *AUDIOPLAYERINIT = @"audioplayerinit";
static NSString *AUDIOPLAYERPLAYING = @"audioplayerplaying";
static NSString *AUDIOPLAYERLOADEDDATA = @"audioplayerloadeddata";
static NSString *AUDIOPLAYERENDED = @"audioplayerended";
static NSString *USERNAMEEMPTY = @"请输入注册邮箱";
static NSString *PASSWORDEMPTY = @"请输入登录密码";
static NSString *NICKNAMEEMPTY = @"请输入昵称";
static NSString *PASSWORD1EMPTY = @"请输入密码";
static NSString *PASSWORD2EMPTY = @"请再次输入密码";
static NSString *PASSWORD2ERROR = @"两次密码输入不相同";
static NSString *REGISTERFAILD = @"注册信息填写错误";
static NSString *LOGINFAILDTEXT = @"注册邮箱或登录密码不正确";
static NSString *LOGINSUCCESSTEXT = @"登录成功";
static NSString *USERNAMEERROR = @"该用户名已存在";
static NSString *NICKNAMEERROR = @"该昵称已存在";
static NSString *UPLOADINGTEXT = @"提交中";
static NSString *REGISTERERROR = @"请认真填写注册信息";

static NSString *LOGINSUCCESS = @"loginsuccess";
static NSString *REGISTERSUCCESS = @"registersuccess";

static NSString *FAVORITELOGIN = @"favoritelogin";
static NSString *MUSICPLAY = @"musicplay";
static NSString *MUSICDOWN = @"musicdown";

static NSString *FMVOISDOWNLOADING = @"fmvoisdownloading";
static NSString *FMVOISDOWNLOADINGTEXT = @"节目已经加入下载队列";
static NSString *FMVOISDOWNLOADED = @"fmvoisdownloaded";
static NSString *FMVOISDOWNLOADEDTEXT = @"节目已经下载完成";

static NSString *ISFIRSTFM = @"已经是第一首了哦";

static NSString *NETWORKERROR = @"networkerror";

static NSString *NOTICETEXT = @"提示";
static NSString *SHARETEXT = @"分享";
static NSString *CANCELTEXT = @"取消";
static NSString *SHARETOWEIBOTEXT = @"分享到新浪微博";
static NSString *SHARETOTQQTEXT = @"分享到腾讯微博";
static NSString *SHARETORENRENTEXT = @"分享到人人网";
static NSString *SHARETODOUBANTEXT = @"分享到豆瓣网";
static NSString *SHARETOQZONETEXT = @"分享到QQ空间";

static NSString *SHARETEXTFORMAT = @"【#心理FM#%@】%@ 来自IOS版心理FM";
static NSString *APPSTOPURL = @"https://itunes.apple.com/us/app/xin-lifm2.0/id591341152?ls=1&mt=8";
static NSString *APPNAME = @"心理FM";

static NSString *MOBILESITEURL = @"http://m.xinli001.com/";

static NSString *NONETWORKTEXT = @"未连接网络，将使用离线模式";

static NSString *EDITTEXT = @"编辑";
//static NSString *CANCELTEXT = @"取消";

static NSString *SHARETOWEIBONAME = @"sinaminiblog";
static NSString *SHARETOTQQNAME = @"qqmb";
static NSString *SHARETORENRENNAME = @"renren";
static NSString *SHARETODOUBANNAME = @"douban";
static NSString *SHARETOQZONENAME = @"qzone";

static NSString *LOGIN = @"login";
static NSString *TOKEN = @"token";
static NSString *USERNAME = @"username";
static NSString *PASSWORD = @"password";
static NSString *NICKNAME = @"nickname";
static NSString *AVATAR = @"avatar";
static NSString *USERID = @"userid";
static NSString *LOGINVIEW = @"loginView";

static NSString *APPUPDATE = @"appupdate";
static NSString *APPUPDATETITLETEXT = @"心理FM有新版本更新啦";
static NSString *APPUPDATEALERTBUTTONCLICK = @"appupdatealertbuttonclick";
static NSString *UPDATELATERTEXT = @"稍后再说";
static NSString *UPDATENOWTEXT = @"现在更新";

static NSString *DOWNLOADLISTFILENAME = @"downloadlist";
static NSString *DOWNLOADDONE = @"downloaddone";
static NSString *DOWNLOADFAILED = @"downloadfailed";
static NSString *FAVORITECHANGE = @"favoritechange";

static NSString *UMENGKEY = @"50e2fa9e5270154f43000001";
static NSString *PUBLISHER_UUID = @"7f4fb6e2-a121-4c82-adb9-f0c586c911a9";
static NSString *TIMEUPNOTIFICATION = @"timeupnotification";
static NSString *REFRESHNOTIFICATION = @"refreshnotification";
@interface Constant : NSObject

@end
