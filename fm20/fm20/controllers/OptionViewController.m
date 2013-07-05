//
//  OptionViewController.m
//  fm
//
//  Created by 黄力强 on 13-1-4.
//  Copyright (c) 2013年 黄力强. All rights reserved.
//

#import "OptionViewController.h"

@interface OptionViewController ()

@end

@implementation OptionViewController

@synthesize userLbl, logoutBtn;

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
    [self showLoginUser];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showLoginUser {
    BOOL isLogin = [Utility isLogin];
    if (isLogin) {
        NSString *nickname = [Utility getNickname];
        userLbl.text = [NSString stringWithFormat:@"%@, 切换用户",nickname];
        logoutBtn.hidden = NO;
    } else {
        userLbl.text = @"登录";
        logoutBtn.hidden = YES;
    }
}

- (IBAction)feedbackBtnClick:(id)sender {
    [UMFeedback showFeedback:self withAppkey:UMENGKEY];
}

- (IBAction)pingfenBtnClick:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APPSTOPURL]];
}

- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)siteBtnClick:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:MOBILESITEURL]];
}

- (IBAction)logoutBtnClick:(id)sender {
    [Utility logout];
    [self showLoginUser];
    [self performSegueWithIdentifier:@"login" sender:self];
}

-(void)handleNotification:(Notification *)notification {
    NSString *name = notification.name;
    if (name == LOGINSUCCESS) {
        [self showLoginUser];
    }
}

- (NSString *)mediatorName {
    return @"OptionViewController";
}

- (void)viewDidUnload {
    [self setUserLbl:nil];
    [facade removeMediator:[self mediatorName]];
    [self setLogoutBtn:nil];
    [super viewDidUnload];
}
@end
