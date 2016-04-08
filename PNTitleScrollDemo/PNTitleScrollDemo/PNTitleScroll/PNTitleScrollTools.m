//
//  PNTitleScrollTools.m
//  111111
//
//  Created by lpn on 16/4/5.
//  Copyright © 2016年 liupanniu. All rights reserved.
//

#import "PNTitleScrollTools.h"


@interface PNTitleScrollTools ()
/// 标题数组
@property(nonatomic, strong) NSArray *arr;
/// 标题
@property(nonatomic, weak) PNTitleScrollView *titleView;
/// 内容
@property(nonatomic, weak) PNContentScrollView *contentScrollView;
@end

@implementation PNTitleScrollTools

/// 类方法
+ (instancetype)tools
{
    PNTitleScrollTools *tools = [[self alloc] init];
    return tools;
}


/// 接收到数组
- (void)titleScrollToolsArr:(NSArray *)arr
{
    self.arr = arr;
}


- (PNTitleScrollView *)titleScrollToolsSetupTitleViewWithVc:(UIViewController *)vc WithFrame:(CGRect)frame maxFontValue:(CGFloat)maxValue cellNum:(int)cellNum
{
    // 创建对象
    PNTitleScrollView * titleView = [PNTitleScrollView titleScrollViewWithFrame:frame maxFontValue:maxValue cellNum:cellNum];
    self.titleView = titleView;
    // 设置标题数组
    titleView.titleArr = self.arr;
    
    [vc.view addSubview:titleView];
    
    
    // 返回
    return titleView;
    

}

/// contentView
- (PNContentScrollView *)titleScrollToolsSetupContentViewWithVc:(UIViewController *)vc frame:(CGRect)frame
{
    // 创建
    PNContentScrollView *contentScrollView = [PNContentScrollView contentScrollViewFrame:frame];
    
    [vc.view addSubview:contentScrollView];
    
    // 设置属性
    contentScrollView.contentSize = CGSizeMake(self.arr.count * contentScrollView.width, 0);
    
    
    // 返回
    return contentScrollView;
}


@end
