//
//  CETitleView.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/4.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CETitleView.h"
#import "UIView+Frame.h"

#define magrin 8
#define titleViewHeight 40

@interface CETitleView ()

@end


@implementation CETitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithFrame:(CGRect)frame{
    
   
    
    if ([super initWithFrame:frame]) {
        
//        @throw [NSException exceptionWithName:@"Singleton" reason:@"Use - [CETitleView initWithBtn:andImageView:]" userInfo:nil];
//           return nil;
        
    }
    
    return self;
    
}


- (instancetype)initWithBtn:(UIButton *)btn andImageView:(UIImageView *)imgView{
    
    if (self = [super init]) {
        
        self.button = btn;
        self.imageView = imgView;
        
        //根据btn 及imageview 设置 self 的宽度
        self.width = btn.width + imgView.width + 2*magrin;
        
        self.height = titleViewHeight;
        
        //将控件加入self
        [self addSubview:_button];
        [self addSubview:_imageView];
        
        _button.x = magrin;
        _imageView.x = CGRectGetMaxX(_button.frame)+0.5*magrin;
        
        _imageView.y = self.center.y - imgView.height;
     
        
    }
    
 return self;
    
}



@end
