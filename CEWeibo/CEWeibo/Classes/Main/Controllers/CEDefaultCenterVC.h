//
//  CEDefaultCenterVC.h
//  CEWeibo
//
//  Created by insignificance on 2020/1/6.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class CEDefaultCenterView,CEGroupCommon,CECheckGroupCommon;

@interface CEDefaultCenterVC : UITableViewController

//默认的中间视图

@property (weak,nonatomic) CEDefaultCenterView *defaultView;


/**
 *   添加每组需要显示的数据
 */
- (void)addGroup:(CEGroupCommon *)group;

/**
 *   添加每组需要显示的数据
 */
- (CEGroupCommon *)addGroup;

- (CEGroupCommon *)addCheckGroup;
/**
 *   根据传入组的索引返回对应的组
 */
- (CECheckGroupCommon *)groupWithSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
