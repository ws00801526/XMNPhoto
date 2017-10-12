//
//  XMNPhotoBrowserCell.m
//  XMNPhotoPickerFrameworkExample
//
//  Created by XMFraker on 16/6/13.
//  Copyright © 2016年 XMFraker. All rights reserved.
//


#import "XMNPhotoBrowserController.h"
#import "XMNPhotoBrowserCell.h"

#import "YYWebImage.h"
#import "XMNPhotoModel.h"


CGFloat kXMNPhotoBrowserCellPadding = 16.f;

@interface XMNPhotoBrowserCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) YYAnimatedImageView *imageView;

@end

@implementation XMNPhotoBrowserCell

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}


#pragma mark - Methods

/// ========================================
/// @name   Publis Methods
/// ========================================

- (void)configCellWithItem:(XMNPhotoModel *)item {
    
    __weak typeof(*&self) wSelf = self;
    [self.scrollView setZoomScale:1.0f];
    [self resizeSubviewsUsingSize:item.imageSize];
    
    /** 如果已经下载完毕 直接显示图片 不再去下载 */
    if (item.image) {
        self.imageView.image = item.image;
        return;
    }
    
    if (![NSURL URLWithString:item.imagePath]) {
        [self.imageView setImage:item.thumbnail];
        return;
    }
    
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:item.imagePath]
                           placeholder:item.thumbnail
                               options:YYWebImageOptionSetImageWithFadeAnimation
                              progress:NULL
                             transform:nil
                            completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                                if (!error && image) {
                                    __strong typeof(wSelf) self = wSelf;
                                    [self resizeSubviewsUsingSize:image.size];
                                }
                            }];
}

- (void)cancelImageRequest {

    [self.imageView yy_cancelCurrentImageRequest];
    [self.imageView yy_cancelCurrentHighlightedImageRequest];
}

/// ========================================
/// @name   Private Methods
/// ========================================

- (void)setup {
    
    self.backgroundColor = self.contentView.backgroundColor = [UIColor blackColor];
    
    [self.containerView addSubview:self.imageView];
    [self.scrollView addSubview:self.containerView];
    [self.contentView addSubview:self.scrollView];

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [self.contentView addGestureRecognizer:singleTap];
    [self.contentView addGestureRecognizer:doubleTap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPress.minimumPressDuration = .3f;
    [self.contentView addGestureRecognizer:longPress];

    [singleTap requireGestureRecognizerToFail:longPress];
    [doubleTap requireGestureRecognizerToFail:longPress];
}

- (void)resizeSubviewsUsingSize:(CGSize)originSize {
    
    CGSize size = [XMNPhotoModel adjustOriginSize:originSize
                                     toTargetSize:CGSizeMake(self.bounds.size.width - kXMNPhotoBrowserCellPadding, self.bounds.size.height)];
    if (CGSizeEqualToSize(self.imageView.frame.size, size)) {
#if DEBUG
        NSLog(@"resize is equal last will ignored");
#endif
        return;
    }
    
    self.containerView.frame = CGRectMake(0, 0, size.width, size.height);
    self.scrollView.contentSize = CGSizeMake(MAX(self.frame.size.width - kXMNPhotoBrowserCellPadding, self.containerView.bounds.size.width), MAX(self.frame.size.height, self.containerView.bounds.size.height));
    [self.scrollView scrollRectToVisible:self.bounds animated:NO];
    self.scrollView.alwaysBounceVertical = self.containerView.frame.size.height <= self.frame.size.height ? NO : YES;
    self.imageView.frame = self.containerView.bounds;
    [self scrollViewDidZoom:self.scrollView];
    self.scrollView.maximumZoomScale = MAX(3.0f, MAX(((self.bounds.size.width - kXMNPhotoBrowserCellPadding) / size.width), ((self.bounds.size.height) / size.height)));
}

- (void)handleSingleTap {
    
    __weak typeof(*&self) wSelf = self;
    self.singleTapBlock ? self.singleTapBlock(wSelf) : nil;
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)doubleTap {
    
    if (self.scrollView.zoomScale > 1.0f) {
        [self.scrollView setZoomScale:1.0 animated:YES];
    }else {
        CGPoint touchPoint = [doubleTap locationInView:self.imageView];
        CGFloat newZoomScale = self.scrollView.maximumZoomScale;
        CGFloat xsize = self.frame.size.width / newZoomScale;
        CGFloat ysize = self.frame.size.height / newZoomScale;
        [self.scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
}

- (void)handleLongPress:(UIGestureRecognizer *)ges {
    if (ges.state == UIGestureRecognizerStateBegan) {
        self.longPressHandler ? self.longPressHandler(self) : nil;
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
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - 16, self.bounds.size.height)];
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

- (UIImageView *)imageView {
    
    if (!_imageView) {
        
        _imageView = [[YYAnimatedImageView alloc] initWithFrame:self.bounds];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

@end
