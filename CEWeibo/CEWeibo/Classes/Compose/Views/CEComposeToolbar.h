//
//  CEComposeToolbar.h
//  CEWeibo
//
//  Created by insignificance on 2020/1/17.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CEComposeToolbar;
NS_ASSUME_NONNULL_BEGIN


typedef enum{
    
    CEComposeToolbarButtonTypeCamera,// 拍照 0
    CEComposeToolbarButtonTypeMention,// @
    CEComposeToolbarButtonTypeTrend, // #
    CEComposeToolbarButtonTypeEmotion,// 表情
    CEComposeToolbarButtonTypeAdd // 添加
    
} CEComposeToolbarButtonType;

@protocol CEComposeToolbarDelegate <NSObject>

- (void)composeToolbar:(CEComposeToolbar *)toolbar
       didClickBtnType:(CEComposeToolbarButtonType)type;

@end

@interface CEComposeToolbar : UIView



@property (nonatomic,weak) id <CEComposeToolbarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
