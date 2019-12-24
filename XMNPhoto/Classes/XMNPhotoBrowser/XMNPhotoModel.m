//
//  XMNPhotoModel.m
//  XMNPhotoPickerFrameworkExample
//
//  Created by XMFraker on 16/6/13.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import "XMNPhotoModel.h"

#import "YYWebImage.h"

@implementation XMNPhotoModel

- (instancetype)initWithImagePath:(NSString *)imagePath
                        thumbnail:(UIImage *)thumnail {
    
    if (self = [super init]) {
        
        _imagePath = [imagePath copy];
        _thumbnail = thumnail;
    }
    return self;
}

- (instancetype)initWithImagePath:(NSString *)imagePath
                    thumbnailData:(NSData *)thumnailData {
    
    return [self initWithImagePath:imagePath
                         thumbnail:[[YYImage alloc] initWithData:thumnailData
                                                           scale:[UIScreen mainScreen].scale]];
}

#pragma mark - Getters

- (CGSize)imageSize {
    
    if (CGSizeEqualToSize(_imageSize, CGSizeZero)) {
        
        if (self.image) {
            CGFloat scale = self.image.scale;
           _imageSize = CGSizeApplyAffineTransform(self.image.size, CGAffineTransformMakeScale(scale, scale));
        }
        
        if (self.thumbnail) {
            CGFloat scale = self.thumbnail.scale;
            _imageSize = CGSizeApplyAffineTransform(self.thumbnail.size, CGAffineTransformMakeScale(scale, scale));
        }
    }
    return _imageSize;
}

- (UIImage *)image {
    
    if (![self.imagePath hasPrefix:@"http"]) {
        return [UIImage imageWithContentsOfFile:self.imagePath];
    }
    return [[YYWebImageManager sharedManager].cache getImageForKey:[[YYWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:self.imagePath]]];
}

#pragma mark - Class Methods

+ (CGSize)adjustOrigin:(CGSize)origin toTarget:(CGSize)target {
    
    CGSize size = CGSizeMake(origin.width, origin.height);
    /** 计算图片的比例 */
    CGFloat widthPercent = (origin.width ) / (target.width);
    CGFloat heightPercent = (origin.height ) / target.height;
    if (widthPercent <= 1.0f && heightPercent <= 1.0f) {
        size = CGSizeMake(origin.width, origin.height);
    } else if (widthPercent > 1.0f && heightPercent < 1.0f) {
        size = CGSizeMake(target.width, (origin.height * target.width) / origin.width);
    } else if (widthPercent <= 1.0f && heightPercent > 1.0f) {
        size = CGSizeMake((target.height * origin.width) / origin.height, target.height);
    } else {
        if (widthPercent > heightPercent) {
            size = CGSizeMake(target.width, (origin.height * target.width) / origin.width);
        } else {
            size = CGSizeMake((target.height * origin.width) / origin.height, target.height);
        }
    }
    return size;
}

@end
