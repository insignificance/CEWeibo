//
//  CEItemTableViewCell.m
//  CEWeibo
//
//  Created by insignificance on 2020/2/10.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEItemTableViewCell.h"
#import "CECommonItem.h"
#import "CEArrowCommonItem.h"
#import "CELabelCommonItem.h"
#import "CESwitchCommonItem.h"
#import "CECheckCommonItem.h"


@interface CEItemTableViewCell()

@property(nonatomic,strong)UIImageView *accessoryImageView;
@property(nonatomic,strong)UILabel *accessoryLabel;
@property(nonatomic,strong)UISwitch *accessorySwitch;
@property(nonatomic,strong)UIImageView *accessoryCheckView;

@end


@implementation CEItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"common";
    
    CEItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[CEItemTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
        //backgroundView 的优先级比backgroundColor的高
        cell.backgroundColor = [UIColor clearColor];
        // 设置默认的背景图片
        cell.backgroundView = [[UIImageView alloc] init];
        // 设置选择状态的背景图片
        cell.selectedBackgroundView = [[UIImageView alloc] init];
        
    }
    
    return cell;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 重新调整子控件的位置
    self.detailTextLabel.mj_x = CGRectGetMaxX(self.textLabel.frame) + 10;
}

- (void)setItem:(CECommonItem *)item
{
    _item = item;
    
    // 1.设置子控件需要展示的内容
    // CUICatalog: Invalid asset name supplied: (null) 代表图片是nil
    if (_item.icon != nil) {
        self.imageView.image = [UIImage imageNamed:_item.icon];
    }
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subTitle;
    
    // 2.设置右边的辅助视图
    [self setupRightView];
}

- (void)setupRightView
{
//    DDActionLog;
    /*
     1.重用
     2.性能问题
     */
    if ([self.item isKindOfClass:[CEArrowCommonItem class]]) {
        // 显示尖尖
        UIImageView *iv = self.accessoryImageView;
        self.accessoryView = iv;
        
    }else if ([self.item isKindOfClass:[CELabelCommonItem class]])
    {
        // 1.拿到对应的模型
        CELabelCommonItem *item = (CELabelCommonItem *)self.item;
        // 2.创建label
        UILabel *label = self.accessoryLabel;
        // 3.设置数据
        label.text = item.text;
        // 4.设置frame
        label.mj_size = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
        self.accessoryView = label;
        
    }else if([self.item isKindOfClass:[CESwitchCommonItem class]])
    {
        // 1.拿到对应的模型
        CESwitchCommonItem *item = (CESwitchCommonItem *)self.item;
         // 2.创建Switch
        UISwitch *accSwitch = self.accessorySwitch;
        // 3.设置数据
        accSwitch.on = item.isOpen;
        self.accessoryView = accSwitch;
    }else if ([self.item isKindOfClass:[CECheckCommonItem class]])
    {
        CECheckCommonItem *item = (CECheckCommonItem *)self.item;
        if (item.check) {

            UIImageView *iv = self.accessoryCheckView;
            self.accessoryView = iv;
        }else
        {
            // 注意:重用问题
            self.accessoryView = nil;
        }
    }
    else
    {
        self.accessoryView = nil;
    }
}

- (void)setcurrentIndex:(NSInteger)index totalCount:(NSInteger)totalCount
{
    // 0 .取出cell的背景视图
    UIImageView *bgIv = (UIImageView *)self.backgroundView;
    UIImageView *selBgIv = (UIImageView *)self.selectedBackgroundView;
    
    
    // 1.判断当前cell所在的组一共有多少行
    if (totalCount == 1) {
        // 当前组只有一行, 需要设置单独的背景图片
        bgIv.image = [UIImage imageNamed:@"common_card_bottom_background"];
        selBgIv.image = [UIImage imageNamed:@"common_card_bottom_background_highlighted"];
    }else if (index == 0)
    {
        // 是当前组第一行, 需要设置顶部图片
        bgIv.image = [UIImage imageNamed:@"common_card_top_background"];
        selBgIv.image = [UIImage imageNamed:@"common_card_top_background_highlighted"];
    }else if (index == (totalCount - 1))
    {
        // 是当前组最后一行, 需要设置底部图片
        bgIv.image = [UIImage imageNamed:@"common_card_bottom_background"];
        selBgIv.image = [UIImage imageNamed:@"common_card_bottom_background_highlighted"];
    }else
    {
        // 是当前组中间行, 需要设置中间图片
        bgIv.image = [UIImage imageNamed:@"common_card_middle_background"];
        selBgIv.image = [UIImage imageNamed:@"common_card_middle_background_highlighted"];
    }
}

#pragma mark - 懒加载
- (UIImageView *)accessoryImageView
{
    if (!_accessoryImageView) {
        _accessoryImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _accessoryImageView;
}

- (UILabel *)accessoryLabel
{
    if (!_accessoryLabel) {
        _accessoryLabel = [[UILabel alloc] init];;
    }
    return _accessoryLabel;
}

- (UISwitch *)accessorySwitch
{
    if (!_accessorySwitch) {
        _accessorySwitch =  [[UISwitch alloc] init];
    }
    return _accessorySwitch;
}
- (UIImageView *)accessoryCheckView
{
    if (!_accessoryCheckView) {
        _accessoryCheckView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];

    }
    return _accessoryCheckView;
}



@end
