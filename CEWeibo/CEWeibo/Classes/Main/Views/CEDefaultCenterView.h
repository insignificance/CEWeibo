//
//  CEDefaultCenterView.h
//  CEWeibo
//
//  Created by insignificance on 2020/1/6.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CEDefaultCenterView;

@protocol CEDeflaultCenterViewDelegate <NSObject>

- (void)defaultCenterView:(CEDefaultCenterView*)defaultView didClickSignUpBtn:(UIButton *)signInBtn;
- (void)defaultCenterView:(CEDefaultCenterView*)defaultView didClickLogInBtn:(UIButton *)logInBtn;


@end


@interface CEDefaultCenterView : UIView


#pragma mark -
#pragma mark -- 快速创建方法

+ (instancetype)defaultCenterView;

//外界传来的背景图片名称
@property (nonatomic,copy) NSString *backgroundimgName;

//外界传来的内部图片名称
@property (nonatomic,copy) NSString *descriptionIconName;

//外界传来的描述文本信息
@property (nonatomic,copy) NSString *info;

//代理属性

@property (nonatomic,weak) id<CEDeflaultCenterViewDelegate>delegate;


#pragma mark -
#pragma mark -- 控制背景图片旋转

- (void)startRotate;

- (void)stopRotate;




@end

NS_ASSUME_NONNULL_END
