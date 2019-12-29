//
//  CEItem.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/10.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "CEItem.h"

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



- (instancetype)init{
    
    if(self = [super init]){
        
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        //设置字体也需要分状态
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        
    }
    
    
    
    return self;
}





@end
