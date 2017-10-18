//
//  UIImageView+Extension.m
//  SDweb
//
//  Created by GDBank on 2017/10/17.
//  Copyright © 2017年 com.GDBank.Company. All rights reserved.
//

#import "UIImageView+Extension.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <FLAnimatedImageView+WebCache.h>

@implementation UIImageView (Extension)

/**
 *  异步加载图片（无占位图）
 */
- (void)downloadImage:(NSString *)urlStr{
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority];
}

/**
 *  异步加载图片（有占位图）
 */
- (void)downloadImage:(NSString *)urlStr placeholder:(NSString *)imageName {
    
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:imageName] options:SDWebImageRetryFailed|SDWebImageLowPriority];
}

/**
 *  异步加载Gif图片（有占位图）
 */
-(void)downloadGifImage:(NSString *)urlStr placeholder:(NSString *)imageName{
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:imageName]];
}

/**
 *  异步加载图片，监听下载进度、成功、失败
 */
- (void)downloadImage:(NSString *)urlStr placeholder:(NSString *)imageName success:(DownImageSuccessBlock)success failed:(DownImageFailedBlock)failed progress:(DownImageProgressBlock)progress {
    
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:imageName] options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
        progress(receivedSize * 1.0 / expectedSize);
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (error) {
            failed(error);
        } else {
            self.image = image;
            success(image);
        }
    }];
}

@end
