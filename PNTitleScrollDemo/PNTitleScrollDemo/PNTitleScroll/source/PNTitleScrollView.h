//
//  PNTitleScrollView.h
//  网易头部视图
//
//  Created by lpn on 16/3/29.
//  Copyright © 2016年 lpn. All rights reserved.
//

/// int preIndex,int index判断是否重复点击
typedef void(^myClickBlock)(int index);

#import <UIKit/UIKit.h>

@interface PNTitleScrollView : UIScrollView

/// 标题数组
@property(nonatomic, strong) NSArray *titleArr;
/// label被点击之后  变大的字体
@property(nonatomic, strong) UIFont *maxFontSize;
/// 代码选择的索引
@property(nonatomic, assign) NSInteger selectIndex;
/// 上一个选择的索引
@property(nonatomic, assign) NSInteger preSelectedIndex;


// 页面的标题显示几个
@property(nonatomic, assign) int partCellNum;

/// 点击后的事件block
@property(nonatomic, copy) myClickBlock myClickBlock;


/// 试图写点击事件的block方法
- (void)titleScrollViewClickTitleLabelDo:(myClickBlock)clickBlock;


/**
   frame: CGRect titleView frame 相对于 当前控制器view
maxValue: maxValue  titleView上的label的字体被点击时的最大值大小  即时最大值
 cellNum: int 在当前控制器view中，titleView里显示的能看到的label个数
 */
+ (instancetype)titleScrollViewWithFrame:(CGRect)frame maxFontValue:(CGFloat)maxValue cellNum:(int)cellNum;


///  titleLable变色的方法
- (void)titleViewLabelUnderLineWithIndex:(NSInteger)index;
@end
