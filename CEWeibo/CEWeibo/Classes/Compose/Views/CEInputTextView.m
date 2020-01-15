//
//  CEInputTextView.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/15.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEInputTextView.h"

@interface CEInputTextView ()

@property (nonatomic,weak)UILabel *placeholderLabel;

@end


@implementation CEInputTextView





/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */



- (instancetype)initWithFrame:(CGRect)frame{
    
    
    if (self = [super initWithFrame:frame]) {
        
        
        
        [self setUpPlceholderLabel];
        
        //注册通知
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewDidChange) name:UITextViewTextDidChangeNotification object:nil];
        

        
    }
    
    
    
    return self;
    
}



#pragma mark -
#pragma mark -- 设置placeholderlabel


- (void)setUpPlceholderLabel{
    
    
    //1.创建用于显示提醒文本的label
    
    UILabel *placeholderLabel = [[UILabel alloc]init];
    
    //placeholderLabel.text = @"请输入需要分享的内容.....";
    
    //设置大小
    [placeholderLabel sizeToFit];
    
    
    //设置位置
    placeholderLabel.mj_x = 5;
    
    placeholderLabel.mj_y = 8;
    
    
    //设置字体大小
    
    self.font = [UIFont systemFontOfSize:15];
    
    
    //自动换行
    
    placeholderLabel.numberOfLines = 0;
    
    // placeholderLabel.font = self.font;
    
    self.placeholderLabel = placeholderLabel;
    
    
    
    
    //placeholderLabel.backgroundColor = [UIColor blueColor];
    
    //添加
    [self addSubview:placeholderLabel];
    
    
}




#pragma mark -
#pragma mark -- 设置提醒文字

- (void)setPlaceholder:(NSString *)placeholder{
    
    
    _placeholder = placeholder;
    
    
    self.placeholderLabel.text = placeholder;
    
    //重新调整label大小
    [self.placeholderLabel sizeToFit];
    
    
    
}



- (void)setFont:(UIFont *)font{
    
    
    [super setFont:font];
    
    
    self.placeholderLabel.font = font;
    
    [self.placeholderLabel sizeToFit];
    
    
    
}





#pragma mark -
#pragma mark -- notification


- (void)textViewDidChange{
    
    
    self.placeholderLabel.hidden = (self.text.length >0);

    
    
    
}




- (void)dealloc{
    
    
    //移除通知
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    
    
    
}


@end
