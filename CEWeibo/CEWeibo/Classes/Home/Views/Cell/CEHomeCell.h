//
//  CEHomeCell.h
//  CEWeibo
//
//  Created by insignificance on 2020/1/21.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CEHomeCell;
@class CEStatues;
NS_ASSUME_NONNULL_BEGIN

@protocol CEHomeCellDelegate <NSObject>

- (void)homeCellRefresh:(CEHomeCell *)cell;

@end

@interface CEHomeCell : UITableViewCell

/*delegate*/
@property (nonatomic,weak) id<CEHomeCellDelegate> delegate;

/*数据模型*/
@property (nonatomic,strong)CEStatues *statues;

/*获取指定数据对应cell的高度*/
- (CGFloat)cellHeightWithStatus:(CEStatues *)statues;

@end

NS_ASSUME_NONNULL_END
