//
//  CETitleView.h
//  CEWeibo
//
//  Created by insignificance on 2020/1/4.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CETitleView : UIView

@property (nonatomic,weak)UIButton *button;
@property (nonatomic,weak)UIImageView *imageView;
@property (nonatomic,assign,getter=isClik)BOOL click;

- (instancetype)initWithBtn:(UIButton *)btn andImageView:(UIImageView *)imgView;


@end

NS_ASSUME_NONNULL_END
