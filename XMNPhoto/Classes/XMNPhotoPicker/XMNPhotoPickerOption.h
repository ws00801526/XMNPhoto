//
//  XMNPhotoPickerOption.h
//  XMNPhotoPicker
//
//  Created by XMFraker on 16/7/19.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMNPhotoPickerOption : NSObject

/**
 *  @brief 是否允许XMNPhotoPickerSheet 拖动图片发送
 *
 *  @return YES or NO
 */
+ (BOOL)isPanGestureEnabled;
/**
 *  @brief 设置是否允许XMNPhotoPickerSheet拖动图片发送
 *
 *  @param enabled YES or NO
 */
+ (void)setPanGestureEnabled:(BOOL)enabled;

/**
 *  @brief 预览图片,视频时间距
 *
 *  @return  间隔大小 默认16.f
 */
+ (NSInteger)previewPadding;
/**
 *  @brief 设置预览图片,视频时间距
 *
 *  @param previewPadding  间隔大小 默认16.f
 */
+ (void)setPreviewPadding:(CGFloat)previewPadding;

/**
 *  @brief 拖动图片发送时 图片动画时间
 *
 *  @return 时间间隔 默认.3f
 */
+ (CGFloat)sendingPictureAnimationDuration;

/**
 *  @brief 设置拖动图片发送时动画时间
 *  默认.3f
 *  @param duration  时间间隔
 */
+ (void)setSendingPictureAnimationDuration:(CGFloat)duration;

/**
 *  @brief 发送图片时,显示图片的imageView tag
 *
 *  @return  tag 标签
 */
+ (NSInteger)sendingImageViewTag;
/**
 *  @brief 设置发送图片时,显示图片的imageView Tag
 *  默认999
 *  @param tag  tag内容
 */
+ (void)setSendingImageViewTag:(NSInteger)tag;

/**
 *  根据给定宽度 获取UICollectionViewLayout 实例
 *
 *  @param width collectionView 宽度
 *
 *  @return UICollectionViewLayout实例
 */
+ (UICollectionViewLayout * _Nonnull)photoCollectionViewLayoutWithWidth:(CGFloat)width;

@end

@interface XMNPhotoPickerOption (XMNDeprecated)

/**
 *  @brief 设置资源文件所在的bundle
 *
 *  @param bundle 设置bundle实例
 */
+ (void)setResourceBundle:(NSBundle * _Nonnull)bundle NS_UNAVAILABLE;

@end
