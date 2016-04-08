//
//  PNTitleScrollView.m
//  网易头部视图
//
//  Created by lpn on 16/3/29.
//  Copyright © 2016年 lpn. All rights reserved.
//#define titleCellWidth [UIScreen mainScreen].bounds.size.width/4

#import "PNTitleScrollView.h"
#import "UIView+HMExtension.h"
#import "PNTitleLabel.h"

@interface PNTitleScrollView ()
// 字体的纯宽度
@property(nonatomic, assign) CGFloat fontWidth;

/// 上一次选中的title
@property(nonatomic, weak) PNTitleLabel *preSelectedLbl;


/// 下划线
@property(nonatomic, weak) UILabel *line;

/// cell的宽度
@property(nonatomic, assign) CGFloat cellWidth;


@end


@implementation PNTitleScrollView


#pragma mark - 系统实例方法
/**
  实例方法
 */
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.partCellNum = 4;
        
        //  初始化  设置背景 228 228 228
        self.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
       
    }
    return self;


}

/**
  类方法
 */
+ (instancetype)titleScrollViewWithFrame:(CGRect)frame maxFontValue:(CGFloat)maxValue cellNum:(int)cellNum
{
    PNTitleScrollView *sv = [[self alloc] initWithFrame:frame];
    
  // 字体设置  以防万一用户没设置字体
    sv.maxFontSize = [UIFont systemFontOfSize:maxValue];
    
    if (maxValue < 1) {
        sv.maxFontSize = PNDEFAULT_TITLE_MAXFONT;
    }
    if (cellNum < 1) {
        cellNum = 4;
    }
    
    sv.partCellNum = cellNum;

    return sv;
}




#pragma mark - 接收数据显示控件

- (void)setPartCellNum:(int)partCellNum
{
    _partCellNum = partCellNum;
    
    self.cellWidth = [UIScreen mainScreen].bounds.size.width/partCellNum;
    
}
/**
  利用代码选择的索引
 */
- (void)setSelectIndex:(NSInteger)selectIndex
{
    // 1 titlelabel以及下划线实现
    [self titleViewLabelUnderLineWithIndex:selectIndex];
    
    // content内容显示滚动
    if (self.myClickBlock) {
        self.myClickBlock((int)selectIndex);
    }
    
}

/// 点击titleLabel block方法  属性与方法都要定义  方法中block可以先赋值好，再在需要调用的地方调用属性
- (void)titleScrollViewClickTitleLabelDo:(myClickBlock)clickBlock
{
    self.myClickBlock = clickBlock;
}


/**
   接收数组
 */
- (void)setTitleArr:(NSArray *)titleArr{

    _titleArr = titleArr;
    
  
    int count = (int)titleArr.count;
    for (int i = 0; i<count; i++) {
       
        // 创建label
        PNTitleLabel *titleLbl = [[PNTitleLabel alloc] init];
        titleLbl.width = self.cellWidth;
        titleLbl.height = self.height;
        titleLbl.x = i * (titleLbl.width + PNMargin);
        titleLbl.y = 0;
        titleLbl.tag = i;
        
        // 随机色
//        titleLbl.backgroundColor = CWColor(arc4random_uniform(255.0), arc4random_uniform(255.0), arc4random_uniform(255.0));
     // 字体设置  可能为默认  也可能为用户设置的最大字体，知道了最大字体就可以搞到下划线的宽度
        titleLbl.font = self.maxFontSize;
        
        // 显示标题内容
        titleLbl.text = self.titleArr[i];
        
        [self addSubview:titleLbl];
        
        // 注册点击手势事件  tap点击
        [titleLbl addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLabel:)]];
     
        
    }
    
    self.contentSize = CGSizeMake(count * (self.cellWidth+PNMargin)- PNMargin, 0);
    self.showsHorizontalScrollIndicator = NO;
    

}


#pragma mark - titleLabel的手势点击事件
- (void)clickLabel:(UITapGestureRecognizer *)tap{
    
    /// 重复点击失效-- 只有在这里才会有重复点击titleLbl的可能性
    if (self.preSelectedLbl.tag == tap.view.tag) return;
    
    // 1 titleLbl下划线的移动
    [self titleViewLabelUnderLineWithIndex:tap.view.tag];
    
    
    
    // content内容显示
    if (self.myClickBlock) {
        self.myClickBlock((int)tap.view.tag);
    }
    
   

}





/**
 *  label下划线的移动
 */
- (void)titleViewLabelUnderLineWithIndex:(NSInteger)index
{
    
    if(self.preSelectedLbl)
    {
        self.preSelectedIndex = self.preSelectedLbl.tag;
       
    }
    
    PNTitleLabel *lbl = self.subviews[index];
    
    
     // 2 下划线的添加与移动
    NSMutableDictionary *dictF = [NSMutableDictionary dictionary];
    dictF[NSFontAttributeName] = self.maxFontSize;
    // 求出字的宽度  线宽度就是字的宽度
    CGSize fontSize = [lbl.text sizeWithAttributes:dictF];
    CGFloat LineWidth = fontSize.width;
    
    
    // 2.1 线的添加
    if (!self.line) {
        // 线不存在时候：selIndex == 0 程序刚运行的时候
        UILabel *line = [[UILabel alloc] init];
        line.width = LineWidth;
        line.height = 2.0;
        line.y = self.height - line.height;
        
        line.centerX = lbl.centerX;
        
        self.line = line;

        // 214 g27 b27 CWColor(214, 27, 27)
        line.backgroundColor = [UIColor colorWithRed:214/255.0 green:27/255.0 blue:27/255.0 alpha:1.0];
        [self addSubview:line];
    }else
    {
        
         // 2.2 线的移动（动画）
        [UIView animateWithDuration:PNTitleChangeTime animations:^{
            
            self.line.width = LineWidth;
            
            self.line.centerX = lbl.centerX;
        }];
    }
    
    // 赋值
    self.preSelectedLbl = lbl;
    
}
@end
