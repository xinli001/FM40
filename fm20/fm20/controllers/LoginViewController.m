//
//  LoginViewController.m
//  fm
//
//  Created by 黄力强 on 12-12-27.
//  Copyright (c) 2012年 黄力强. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize usernameLbl, passwordLbl, loginBtn, msgLbl, loginCallback, callBackTarget;

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
    dataList = [DataList getInstance];
    [facade addMediator:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleNotification:(Notification *)notification {
    NSString *name = notification.name;
    if (name == REGISTERSUCCESS) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        usernameLbl.text = [ud objectForKey:USERNAME];
        passwordLbl.text = [ud objectForKey:PASSWORD];
        [self loginBtnClick:nil];
    }
}

-(NSString *)mediatorName {
    return @"LoginViewController";
}

- (void)viewDidUnload {
    [self setUsernameLbl:nil];
    [self setPasswordLbl:nil];
    [self setLoginBtn:nil];
    [self setMsgLbl:nil];
    [facade removeMediator:[self mediatorName]];
    [super viewDidUnload];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == usernameLbl) {
        [passwordLbl becomeFirstResponder];
    }
    if (textField == passwordLbl) {
        [self loginBtnClick:nil];
    }
    return NO;
}

- (IBAction)loginBtnClick:(id)sender {
    NSString *username = [Utility trim:usernameLbl.text];
    if ([username isEqualToString:@""]) {
        msgLbl.text = USERNAMEEMPTY;
        return;
    }
    NSString *password = [Utility trim:passwordLbl.text];
    if ([password isEqualToString:@""]) {
        msgLbl.text = PASSWORDEMPTY;
        return;
    }
    msgLbl.text = UPLOADINGTEXT;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:username forKey:@"username"];
    [params setValue:password forKey:@"password"];
    NSData *data = [FmProxy getAccessToken:params];
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *json = [Utility dataToJsonObj:data];
    if (!json) {
        return;
    }
    NSInteger code = [[json objectForKey:@"code"] integerValue];
    if (code < 0) {
        msgLbl.text = LOGINFAILDTEXT;
        return;
    }
    NSString *token = [json objectForKey:TOKEN];
    NSDictionary *dict = [json objectForKey:@"data"];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:YES forKey:LOGIN];
    [ud setValue:token forKey:TOKEN];
    [ud setValue:[dict objectForKey:NICKNAME] forKey:NICKNAME];
    [ud setValue:[dict objectForKey:AVATAR] forKey:AVATAR];
    [ud setInteger:[[dict objectForKey:@"id"] integerValue] forKey:USERID];
    
    dataList.favList = [NSMutableArray array];
    
    [self didLoginSuccess];
}

- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didLoginSuccess {
    if (callBackTarget && loginCallback) {
        [callBackTarget performSelector:loginCallback];
    }
    [facade sendNotification:[Notification withName:LOGINSUCCESS]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
