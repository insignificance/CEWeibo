//
//  CERefreshGifHeader.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/16.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CERefreshGifHeader.h"

@implementation CERefreshGifHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)init{
    
    
    if (self = [super init]) {
        
        
        
        if (@available(iOS 11.0,*)) {
            
            self.ignoredScrollViewContentInsetTop = 60.5;
            
            
        }
        
        
        
    }
    
    
    return self;
    
}



- (instancetype)initWithFrame:(CGRect)frame{
    
    
    
    if (self = [super initWithFrame:frame]) {
        
        
        if (@available(iOS 11.0,*)) {
                 
                 self.ignoredScrollViewContentInsetTop = 60.5;
                 
                 
             }
             
      
        
        
        
    }
    
    
    return self;
    
    
    
    
    
}



@end
