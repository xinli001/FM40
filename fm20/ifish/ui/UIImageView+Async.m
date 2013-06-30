//
//  UIImageView+Async.m
//  fm20
//
//  Created by 黄力强 on 13-6-30.
//  Copyright (c) 2013年 xinli001. All rights reserved.
//

#import "UIImageView+Async.h"

@implementation UIImageView (Async)

-(void)initWithUrl:(NSString *)imageUrl placeholder:(NSString *)placeholder {
    UIImage *image = [self getImageFromCache:imageUrl];
    if (!image) {
        self.image = [UIImage imageNamed:placeholder];
        [self downloadImage:imageUrl];
    } else {
        self.image = image;
    }
}

-(void)downloadImage:(NSString *)imageUrl {
    [HttpClient get:imageUrl handler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error == nil && data.length > 0) {
            self.image = [[UIImage alloc] initWithData:data];
        }
    }];
}

-(UIImage *)getImageFromCache:(NSString *)imageUrl {
    NSString *imageName = [self getImageName:imageUrl];
    NSString *filePath = [self getImageFile:imageName];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];
    return image;
}

-(NSString *)getImageName:(NSString *)imageUrl {
    NSArray *pathParts = [imageUrl componentsSeparatedByString:@"/"];
    return [pathParts lastObject];
}

-(NSString *)getImageFile:(NSString *)imageName {
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [cacheDir stringByAppendingPathComponent:imageName];
}

@end
