//
//  UIImage+Extension.h
//  CEWeibo
//
//  Created by insignificance on 2020/1/11.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

/**
 *  生成一张圆形图片
 *
 *  @param name        需要生成的图片名称
 *  @param borderWidth 生成的圆形图片的边框
 *  @param borderColor 边框的颜色
 *
 *  @return 圆形图片
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  将当前图片变成圆形图片
 *
 *  @param borderWidth 生成的圆形图片的边框
 *  @param borderColor 边框的颜色
 *
 *  @return 圆形图片
 */
- (instancetype)circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;




@end

NS_ASSUME_NONNULL_END
