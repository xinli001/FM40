//
//  TimerViewController.h
//  fm20
//
//  Created by 壹 心理 on 13-6-7.
//  Copyright (c) 2013年 壹心理. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facade.h"
#import "TimerCount.h"
#import "IMediator.h"
#import "Constant.h"


@interface TimerViewController : UIViewController<IMediator>{
    Facade *facade;
    TimerCount *timerCount;
}

@property NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeremain;
- (IBAction)backBtnClick:(id)sender;
- (IBAction)halfAnHourBtnClick:(id)sender;
- (IBAction)oneHourBtnClick:(id)sender;
- (IBAction)oneAndAHalfHourBtnClick:(id)sender;
- (IBAction)twoHourBtnClick:(id)sender;
- (IBAction)cancelBtnClick:(id)sender;
@end
