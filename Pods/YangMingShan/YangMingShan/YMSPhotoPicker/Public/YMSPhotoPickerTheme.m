//
//  YMSPhotoPickerTheme.m
//  YangMingShan
//
//  Copyright 2016 Yahoo Inc.
//  Licensed under the terms of the BSD license. Please see LICENSE file in the project root for terms.
//

#import "YMSPhotoPickerTheme.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
                 blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
                alpha:1.0]

@implementation UIColor (YMSPhotoPickerTheme)

+ (UIColor *)systemBlueColor
{
    static UIColor *systemBlueColor = nil;
    if (!systemBlueColor) {
        systemBlueColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0];
    }
    return systemBlueColor;
}

@end

@implementation YMSPhotoPickerTheme

+ (instancetype)sharedInstance
{
    static YMSPhotoPickerTheme *instance;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        instance = [[YMSPhotoPickerTheme alloc] init];
        [instance reset];
    });
    return instance;
}

- (void)reset
{
    self.tintColor = UIColorFromRGB(0xbd081c);
    self.orderTintColor = UIColorFromRGB(0xca3949);
    self.cameraVeilColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    self.orderLabelTextColor = self.navigationBarBackgroundColor = self.cameraIconColor = [UIColor whiteColor];
    self.titleLabelTextColor = [UIColor blackColor];
    self.statusBarStyle = UIStatusBarStyleDefault;
    self.titleLabelFont = [UIFont systemFontOfSize:18.0];
    self.albumNameLabelFont = [UIFont systemFontOfSize:18.0 weight:UIFontWeightLight];
    self.photosCountLabelFont = [UIFont systemFontOfSize:18.0 weight:UIFontWeightLight];
    self.selectionOrderLabelFont = [UIFont systemFontOfSize:17.0];
}

@end
