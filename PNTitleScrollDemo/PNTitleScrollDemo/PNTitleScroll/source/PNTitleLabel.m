//
//  PNTitleLabel.m
//  111111
//
//  Created by lpn on 16/4/6.
//  Copyright © 2016年 liupanniu. All rights reserved.
//
#define  scale(scale) scale * 0.2 + 0.8

#import "PNTitleLabel.h"

@implementation PNTitleLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        
        self.textColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
        self.scale = 0.0;
    }
    return self;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    if (!font.pointSize) {
//        font = [UIFont systemFontOfSize:12.0];
    }
    
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    // 文字颜色的变化灰色r102 g102 b102->红 r214 g27 b27    渐渐不红  --  渐渐红
    self.transform = CGAffineTransformMakeScale(scale(scale), scale(scale));
    self.textColor = [UIColor colorWithRed:(112.0 * scale+102.0)/255.0 green:(-75.0 * scale+102.0)/255.0 blue:(-75.0 * scale+102.0)/255.0 alpha:1];

}

@end
