//
//  XMNPhotoBrowser.h
//  XMNPhotoBrowser
//
//  Created by XMFraker on 16/6/13.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for XMNPhotoBrowser.
FOUNDATION_EXPORT double XMNPhotoBrowserVersionNumber;

//! Project version string for XMNPhotoBrowser.
FOUNDATION_EXPORT const unsigned char XMNPhotoBrowserVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <XMNPhotoBrowser/PublicHeader.h>

#import <YYWebImage/YYWebImage.h>

#if __has_include(<XMNPhoto/XMNPhoto.h>)

#import <XMNPhoto/XMNPhotoModel.h>
#import <XMNPhoto/XMNPhotoBrowserCell.h>
#import <XMNPhoto/XMNPhotoBrowserController.h>

#else

#import "XMNPhotoModel.h"
#import "XMNPhotoBrowserCell.h"
#import "XMNPhotoBrowserController.h"

#endif
