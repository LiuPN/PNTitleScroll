//
//  PNContentScrollView.m
//  111111
//
//  Created by liupanniu on 16/3/31.
//  Copyright (c) 2016年 liupanniu. All rights reserved.
//



#import "UIView+HMExtension.h"
#import "PNContentScrollView.h"

@implementation PNContentScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        self.pagingEnabled = YES;
        
        self.showsHorizontalScrollIndicator = NO;
        
    }
    return self;
}


+ (instancetype)contentScrollViewFrame:(CGRect)frame
{
    
    return [[self alloc] initWithFrame:frame];
}



@end
