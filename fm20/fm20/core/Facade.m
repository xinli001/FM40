//
//  Facade.m
//  fm
//
//  Created by 黄力强 on 12-12-22.
//  Copyright (c) 2012年 黄力强. All rights reserved.
//

#import "Facade.h"

static Facade *instance;

@implementation Facade

@synthesize tvLocked, fmType;

+(Facade *)getInstance {
    if (instance == nil) {
        instance = [[self alloc] init];
    }
    return instance;
}

-(id)init {
    if (self = [super init]) {
        tvLocked = NO;
        fmType = 0;
        fmPage = 0;
        fmPageSize = 10;
    }
    return self;
}


@end
