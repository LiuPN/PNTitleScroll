//
//  ViewController.m
//  PNTitleScrollDemo
//
//  Created by lpn on 16/4/8.
//  Copyright © 2016年 lpn. All rights reserved.
//

#import "ViewController.h"
#import "PNHomeTableViewController.h"

#import "PNTitleScrollTools.h"
#import "PNTitleLabel.h"

@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic, strong) NSArray *arr;
@property(nonatomic, weak) PNTitleScrollView *titleView;
@property(nonatomic, weak) PNContentScrollView *contentScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1 定义数组
    NSArray *arr = @[@"头条",@"娱乐",@"热点",@"体育",@"财经",@"科技",@"汽车",@"时尚"];
    self.arr = arr;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 2 传递数组
    PNTitleScrollTools *tools = [PNTitleScrollTools tools];
    [tools titleScrollToolsArr:arr];
    
    // 3 头部
    [self setupTitleLablesWithTools:tools];
    // 4 内容
    [self setupcontentViewWithTools:tools];
    
    // 5  默认设置   首先选择第一个
    [self defaultSetting];
    
    
}
- (void)defaultSetting
{
    // 点击标题事件 空数组  0越界  first不会报错
    PNHomeTableViewController *homeVc = [self.childViewControllers firstObject];
    
    UIView *firstView = homeVc.view;
    firstView.frame = self.view.bounds;
    // 第一页传递数据访问后台数据
    homeVc.selectedIndex = 0;
    
    [self.contentScrollView addSubview:firstView];
    
    // 第一个label字体的变换
    PNTitleLabel *lbl = self.titleView.subviews[0];
    lbl.scale = 1.0;
    
    // 包括 “下划线” 以及 “点击事件”操作
    self.titleView.selectIndex = 0;
    
}
/**
 头部的设置
 */
- (void)setupTitleLablesWithTools:(PNTitleScrollTools *)tools
{
    // 1 初始化头部 cellNum当前显示在眼前的个数
    PNTitleScrollView *titleView = [tools titleScrollToolsSetupTitleViewWithVc:self WithFrame:CGRectMake(0, 64, PNScreenWidth, 38.0) maxFontValue:17.0 cellNum:4];
    self.titleView = titleView;
    
#pragma mark - title的点击事件block
    // 2 点击事件block  注明：点击就刷新
    [self.titleView titleScrollViewClickTitleLabelDo:^(int index) {
        
        CGFloat homeViewX = index * self.contentScrollView.width;
        // contentScroll随着titleView移动
        [self.contentScrollView setContentOffset:CGPointMake(homeViewX, self.contentScrollView.contentOffset.y) animated:YES];
    }];
}


/**
 内容的设置
 */
- (void)setupcontentViewWithTools:(PNTitleScrollTools *)tools
{
    
    // 1 初始化内容view 20 + 44 + titleHeight
    PNContentScrollView *contentVc = [tools titleScrollToolsSetupContentViewWithVc:self frame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), PNScreenWidth, PNScreenHeight - 99)];
    self.contentScrollView = contentVc;
    // 2 设置代理
    contentVc.delegate = self;
    
    // 3 添加子控制器
    for (int i = 0; i<self.arr.count; i++) {
        PNHomeTableViewController *homeVc = [[PNHomeTableViewController alloc] init];
        homeVc.title = self.arr[i];
        [self addChildViewController:homeVc];
        
    }
}

#pragma UIScrollViewDelegate  又添加一次

/**
 *  只要滚动就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    字体的变化0.8~1  与 文字颜色的变化灰色102 102 102->红 214 27 27
    CGFloat scale = scrollView.contentOffset.x / scrollView.width;
    int index = scale;
    
    if (index == (self.arr.count - 1)) return;
    // 求出label
    PNTitleLabel *leftLbl = self.titleView.subviews[index];
    PNTitleLabel *rightLbl = self.titleView.subviews[index + 1];
    
    // 右  左比例
    CGFloat rightScale = scale - index; // 小~大 正常情况下
    CGFloat leftScale = 1 - rightScale;
    
    // 文字与颜色的变化
    leftLbl.scale = leftScale;
    rightLbl.scale = rightScale;
    
    
    
    
    
    
    
    
    
}
/**
 *  代码滚动contentView减速完成调用
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
}

/**
 *     手动滚动contentView减速完成调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // label索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 顶部title滚动
    UILabel *lbl = self.titleView.subviews[index];
    CGFloat titleViewOffsetX = lbl.center.x - self.titleView.width * 0.5;
    // 最左边  与  最右边
    CGFloat maxTitleViewOffsetX = self.titleView.contentSize.width - self.titleView.width;
    if (titleViewOffsetX < 0) {
        titleViewOffsetX = 0;
    }else if(titleViewOffsetX > maxTitleViewOffsetX)
    {
        titleViewOffsetX = maxTitleViewOffsetX;
    }
    
    [self.titleView setContentOffset:CGPointMake(titleViewOffsetX, self.titleView.contentOffset.y) animated:YES];
    
    // titleLabel下划线的移动
    [self.titleView titleViewLabelUnderLineWithIndex:index];
    
    // content添加view
    PNHomeTableViewController *homeVc = self.childViewControllers[index];
    // 传递数据
    homeVc.selectedIndex = index;
    
    // 已经添加进去了就不用再次添加
    if (homeVc.view.superview) return;
    
    CGFloat homeViewY = 0;
    CGFloat homeViewW = self.contentScrollView.width;
    CGFloat homeViewH = self.contentScrollView.height;
    CGFloat homeViewX = index * homeViewW;
    homeVc.view.frame = CGRectMake(homeViewX, homeViewY, homeViewW, homeViewH);
    [self.contentScrollView addSubview:homeVc.view];
}

@end
