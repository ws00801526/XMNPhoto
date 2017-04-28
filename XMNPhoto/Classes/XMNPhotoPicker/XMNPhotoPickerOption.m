//
//  XMNPhotoPickerOption.m
//  XMNPhotoPicker
//
//  Created by XMFraker on 16/7/19.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import "XMNPhotoPickerOption.h"
#import "XMNPhotoPickerDefines.h"

static CGFloat gPadding = 16.f;
static BOOL   gPanGestureEnabled = YES;
static CGFloat gDuration = .3f;
static NSUInteger  gImageViewTag = 999;
static NSBundle *gBundle;

@implementation XMNPhotoPickerOption

+ (void)initialize {

    gBundle = [NSBundle bundleWithIdentifier:@"org.cocoapods.XMNPhoto"];
    if (!gBundle) {
        gBundle = [NSBundle mainBundle];
    }
}


+ (BOOL)isPanGestureEnabled {
    
    return gPanGestureEnabled;
}

+ (void)setPanGestureEnabled:(BOOL)enabled {
    
    gPanGestureEnabled = enabled;
}


+ (NSInteger)previewPadding {
    
    return gPadding;
}

+ (void)setPreviewPadding:(CGFloat)previewPadding {
    
    gPadding = previewPadding;
}


+ (CGFloat)sendingPictureAnimationDuration {
    
    return gDuration;
}


+ (void)setSendingPictureAnimationDuration:(CGFloat)duration {
    
    gDuration = gDuration;
}


+ (NSInteger)sendingImageViewTag {
    
    return gImageViewTag;
}

+ (void)setSendingImageViewTag:(NSInteger)tag {
    
    gImageViewTag = tag;
}

+ (NSBundle * _Nonnull)resourceBundle {
    
    return gBundle;
}

+ (void)setResourceBundle:(NSBundle * _Nonnull)bundle {
    
    if (bundle) {
        gBundle = bundle;
    }
}

+ (UICollectionViewLayout *)photoCollectionViewLayoutWithWidth:(CGFloat)width {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin = kXMNMargin;
    layout.itemSize = kXMNThumbnailSize;
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    return layout;
}
@end


