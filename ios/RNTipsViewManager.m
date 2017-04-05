//
//  RNTipsViewManager.m
//  RNTipsView
//
//  Created by yan on 2017/3/24.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "RNTipsViewManager.h"
#import "RNTipsView.h"
#import <React/RCTUIManager.h>

@interface RNTipsViewManager ()

@end

@implementation RNTipsViewManager

RCT_EXPORT_MODULE();

- (UIView *)view
{
    return [[RNTipsView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(lineWidth, CGFloat);
RCT_EXPORT_VIEW_PROPERTY(lineColor, UIColor);
RCT_EXPORT_VIEW_PROPERTY(backgroundColor, UIColor);
RCT_EXPORT_VIEW_PROPERTY(cacheType, NSInteger);

RCT_EXPORT_METHOD(cutImage:(int)tag callback:(RCTResponseSenderBlock)callback) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
        RNTipsView *view = (RNTipsView *)viewRegistry[@(tag)];
        if ([view isKindOfClass:[RNTipsView class]]) {
            NSData *imageData = [view exportWithRect:view.bounds];
            NSString *imageStr = [imageData base64EncodedStringWithOptions:0];
            if (view.cacheType == 0) {
                NSString *tempDir = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"/%ld.png", (long)[[NSDate date] timeIntervalSince1970]]];
                if ([imageData writeToFile:tempDir atomically:YES]) {
                    imageStr = tempDir;
                } else {
                    imageStr = [NSString stringWithFormat:@"data:image/png;base64,%@", imageStr];
                }
            } else {
                imageStr = [NSString stringWithFormat:@"data:image/png;base64,%@", imageStr];
            }
            if (imageStr) {
                callback(@[imageStr]);
            } else {
                callback(@[@"wrong view"]);
            }
        }
    }];
}

RCT_EXPORT_METHOD(clear:(int)tag) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
        RNTipsView *view = (RNTipsView *)viewRegistry[@(tag)];
        if ([view isKindOfClass:[RNTipsView class]]) {
            [view clear];
        }
    }];
}


@end
