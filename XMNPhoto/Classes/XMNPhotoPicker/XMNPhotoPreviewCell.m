//
//  XMNPhotoPreviewCell.m
//  XMNPhotoPickerFrameworkExample
//
//  Created by XMFraker on 16/1/29.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import "XMNPhotoPreviewCell.h"

#import "YYImage.h"
#import "XMNAssetModel.h"
#import "XMNPhotoPickerOption.h"
#import "XMNPhotoPickerDefines.h"

#import "UIImage+XMNResize.h"

@interface XMNPhotoPreviewCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) YYAnimatedImageView *imageView;

@end

@implementation XMNPhotoPreviewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _setup];
    }
    return self;
}

#pragma mark - Methods

- (void)configCellWithItem:(XMNAssetModel *)item {
    
    [self.scrollView setZoomScale:1.0f];
    if (item.isGIF) {
        self.imageView.image = [YYImage imageWithData:item.imageData scale:[UIScreen mainScreen].scale];
    } else {
        self.imageView.image = item.previewImage;
    }
    [self _resizeSubviews];
}

- (void)_setup {
    
    self.backgroundColor = self.contentView.backgroundColor = [UIColor blackColor];
    
    [self.containerView addSubview:self.imageView];
    [self.scrollView addSubview:self.containerView];
    [self.contentView addSubview:self.scrollView];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleSingleTap)];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [self.contentView addGestureRecognizer:singleTap];
    [self.contentView addGestureRecognizer:doubleTap];
}

- (void)_resizeSubviews {
    
    self.containerView.frame = self.bounds;
    UIImage *image = self.imageView.image;
    if (!image) {
        return;
    }
    CGSize size = [image xmn_fittedSizeForTargetSize:CGSizeMake(self.bounds.size.width - [XMNPhotoPickerOption previewPadding], self.bounds.size.height)];
    self.containerView.frame = CGRectMake(0, 0, size.width, size.height);
    
    self.scrollView.contentSize = CGSizeMake(MAX(self.frame.size.width - 16, self.containerView.bounds.size.width), MAX(self.frame.size.height, self.containerView.bounds.size.height));
    [self.scrollView scrollRectToVisible:self.bounds animated:NO];
    self.scrollView.alwaysBounceVertical = self.containerView.frame.size.height <= self.frame.size.height ? NO : YES;
    self.imageView.frame = self.containerView.bounds;
    [self scrollViewDidZoom:self.scrollView];
    self.scrollView.maximumZoomScale = MAX(MAX(image.size.width/(self.bounds.size.width), image.size.height / self.bounds.size.height), 3.f);
}

- (void)_handleSingleTap {
    self.singleTapBlock ? self.singleTapBlock() : nil;
}

- (void)_handleDoubleTap:(UITapGestureRecognizer *)doubleTap {
    
    if (self.scrollView.zoomScale > 1.0f) {
        [self.scrollView setZoomScale:1.0 animated:YES];
    } else {
        CGPoint touchPoint = [doubleTap locationInView:self.imageView];
        CGFloat newZoomScale = self.scrollView.maximumZoomScale;
        CGFloat xsize = self.frame.size.width / newZoomScale;
        CGFloat ysize = self.frame.size.height / newZoomScale;
        [self.scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
}


#pragma mark - UIScrollViewDelegate

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.containerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat offsetX = (scrollView.frame.size.width > scrollView.contentSize.width) ? (scrollView.frame.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.frame.size.height > scrollView.contentSize.height) ? (scrollView.frame.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.containerView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

#pragma mark - Getters

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - [XMNPhotoPickerOption previewPadding], self.bounds.size.height)];
        _scrollView.bouncesZoom = YES;
        _scrollView.maximumZoomScale = 3.0f;
        _scrollView.minimumZoomScale = 1.0f;
        _scrollView.multipleTouchEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.delaysContentTouches = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.alwaysBounceVertical = NO;
    }
    return _scrollView;
}


- (UIView *)containerView {
    
    if (!_containerView) {
        
        _containerView = [[UIView alloc] initWithFrame:self.bounds];
        _containerView.clipsToBounds = YES;
    }
    return _containerView;
}

- (YYAnimatedImageView *)imageView {
    if (!_imageView) {
        
        _imageView = [[YYAnimatedImageView alloc] initWithFrame:self.bounds];
        _imageView.backgroundColor = [UIColor blackColor];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}
@end
