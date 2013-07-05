//
//  OptionViewController.h
//  fm
//
//  Created by 黄力强 on 13-1-4.
//  Copyright (c) 2013年 黄力强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMFeedback.h"
#import "Constant.h"
#import "Utility.h"
#import "IMediator.h"
#import "Facade.h"

@interface OptionViewController : UIViewController <IMediator> {
    Facade *facade;
}

@property (weak, nonatomic) IBOutlet UILabel *userLbl;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

- (IBAction)feedbackBtnClick:(id)sender;
- (IBAction)pingfenBtnClick:(id)sender;
- (IBAction)backBtnClick:(id)sender;
- (IBAction)siteBtnClick:(id)sender;
- (IBAction)logoutBtnClick:(id)sender;
@end
