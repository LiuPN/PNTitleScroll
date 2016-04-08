//
//  PNTitleScrollTools.h
//  111111
//
//  Created by lpn on 16/4/5.
//  Copyright © 2016年 liupanniu. All rights reserved.
//


/// 默认title文字的大小
#define PNDEFAULT_TITLE_MAXFONT [UIFont systemFontOfSize:17.0]

// 标题之间的间隙
#define PNMargin 0


/// 屏幕的宽高
#define PNScreenWidth [UIScreen mainScreen].bounds.size.width
#define PNScreenHeight [UIScreen mainScreen].bounds.size.height

/// 标题文字变大或者变小 以及下划线的移动时间
#define PNTitleChangeTime 0.3





#import <Foundation/Foundation.h>
#import "PNContentScrollView.h"
#import "PNTitleScrollView.h"
#import "UIView+HMExtension.h"
#import "PNTitleLabel.h"
@interface PNTitleScrollTools : NSObject

/// 创建对象类方法
+ (instancetype)tools;

/// 接收数组
- (void)titleScrollToolsArr:(NSArray *)arr;


/**
 工具类方法， 添加titleView视图到vc上
 vc 添加到哪个视图上
 frame  CGRect 该视图相对于vc的view的frame
 maxValue  CGFloat 当title被点击之后，所显示的最大字体大小值 maxValue为0.0时候  默认是是17.0

 cellNum: int 在当前控制器view中，titleView里显示的能看到的label个数 默认是4
 */
- (PNTitleScrollView *)titleScrollToolsSetupTitleViewWithVc:(UIViewController *)vc WithFrame:(CGRect)frame maxFontValue:(CGFloat)maxValue cellNum:(int)cellNum;



/**
 工具类方法， 添加contentView视图到vc上
 vc 添加到哪个视图上
 frame  CGRect 该视图相对于vc的view的frame
 */
- (PNContentScrollView *)titleScrollToolsSetupContentViewWithVc:(UIViewController *)vc frame:(CGRect)frame;





@end
