//
//  RNTipsView.h
//  RNTipsView
//
//  Created by yan on 2017/3/24.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImageSaveType) {
    ImageSaveTypeTemp,
    ImageSaveTypeCache,
// Todo:
//    save image to photos album
//    ImageSaveTypePhoto
};

@interface RNTipsView : UIView

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) ImageSaveType cacheType;

- (NSData *)exportWithRect:(CGRect)rect;
- (void)clear;

@end
