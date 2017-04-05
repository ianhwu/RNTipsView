//
//  RNTipsView.m
//  RNTipsView
//
//  Created by yan on 2017/3/24.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "RNTipsView.h"

@interface RNTipsView ()

@property (nonatomic, strong) NSMutableArray *paths;

@end

@implementation RNTipsView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.paths = [[NSMutableArray alloc]init];
        self.lineWidth = 3.0f;
        self.lineColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    return  self;
}


- (NSData *)exportWithRect:(CGRect)rect
{
    return UIImagePNGRepresentation([self convertViewToImage:self rect:rect]);
}

- (UIImage *)convertViewToImage:(UIView*)view rect:(CGRect)rect {
    CGSize s = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    for (int i=0; i < self.paths.count; i++) {
        NSMutableArray *pathPoints = [self.paths objectAtIndex:i];
        CGMutablePathRef path = CGPathCreateMutable();
        CGContextSetLineWidth(ctx, self.lineWidth);
        for (int j = 0; j<pathPoints.count; j++) {
            CGPoint point = [[pathPoints objectAtIndex:j]CGPointValue] ;
            if (j == 0) {
                CGPathMoveToPoint(path, &CGAffineTransformIdentity, point.x,point.y);
            }else{
                CGPathAddLineToPoint(path, &CGAffineTransformIdentity, point.x, point.y);
            }
        }
        CGContextSetStrokeColorWithColor(ctx, self.lineColor.CGColor);
        CGContextAddPath(ctx, path);
        CGContextStrokePath(ctx);
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSMutableArray *path = [[NSMutableArray alloc]init];
    [self.paths addObject:path];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSMutableArray *path = [self.paths lastObject];
    UITouch *touch = [touches anyObject];
    UIGestureRecognizer *ges = touch.gestureRecognizers[0];
    if (ges.numberOfTouches == 1) {
        CGPoint movePoint = [touch locationInView:self];
        [path addObject:[NSValue valueWithCGPoint:movePoint]];
        [self setNeedsDisplay];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (void)clear {
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

@end
