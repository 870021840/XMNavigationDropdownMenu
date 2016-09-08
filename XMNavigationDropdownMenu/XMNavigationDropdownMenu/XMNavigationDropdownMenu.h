//
//  XMNavigationDropdownMenu.h
//  XMNavigationDropdownMenu
//
//  Created by 谢满 on 16/8/31.
//  Copyright © 2016年 DGUT. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XMNavigationDropdownMenu : UIView

@property(nonatomic,assign) CGFloat  cellHeight;

/** 设置cell背景颜色 */
@property (nonatomic, strong) UIColor *cellBackgroundColor;

/** 设置cell分割线颜色 */
@property (nonatomic, strong) UIColor *cellSeparatorColor;

/** 设置cell里面文本颜色 */
@property (nonatomic, strong) UIColor *cellTextLabelColor;

/** 设置cell选中背景颜色 */
@property (nonatomic, strong) UIColor *cellSelectionColor;

/** 是否保持选中状态 */
@property(nonatomic,assign) BOOL  shouldKeepSelectedCellColor;

/** 设置cell文本的字体大小 */
@property (nonatomic, strong) UIFont *cellTextLabelFont;

/** 设置cell中文本的对齐方式 */
@property (nonatomic, assign) NSTextAlignment cellTextLabelAlignment;

/** 箭头距离title的padding */
@property(nonatomic,assign) CGFloat  arrowPadding;

/** 动画时间大小 */
@property(nonatomic,assign) CGFloat  animationDuration;

/** 遮盖背景颜色 */
@property (nonatomic, strong) UIColor *maskBackgroundColor;

/** 遮盖的透明度 */
@property (nonatomic, assign) CGFloat maskBackgroundOpacity;

/** nav标题文本颜色 */
@property (nonatomic, strong) UIColor *menuTitleColor;

/** nav箭头颜色 */
@property (nonatomic, strong) UIColor *arrowTintColor;

/** 选中后是否自动更新到nav的标题栏，默认YES */
@property(nonatomic,assign) BOOL  shouldChangeTitleText;
/** cell选中标识图片，默认打勾 */
@property (nonatomic, strong) UIImage *checkMarkImage;

/**
 *  初始化方法
 *
 *  @param controller    导航控制器
 *  @param containerView 显示下拉table的view
 *  @param title         标题
 *  @param items         table子项
 *
 *  @return XMNavigationDropdownMenu
 */
-(instancetype)initWithNavigationController:(UINavigationController *)controller containerView:(UIView *)containerView title:(NSString *)title items:(NSArray<NSString *> *)items;

/** 选中index项回调 */
@property (nonatomic, strong) void(^didSelectItemAtIndexHandler)(NSUInteger index) ;

/**
 *  更新items
 */
-(void)updateItems:(NSArray<NSString *> *)items;

@end
