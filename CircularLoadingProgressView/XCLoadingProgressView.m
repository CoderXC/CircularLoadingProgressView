//
//  XCLoadingProgressView.m
//  CircularLoadingProgressView
//
//  Created by 小蔡 on 16/6/22.
//  Copyright © 2016年 小蔡. All rights reserved.
//

#import "XCLoadingProgressView.h"

@interface XCLoadingProgressView ()

@property (nonatomic, strong) CAShapeLayer * loadingLayer;
@property (nonatomic, strong) CAShapeLayer * circleLayer;
@property (nonatomic, strong) CAShapeLayer * pieLayer;

@end

@implementation XCLoadingProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.fillColor = [UIColor clearColor].CGColor;
    self.circleLayer.lineWidth = 1;
    self.circleLayer.strokeColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.circleLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
    self.circleLayer.hidden = YES;
    [self.layer addSublayer:self.circleLayer];
    
    
    self.loadingLayer = [CAShapeLayer layer];
    self.loadingLayer.frame = self.bounds;
    self.loadingLayer.anchorPoint  = CGPointMake(0.5f, 0.5f);
    self.loadingLayer.fillColor = [UIColor clearColor].CGColor;
    self.loadingLayer.lineWidth = 1;
    self.loadingLayer.strokeColor = [UIColor groupTableViewBackgroundColor].CGColor;
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat loadRadius = self.bounds.size.width/2;
    CGFloat endAngle = (2 * (float)M_PI) - ((float)M_PI / 8);
    self.loadingLayer.path = [UIBezierPath bezierPathWithArcCenter:center radius:loadRadius startAngle:0 endAngle:endAngle clockwise:YES].CGPath;
    [self.layer addSublayer:self.loadingLayer];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [self.loadingLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    
    CGFloat minSide = MIN(CGRectGetWidth(rect), CGRectGetHeight(rect));
    CGFloat radius = minSide/2 - 3;
    self.pieLayer = [CAShapeLayer layer];
    self.pieLayer.frame = self.bounds;
    self.pieLayer.anchorPoint  = CGPointMake(0.5f, 0.5f);
    self.pieLayer.fillColor = [UIColor clearColor].CGColor;
    self.pieLayer.strokeColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.pieLayer.lineWidth = radius;
    CGRect pathRect = CGRectMake(CGRectGetWidth(self.bounds)/2 - radius/2, CGRectGetHeight(self.bounds)/2 - radius/2, radius, radius);
    self.pieLayer.path = [UIBezierPath bezierPathWithRoundedRect:pathRect cornerRadius:radius].CGPath;
    [self.layer addSublayer:self.pieLayer];
    self.pieLayer.strokeStart = 0;
    self.pieLayer.strokeEnd = 0;
}

- (void)setProgress:(float)progress
{
    progress = MAX(0.0f, progress);
    progress = MIN(1.0f, progress);
    
    if (progress > 0) {
        [self.loadingLayer removeAllAnimations];
        self.circleLayer.hidden = NO;
        [self.loadingLayer removeFromSuperlayer];
    }
    
    if (progress != _progress) {
        self.pieLayer.strokeEnd = progress;
        _progress = progress;
    }
    
    if (progress == 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
