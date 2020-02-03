//
//  CEItem.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/10.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "CEItem.h"

#define badgeBtnY 1.0
#define badgeBtnX 41.0

@interface CEItem ()
/*提醒小红点*/
@property (nonatomic,weak)UIButton *badgeBtn;

@end



@implementation CEItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


/*
 
 重写 图片 文字 相关绘图方法

 */


- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    
    CGFloat imgX = 0;
    CGFloat imgY = 0;
    CGFloat imgW = contentRect.size.width;
    CGFloat imgH = contentRect.size.height*0.6;
    
    CGRect imageRect = CGRectMake(imgX, imgY, imgW, imgH);
    
    return imageRect;
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    
    CGFloat titleX = 0;
    CGFloat titleY = CGRectGetMaxY(self.imageView.frame);
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height *0.4;
    
    CGRect titleRect = CGRectMake(titleX, titleY, titleW, titleH);
    
    return titleRect;
    
}

- (void)layoutSubviews{
    
   
       [super layoutSubviews];
       
       //DDLogDebug(@"=====%@======",self.badgeBtn);
       
       //注意取图片也要分状态取
       self.badgeBtn.mj_size = self.badgeBtn.currentBackgroundImage.size;
          
       //DDLogDebug(@"self.badgeBtn.mj_size = %@",NSStringFromCGSize(self.badgeBtn.mj_size));
             
       //self.badgeBtn.mj_x = self.mj_w - self.badgeBtn.mj_w;
             
       //self.badgeBtn.mj_y = 0;
       
        self.badgeBtn.mj_x = badgeBtnX;
    
        self.badgeBtn.mj_y = badgeBtnY;
    
       
    
        //DDLogDebug(@"self.badgeBtn.mj_x = %lf" ,self.badgeBtn.mj_x);
        
    

    
}

- (instancetype)init{
    
    if(self = [super init]){
        
        //设置内置图片 文字相关属性
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        //设置字体颜色也需要分状态
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        
        
        
        //添加提醒按钮
        
        UIButton *badgeBtn = [[UIButton alloc]init];
        UIImage *badgeImage = [UIImage imageNamed:@"main_badge"];
        
       // badgeBtn.titleLabel.font = [UIFont systemFontOfSize:8];
        
        //设置提醒小红点
        [badgeBtn setBackgroundImage:badgeImage forState:UIControlStateNormal];
        //设置小红点文字大小
        
        UIFont *font = [UIFont systemFontOfSize:10];
        
        [badgeBtn.titleLabel setFont:font];
        
        self.badgeBtn = badgeBtn;
        
        //默认小红点隐藏
        self.badgeBtn.hidden = YES;
        
        
        [self addSubview:badgeBtn];
        
        
        
        
        
    }
    
    
    
    return self;
}




#pragma mark -
#pragma mark -- 设置数据

- (void)setItem:(UITabBarItem *)item{
    
    
    _item = item;
    
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateHighlighted];
    
    
    //利用kvo 监听UITabBarItem 属性的改变
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    
    
    
    
}




#pragma mark -
#pragma mark -- 移除kvo

- (void)dealloc{
    
    
    [_item removeObserver:self forKeyPath:@"badgeValue"];
    
}



///监听到某个被监听的对象的指定属性改变时调用
/// @param keyPath 被监听的属性
/// @param object 被监听的对象
/// @param change 改变的值
/// @param context 监听时传入的参数
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    DDLogDebug(@"change = %@",change);
    
    
    NSNumber *number = change[@"new"];
    
    DDLogDebug(@"number = %@",number);
    
    
    if (number.intValue > 0) {
        
        self.badgeBtn.hidden = NO;
        

        if (number.intValue > 99) {
            
            
            [self.badgeBtn.titleLabel setFont:[UIFont systemFontOfSize:8]];
            [self.badgeBtn setTitle:@"99+" forState:UIControlStateNormal];
            
        }else{
            
             [self.badgeBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
             [self.badgeBtn setTitle:[number description] forState:UIControlStateNormal];
             
            
        }
        
        
    }else{
        //若number = 0
        
        self.badgeBtn.hidden = YES;
        
        
        
    }
    
    
    
}



@end
