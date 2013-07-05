//
//  RegisterViewController.m
//  fm
//
//  Created by 黄力强 on 12-12-31.
//  Copyright (c) 2012年 黄力强. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize usernameTF, nicknameTF, password1TF, password2TF, msgLbl;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setUsernameTF:nil];
    [self setNicknameTF:nil];
    [self setPassword1TF:nil];
    [self setPassword2TF:nil];
    [self setMsgLbl:nil];
    [super viewDidUnload];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == usernameTF) {
        [nicknameTF becomeFirstResponder];
    }
    if (textField == nicknameTF) {
        [password1TF becomeFirstResponder];
    }
    if (textField == password1TF) {
        [password2TF becomeFirstResponder];
    }
    if (textField == password2TF) {
        [password2TF resignFirstResponder];
        [self registerBtnClick:nil];
    }
    return NO;
}

- (IBAction)registerBtnClick:(id)sender {
    NSString *username = [Utility trim:usernameTF.text];
    if ([username isEqualToString:@""]) {
        msgLbl.text = USERNAMEEMPTY;
        return;
    }
    NSString *nickname = [Utility trim:nicknameTF.text];
    if ([nickname isEqualToString:@""]) {
        msgLbl.text = NICKNAMEEMPTY;
        return;
    }
    NSString *password1 = [Utility trim:password1TF.text];
    if ([password1 isEqualToString:@""]) {
        msgLbl.text = PASSWORD1EMPTY;
        return;
    }
    NSString *password2 = [Utility trim:password2TF.text];
    if ([password2 isEqualToString:@""]) {
        msgLbl.text = PASSWORD2EMPTY;
        return;
    }
    if (![password1 isEqualToString:password2]) {
        msgLbl.text = PASSWORD2ERROR;
        return;
    }
    msgLbl.text = UPLOADINGTEXT;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:username forKey:@"username"];
    [dict setValue:nickname forKey:@"nickname"];
    [dict setValue:password1 forKey:@"password1"];
    [dict setValue:password2 forKey:@"password2"];
    [dict setValue:@"FMIOS" forKey:@"laiyuan"];
    NSData *data = [FmProxy registerUser:dict];
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    dict = [Utility dataToJsonObj:data];
    NSInteger code = [[dict objectForKey:@"code"] integerValue];
    if (code == 0) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:username forKey:USERNAME];
        [ud setObject:password2 forKey:PASSWORD];
        [self.navigationController popViewControllerAnimated:NO];
        [facade sendNotification:[Notification withName:REGISTERSUCCESS]];
    } else {
        switch (code) {
            case -1:
            case -4:
                msgLbl.text = USERNAMEERROR;
                break;
            case -2:
                msgLbl.text = PASSWORD2ERROR;
                break;
            case -3:
            case -5:
                msgLbl.text = NICKNAMEERROR;
                break;
            default:
                msgLbl.text = REGISTERERROR;
                break;
        }
    }
}

- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
