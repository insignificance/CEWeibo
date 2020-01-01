//
//  CETabBar2.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/10.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "CETabBar2.h"
#import "CEItem.h"
#import "Masonry.h"


//定义addBtnTag值
#define addBtnTag 99
@interface CETabBar2 ()
/*
 
 TabBar 中的加号按钮
 
 */
@property (nonatomic,weak) UIButton *addButton;

/*
 
 用于保存上一次选中选项卡的状态
 
 
 */
@property (nonatomic,weak) CEItem *lastItem;
@end

@implementation CETabBar2





/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        //设置背景色
        self.backgroundColor = [UIColor whiteColor];
        
        //设置加号按钮
        
        [self setUpAddBtn];
        
        
        
    }
    
    
    return self;
}




#pragma mark -
#pragma mark -- 添加item

- (void)addItemFromBarItem:(UITabBarItem *)item{
    
    
    //1. 创建选项卡按钮
    
    //UIButton *button = [[UIButton alloc]init];
    
    CEItem *button = [[CEItem alloc]init];
    
    
    //2. 为按钮添加属性
    [button setTitle:item.title forState:UIControlStateNormal];
    [button setImage:item.image forState:UIControlStateNormal];
    [button setImage:item.selectedImage forState:UIControlStateHighlighted];
    
    //3. 将按钮添加到 视图中
    
    [self addSubview:button];
    
    //DDLogDebug(@"%s",__func__);
    
    //4. 为按钮添加触摸事件
    
    [button addTarget:self action:@selector(didClickItem:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
}




#pragma mark -
#pragma mark -- 设置addButton

- (void)setUpAddBtn{
    
    
    
    UIButton *addButton = [[UIButton alloc]init];
    self.addButton = addButton;
    
    self.addButton.tag = addBtnTag;
    
    
    
    [self addSubview:addButton];
    
    [self.addButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"]forState:UIControlStateNormal];
    
    
    [self.addButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    
    
    
    [self.addButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    
    
    [self.addButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    
    
    
    
}








#pragma mark -
#pragma mark -- 选项卡触摸事件


- (void)didClickItem:(CEItem*)item{
    
    
    
    //取消上一次选中选项卡的高亮状态
    
    self.lastItem.highlighted = NO;
    
    
    DDLogDebug(@"Item.tag = %zi",item.tag);
     
    
    //[ProgressHUD showSuccess:@"123" Interaction:YES];
    
    
    //1. 点击按钮的时候 按钮变为高亮状态
    
    [NSOperationQueue.mainQueue addOperationWithBlock:^{
        
        item.highlighted = YES;
        self.lastItem = item;
        
    }];
    
    
    //通知代理对象调用代理方法
    
    if ([self.delegate respondsToSelector:@selector(CETabBar2:withCEItem:from:to:)]) {
        
        [self.delegate CETabBar2:self withCEItem:item from:self.lastItem.tag to:item.tag];
        
    }
    
    
    //为选项卡添加动画效果
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        item.transform = CGAffineTransformMakeScale(0.6, 0.6);
        
        
    } completion:^(BOOL finished) {
        
        
        
        [UIView animateWithDuration:0.2 animations:^{
            
            item.transform = CGAffineTransformMakeScale(1.2, 1.2);
            
            
        } completion:^(BOOL finished) {
            
            
            item.transform = CGAffineTransformIdentity;
            
        }];
        
        
        
        
    }];
    
    
    
    
    
    
    
    
}



#pragma mark -
#pragma mark -- 为选项卡设置Frame


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    //tabBar 选项卡控件 布局索引
    NSUInteger index = 0;
    
    //tabBar 选项卡 tag值索引
    NSUInteger number = 0;
    
    //重新计算子控件中 tabBar 的frame
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat W = self.frame.size.width / 5.0;
    CGFloat H = self.frame.size.height;
    
    for (UIView *subView in self.subviews) {
        
        
        // DDLogDebug(@"%@",subView);
        
        
        if ([subView isKindOfClass:NSClassFromString(@"UIButton")]  && subView.tag != addBtnTag) {
            
            //给选项卡添加标记
            subView.tag = number;
            
            if (subView.tag == 0) {
                
                //[self didClickItem:(CEItem *)subView];
                
                CEItem *item = (CEItem *)subView;
                
                //默认第一个选项卡 高亮状态 仅执行一次
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{
                    
                    item.highlighted = YES;
                    self.lastItem = item;
                });
                
                DDLogDebug(@"%s",__func__);
                
            }
            
            number ++;
            
            //如果取到第三个 则 索引加一
            if (index == 2) {
                
                index ++;
            }
            
            
            
            //动态计算X
            X = index * W;
            //DDLogDebug(@"%d %f",__LINE__,X);
            
            
            subView.frame = CGRectMake(X, Y, W, H);
            
            
            //当取到UITabBarButton 对象时 下标索引加一
            index++;
            
        }
        
        
    }
    
    
    
    
    //    CGRect frame = CGRectZero;
    //
    //    frame.size = self.addButton.currentBackgroundImage.size;
    //
    //    CGFloat  centerX = self.frame.size.width*0.5;
    //    CGFloat centerY = self.frame.size.height*0.5;
    //
    //    self.addButton.frame = frame;
    //
    //    self.addButton.center = CGPointMake(centerX, centerY);
    
    //将加号按钮居中显示
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //自己和自己的东西比不行
        //make.size.equalTo(self.addButton.currentImage);
        make.center.equalTo(self);
        
        
    }];
    
    
    
    
    
    
    
}





@end
