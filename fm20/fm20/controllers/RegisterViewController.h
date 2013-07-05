//
//  RegisterViewController.h
//  fm
//
//  Created by 黄力强 on 12-12-31.
//  Copyright (c) 2012年 黄力强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "Constant.h"
#import "RegisterVO.h"
#import "FmProxy.h"
#import "Facade.h"

@interface RegisterViewController : UIViewController <UITextFieldDelegate> {
    Facade *facade;
}

@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *nicknameTF;
@property (weak, nonatomic) IBOutlet UITextField *password1TF;
@property (weak, nonatomic) IBOutlet UITextField *password2TF;
@property (weak, nonatomic) IBOutlet UILabel *msgLbl;

- (IBAction)registerBtnClick:(id)sender;
- (IBAction)backBtnClick:(id)sender;

@end
