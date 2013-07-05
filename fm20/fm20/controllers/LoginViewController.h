//
//  LoginViewController.h
//  fm
//
//  Created by 黄力强 on 12-12-27.
//  Copyright (c) 2012年 黄力强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMediator.h"
#import "Facade.h"
#import "Constant.h"
#import "LoginVO.h"
#import "FmProxy.h"
#import "DataList.h"

@interface LoginViewController : UIViewController <IMediator, UITextFieldDelegate> {
    SEL loginCallback;
    id callBackTarget;
    Facade *facade;
    DataList *dataList;
}

@property (weak, nonatomic) IBOutlet UITextField *usernameLbl;
@property (weak, nonatomic) IBOutlet UITextField *passwordLbl;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *msgLbl;
@property (nonatomic) SEL loginCallback;
@property (nonatomic) id callBackTarget;

- (IBAction)loginBtnClick:(id)sender;
- (IBAction)backBtnClick:(id)sender;

@end
