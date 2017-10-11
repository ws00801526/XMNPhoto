//
//  XMNPhotoBrowserCell.h
//  XMNPhotoPickerFrameworkExample
//
//  Created by XMFraker on 16/6/13.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMNPhotoModel;
@class YYAnimatedImageView;
@interface XMNPhotoBrowserCell : UICollectionViewCell

@property (nonatomic, strong, readonly, nonnull) YYAnimatedImageView *imageView;

@property (nonatomic, copy, nullable)   void(^singleTapBlock)(XMNPhotoBrowserCell * _Nonnull  browserCell);
@property (nonatomic, copy, nullable)   void(^longPressHandler)(XMNPhotoBrowserCell * _Nonnull  browserCell);

- (void)configCellWithItem:(XMNPhotoModel * _Nonnull )item;
- (void)cancelImageRequest;
@end
