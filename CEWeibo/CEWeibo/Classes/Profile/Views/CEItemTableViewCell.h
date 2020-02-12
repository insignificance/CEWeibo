//
//  CEItemTableViewCell.h
//  CEWeibo
//
//  Created by insignificance on 2020/2/10.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CECommonItem;

NS_ASSUME_NONNULL_BEGIN

@interface CEItemTableViewCell : UITableViewCell


/**
 *  快速创建cell方法
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  当前cell对应的数据模型
 */
@property(nonatomic,strong)CECommonItem *item;

/**
 *  设置当前cell对应的行数
 *
 *  @param index 对应的行数
 *  @param total cell所在组总共的行数
 */
- (void)setcurrentIndex:(NSInteger)index totalCount:(NSInteger)total;


@end

NS_ASSUME_NONNULL_END
