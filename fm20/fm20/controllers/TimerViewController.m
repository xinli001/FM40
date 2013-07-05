//
//  TimerViewController.m
//  fm20
//
//  Created by 壹 心理 on 13-6-7.
//  Copyright (c) 2013年 壹心理. All rights reserved.
//

#import "TimerViewController.h"


@interface TimerViewController ()
@end

@implementation TimerViewController
@synthesize timer,timeremain,cancelBtn;

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
    timerCount=[TimerCount getInstance];
    facade = [Facade getInstance];
    [facade addMediator:self];
    timeremain.text=timerCount.timerRemain;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)halfAnHourBtnClick:(id)sender
{
    [timerCount startCount:1800];
    timeremain.text=timerCount.timerRemain;
}
- (IBAction)oneHourBtnClick:(id)sender
{
    [timerCount startCount:3600];
    timeremain.text=timerCount.timerRemain;
}

- (IBAction)oneAndAHalfHourBtnClick:(id)sender
{
    [timerCount startCount:5400];
    timeremain.text=timerCount.timerRemain;
}

- (IBAction)twoHourBtnClick:(id)sender
{
    [timerCount startCount:7200];
    timeremain.text=timerCount.timerRemain;
}



- (IBAction)cancelBtnClick:(id)sender
{
    [timerCount cancelTimer];
    timeremain.text=Nil;
    timerCount.timerRemain=nil;
}


- (void)viewDidUnload {
    [timerCount cancelTimer];
    [super viewDidUnload];
}

-(NSString *)mediatorName{
   return @"TimerViewController"; 
}

- (void)handleNotification:(Notification *)notification {
    NSString *name = notification.name;
    if(name==REFRESHNOTIFICATION){
        timeremain.text=timerCount.timerRemain;
    }
}


@end
