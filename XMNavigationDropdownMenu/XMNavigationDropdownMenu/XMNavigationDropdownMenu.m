//
//  XMNavigationDropdownMenu.m
//  XMNavigationDropdownMenu
//
//  Created by 谢满 on 16/8/31.
//  Copyright © 2016年 DGUT. All rights reserved.
//

#import "XMNavigationDropdownMenu.h"
#pragma mark - 配置XMNavigationDropdownMenu

@interface XMNavigationDropdownMenuConfiguration : NSObject

//var menuTitleColor: UIColor?
/**  */
@property (nonatomic, strong) UIColor *menuTitleColor;
/** cell 高度 */
@property(nonatomic,assign) CGFloat  cellHeight;

/** cell背景颜色 */
@property (nonatomic, strong) UIColor *cellBackgroundColor;

/** cell分割线颜色 */
@property (nonatomic, strong) UIColor *cellSeparatorColor;
/** cell文本颜色 */
@property (nonatomic, strong) UIColor *cellTextLabelColor;
/** 选中cell文本颜色 */
@property (nonatomic, strong) UIColor *selectedCellTextLabelColor;
/** cell文本的字体 */
@property (nonatomic, strong) UIFont *cellTextLabelFont;
/** 导航栏字体大小 */
@property (nonatomic, strong) UIFont *navigationBarTitleFont;
/** cell对齐方式 */
@property (nonatomic, assign) NSTextAlignment  cellTextLabelAlignment;
/** cell选中颜色 */
@property (nonatomic, strong) UIColor *cellSelectionColor;
/** cell选中右侧图标 */
@property (nonatomic, strong) UIImage *checkMarkImage;

@property(nonatomic,assign) BOOL  shouldKeepSelectedCellColor;
//var shouldKeepSelectedCellColor: Bool!
/** 导航栏箭头颜色 */
@property (nonatomic, strong) UIColor *arrowTintColor;
/** 箭头图片 */
@property (nonatomic, strong) UIImage *arrowImage;

/** 箭头Padding */
@property (nonatomic, assign) CGFloat arrowPadding;

/** 动画时间 */
@property(nonatomic,assign) NSTimeInterval  animationDuration;
/** 遮盖颜色 */
@property (nonatomic, strong) UIColor *maskBackgroundColor;
/** 遮盖透明度 */
@property(nonatomic,assign) CGFloat  maskBackgroundOpacity;
/** 自动改变title文本 */
@property(nonatomic,assign) BOOL  shouldChangeTitleText;

@end

@implementation XMNavigationDropdownMenuConfiguration

-(instancetype)init{
    if (self = [super init]) {
        [self setupDefaultValue];
    }
    return self;
}
#pragma mark  设置默认值
-(void)setupDefaultValue{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:@"XMNavigationDropdownMenu" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    NSString *checkMarkImagePath = [imageBundle pathForResource:@"checkmark_icon" ofType:@"png"];
    NSString *arrowImagePath = [imageBundle pathForResource:@"arrow_down_icon" ofType:@"png"];
    //设置默认值
    self.menuTitleColor = [UIColor darkGrayColor];
    self.cellHeight = 50;
    self.cellBackgroundColor = [UIColor whiteColor];
    self.arrowTintColor = [UIColor whiteColor];
    self.cellSeparatorColor = [UIColor darkGrayColor];
    self.cellTextLabelColor = [UIColor darkGrayColor];
    self.selectedCellTextLabelColor = [UIColor darkGrayColor];
    self.cellTextLabelFont = [UIFont systemFontOfSize:17];
    self.navigationBarTitleFont = [UIFont boldSystemFontOfSize:17];
    self.cellTextLabelAlignment = NSTextAlignmentLeft;
    self.cellSelectionColor = [UIColor lightGrayColor];
    self.checkMarkImage = [UIImage imageWithContentsOfFile:checkMarkImagePath];
    self.shouldKeepSelectedCellColor = NO;
    self.animationDuration = 0.5;
    self.arrowImage = [UIImage imageWithContentsOfFile:arrowImagePath];
    self.arrowPadding = 15;
    self.maskBackgroundColor = [UIColor blackColor];
    self.maskBackgroundOpacity = 0.3;
    self.shouldChangeTitleText = true;
}

@end

#pragma mark - XMTableViewCell
@interface XMTableViewCell : UITableViewCell

@property (nonatomic, strong) XMNavigationDropdownMenuConfiguration *configuration;

@property(nonatomic,assign) CGRect  cellContentFrame;

@property (nonatomic, strong) UIImageView *checkmarkIcon;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier configuration:(XMNavigationDropdownMenuConfiguration *)configuration;
@end

@implementation XMTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier configuration:(XMNavigationDropdownMenuConfiguration *)configuration{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.configuration = configuration;
        _cellContentFrame = CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.frame.size.width, self.configuration.cellHeight);
        self.contentView.backgroundColor = self.configuration.cellBackgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.textColor = self.configuration.cellTextLabelColor;
        self.textLabel.font = self.configuration.cellTextLabelFont;
        self.textLabel.textAlignment = self.configuration.cellTextLabelAlignment;
        
        if (self.textLabel.textAlignment == NSTextAlignmentCenter) {
            self.textLabel.frame = CGRectMake(0, 0, _cellContentFrame.size.width, _cellContentFrame.size.height);
            self.checkmarkIcon = [[UIImageView alloc] initWithFrame:CGRectMake(_cellContentFrame.size.width - 50, (_cellContentFrame.size.height - 30) *0.5, 30, 30)];
        } else if (self.textLabel.textAlignment == NSTextAlignmentLeft) {
            self.textLabel.frame = CGRectMake(20, 0, _cellContentFrame.size.width, _cellContentFrame.size.height);
            self.checkmarkIcon = [[UIImageView alloc] initWithFrame:CGRectMake(_cellContentFrame.size.width -50, (_cellContentFrame.size.height - 30 ) *0.5, 30, 30)];

        } else {
            self.textLabel.frame = CGRectMake(-20, 0, _cellContentFrame.size.width, _cellContentFrame.size.height);
               self.checkmarkIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, (_cellContentFrame.size.height - 30 ) *0.5, 30, 30)];
        }
        self.checkmarkIcon.hidden = YES;
        self.checkmarkIcon.image = self.configuration.checkMarkImage;
        self.checkmarkIcon.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.checkmarkIcon];
        
        // Separator for cell
//        let separator = BTTableCellContentView(frame: cellContentFrame)
        UIView *lineSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, _cellContentFrame.size.height - 1, _cellContentFrame.size.width, 1)];;
        lineSeparator.backgroundColor = self.configuration.cellSeparatorColor;
        [self.contentView addSubview:lineSeparator];

    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bounds = _cellContentFrame;
}

@end

#pragma mark - XMTableView
@interface XMTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

/** <#备注#> */
@property (nonatomic, copy) void(^selectRowAtIndexPathHandler)(NSIndexPath *indexPath);
/** 配置信息 */
@property (nonatomic, strong) XMNavigationDropdownMenuConfiguration *configuration;

/** 数据 */
@property (nonatomic, strong) NSArray<NSString *> *items;

/** 选中indexpath */
@property(nonatomic,assign) NSInteger  selectedIndexPath;

-(instancetype)initWithFrame:(CGRect)frame items:(NSArray<NSString *> *)item title:(NSString *)title configuration:(XMNavigationDropdownMenuConfiguration *)configuration;

@end

@implementation XMTableView

-(instancetype)initWithFrame:(CGRect)frame items:(NSArray<NSString *> *)items title:(NSString *)title configuration:(XMNavigationDropdownMenuConfiguration *)configuration{
    if (self = [super initWithFrame:frame style:UITableViewStylePlain]) {
        self.items = items;
        self.selectedIndexPath = [items indexOfObject:title];
        self.configuration = configuration;
        
        // Setup table view
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        self.separatorEffect = UIBlurEffect(style: .Light)
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.tableFooterView = [UIView new];
    }
    return self;
}

#pragma mark tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.configuration.cellHeight;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.configuration.shouldKeepSelectedCellColor == YES) {
        cell.backgroundColor = self.configuration.cellBackgroundColor;
        cell.contentView.backgroundColor = (indexPath.row == _selectedIndexPath) ? self.configuration.cellSelectionColor : self.configuration.cellBackgroundColor;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedIndexPath = indexPath.row;
    if (self.selectRowAtIndexPathHandler) {
        self.selectRowAtIndexPathHandler(indexPath);
    }
    [self reloadData];
    XMTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = self.configuration.cellSelectionColor;
    cell.textLabel.textColor = self.configuration.selectedCellTextLabelColor;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    XMTableViewCell *cell = [[XMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID configuration:self.configuration];
    cell.textLabel.text = self.items[indexPath.row];
    cell.checkmarkIcon.hidden = (indexPath.row == _selectedIndexPath)? NO : YES;
    return cell;
}

/**
 *  不是点击cell不作处理，让他点击背景
 */
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    if ([view isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {
        return view;
    }
    return nil;
}

@end

#pragma mark - 实现XMNavigationDropdownMenu
@interface XMNavigationDropdownMenu ()

/** 导航控制器 */
@property(nonatomic,weak) UINavigationController  *navigationController;


/** 配置信息 */
@property (nonatomic, strong) XMNavigationDropdownMenuConfiguration *configuration;

/** 是否显示 */
@property(nonatomic,assign) BOOL  isShown;

/** 所有的显示条目 */
@property (nonatomic, strong) NSArray<NSString *> *items;

/** 导航栏菜单按钮 */
@property (nonatomic, strong) UIButton *menuButton;
/** 菜单标题 */
@property (nonatomic, strong) UILabel *menuTitle;
/** 菜单右箭头图片 */
@property (nonatomic, strong) UIImageView *menuArrow;
/** 下拉的整个view视图 */
@property (nonatomic, strong) UIView *menuWrapper;
/** 背景视图 */
@property (nonatomic, strong) UIView *backgroundView;
/** table表格 */
@property (nonatomic, strong) XMTableView *tableView;
/** 是否正在显示 */
@property(nonatomic,assign) BOOL  isShowing;
/** tableview顶部分割线 */
@property (nonatomic, strong) UIView *topSeparator;
@end

@implementation XMNavigationDropdownMenu

-(CGFloat)cellHeight{
    return self.configuration.cellHeight;
}
-(void)setCellHeight:(CGFloat)cellHeight{
    self.configuration.cellHeight = cellHeight;
}

-(UIColor *)cellSeparatorColor{
    return self.configuration.cellSeparatorColor;
}
-(void)setCellSeparatorColor:(UIColor *)cellSeparatorColor{
    self.configuration.cellSeparatorColor = cellSeparatorColor;
}


-(UIColor *)cellBackgroundColor{
    return self.configuration.cellBackgroundColor;
}


-(void)setCellBackgroundColor:(UIColor *)cellBackgroundColor{
    self.configuration.cellBackgroundColor = cellBackgroundColor;
}

-(UIColor *)cellTextLabelColor{
    return self.configuration.cellTextLabelColor;
}
-(void)setCellTextLabelColor:(UIColor *)cellTextLabelColor{
    self.configuration.cellTextLabelColor = cellTextLabelColor;
}


-(UIColor *)cellSelectionColor{
    return self.configuration.cellSelectionColor;
}

-(void)setCellSelectionColor:(UIColor *)cellSelectionColor{
    self.configuration.cellSelectionColor = cellSelectionColor;
}

-(UIColor *)menuTitleColor{
    return self.configuration.menuTitleColor;
}
-(void)setMenuTitleColor:(UIColor *)menuTitleColor{
    self.configuration.menuTitleColor = menuTitleColor;
}

-(UIFont *)cellTextLabelFont{
    return self.configuration.cellTextLabelFont;
}
-(void)setCellTextLabelFont:(UIFont *)cellTextLabelFont{
    self.configuration.cellTextLabelFont = cellTextLabelFont;
}

-(NSTextAlignment)cellTextLabelAlignment{
    return self.configuration.cellTextLabelAlignment;
}
-(void)setCellTextLabelAlignment:(NSTextAlignment)cellTextLabelAlignment{
    self.configuration.cellTextLabelAlignment = cellTextLabelAlignment;
}

-(UIColor *)arrowTintColor{
    return self.menuArrow.tintColor;
}
-(void)setArrowTintColor:(UIColor *)arrowTintColor{
    self.menuArrow.tintColor = arrowTintColor;
}


-(CGFloat)arrowPadding{
    return self.configuration.arrowPadding;
}

-(void)setArrowPadding:(CGFloat)arrowPadding{
    self.configuration.arrowPadding = arrowPadding;
}
-(CGFloat)animationDuration{
    return self.configuration.animationDuration;
}

-(void)setAnimationDuration:(CGFloat)animationDuration{
    self.configuration.animationDuration = animationDuration;
}

-(UIColor *)maskBackgroundColor{
    return self.configuration.maskBackgroundColor;
}
-(void)setMaskBackgroundColor:(UIColor *)maskBackgroundColor{
    self.configuration.maskBackgroundColor = maskBackgroundColor;
}

-(CGFloat)maskBackgroundOpacity{
    return self.configuration.maskBackgroundOpacity;
}
-(void)setMaskBackgroundOpacity:(CGFloat)maskBackgroundOpacity{
    self.configuration.maskBackgroundOpacity = maskBackgroundOpacity;
}

-(BOOL)shouldKeepSelectedCellColor{
    return self.configuration.shouldKeepSelectedCellColor;
}

-(void)setShouldKeepSelectedCellColor:(BOOL)shouldKeepSelectedCellColor{
    self.configuration.shouldKeepSelectedCellColor = shouldKeepSelectedCellColor;
}

-(BOOL)shouldChangeTitleText{
    return self.configuration.shouldChangeTitleText;
}
-(void)setShouldChangeTitleText:(BOOL)shouldChangeTitleText{
    self.configuration.shouldChangeTitleText = shouldChangeTitleText;
}

-(UIImage *)checkMarkImage{
    return self.configuration.checkMarkImage;
}

-(void)setCheckMarkImage:(UIImage *)checkMarkImage{
    if (checkMarkImage!=nil) {
        self.configuration.checkMarkImage = checkMarkImage;
    }
}

-(XMNavigationDropdownMenuConfiguration *)configuration{
    if (!_configuration) {
        _configuration = [[XMNavigationDropdownMenuConfiguration alloc] init];
    }
    return _configuration;
}

-(instancetype)initWithNavigationController:(UINavigationController *)controller containerView:(UIView *)containerView title:(NSString *)title items:(NSArray<NSString *> *)items{
    NSAssert(controller!=nil,@"导航控制器不能为空");
    self.navigationController = controller;
    
    
    // Get titleSize
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:self.configuration.navigationBarTitleFont}];
    
    // Set frame
    CGRect frame = CGRectMake(0, 0, titleSize.width + (self.configuration.arrowPadding + self.configuration.arrowImage.size.width) * 2, self.navigationController.navigationBar.frame.size.height);
    self = [super initWithFrame:frame];
    self.isShown = NO;
    self.items = items;

    // Init button as navigation title
    self.menuButton = [[UIButton alloc] initWithFrame:frame];
    [self.menuButton addTarget:self action:@selector(menuButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.menuButton];
    
    self.menuTitle = [[UILabel alloc] initWithFrame:frame];
    self.menuTitle.text = title;
    self.menuTitle.textColor = self.configuration.menuTitleColor;
    self.menuTitle.font = self.configuration.navigationBarTitleFont;
    self.menuTitle.textAlignment = self.configuration.cellTextLabelAlignment;
    [self.menuButton addSubview:self.menuTitle];
    
    self.menuArrow = [[UIImageView alloc] initWithImage:[self.configuration.arrowImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    [self.menuButton addSubview:self.menuArrow];

    CGRect menuWrapperBounds = [UIApplication sharedApplication].keyWindow.bounds;
    
    // Set up DropdownMenu
    self.menuWrapper = [[UIView alloc] initWithFrame:CGRectMake(menuWrapperBounds.origin.x, 0, menuWrapperBounds.size.width, menuWrapperBounds.size.height)];
    self.menuWrapper.clipsToBounds = YES;
    self.menuWrapper.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Init background view (under table view)
    self.backgroundView = [[UIView alloc] initWithFrame:menuWrapperBounds];
    self.backgroundView.backgroundColor = self.configuration.maskBackgroundColor;
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenu)]];
    
    [self setupDefaultConfiguration];

    // Init table view
    CGFloat navBarHeight = self.navigationController.navigationBar.bounds.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    self.tableView = [[XMTableView alloc] initWithFrame:CGRectMake(menuWrapperBounds.origin.x, menuWrapperBounds.origin.y + 0.5, menuWrapperBounds.size.width, menuWrapperBounds.size.height + 300 - navBarHeight - statusBarHeight) items:items title:title configuration:self.configuration];
    
    __weak typeof(self) weakSelf = self;
    self.tableView.selectRowAtIndexPathHandler = ^(NSIndexPath *indexPath){
        
        if (weakSelf.didSelectItemAtIndexHandler) {
            weakSelf.didSelectItemAtIndexHandler(indexPath.row);
        }
        if (weakSelf.shouldChangeTitleText) {
            weakSelf.menuTitle.text = weakSelf.tableView.items[indexPath.row];
        }
        [weakSelf hideMenu];
        [weakSelf setNeedsLayout];
    };
    
    // Add background view & table view to container view
    [self.menuWrapper addSubview:self.backgroundView];
    [self.menuWrapper addSubview:self.tableView];
    
    // Add Line on top
    self.topSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, menuWrapperBounds.size.width, 0.5)];
    self.topSeparator.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.menuWrapper addSubview:self.topSeparator];
    
    // Add Menu View to container view
    [containerView addSubview:self.menuWrapper];
    
    // By default, hide menu view
    self.menuWrapper.hidden = YES;

    return self;
}

-(void)setupDefaultConfiguration{
    self.menuTitleColor = self.navigationController.navigationBar.titleTextAttributes[NSForegroundColorAttributeName];
    self.cellBackgroundColor = self.navigationController.navigationBar.barTintColor;
    self.cellSeparatorColor = self.navigationController.navigationBar.titleTextAttributes[NSForegroundColorAttributeName];

    self.cellTextLabelColor = self.navigationController.navigationBar.titleTextAttributes[NSForegroundColorAttributeName];
    
    self.arrowTintColor = self.configuration.arrowTintColor;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    [self.menuTitle sizeToFit];
    self.menuTitle.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.menuTitle.textColor = self.configuration.menuTitleColor;
    [self.menuArrow sizeToFit];
    self.menuArrow.center = CGPointMake(CGRectGetMaxX(self.menuTitle.frame) + self.configuration.arrowPadding, self.frame.size.height/2);
    CGRect frame = self.menuWrapper.frame;
    frame.origin.y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    self.menuWrapper.frame = frame;
    [self.tableView reloadData];

}

-(void)showMenu{
    if (_isShowing) return;
    
    _isShowing = YES;
    
    CGRect frame = self.menuWrapper.frame;
    frame.origin.y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    self.menuWrapper.frame = frame;
    
    self.isShown = YES;
    
    // Table view header
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 300)];
    headerView.backgroundColor = self.configuration.cellBackgroundColor;
    self.tableView.tableHeaderView = headerView;
    
    self.topSeparator.backgroundColor = self.configuration.cellSeparatorColor;
    
    // Rotate arrow
    [self rotateArrow];
    
    // Visible menu view
    self.menuWrapper.hidden = NO;
    
    // Change background alpha
    self.backgroundView.alpha = 0;
    
    // Animation
     CGRect tableFrame = self.tableView.frame;
    tableFrame.origin.y = -(self.items.count * self.configuration.cellHeight) - 300;
    self.tableView.frame = tableFrame;

    // Reload data to dismiss highlight color of selected cell
    [self.tableView reloadData];
    
    [self.menuWrapper.superview bringSubviewToFront:self.menuWrapper];
    
    [UIView animateWithDuration:self.configuration.animationDuration * 1.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        CGRect f = self.tableView.frame;
        f.origin.y = -300.0;
        self.tableView.frame = f;
        
        self.backgroundView.alpha = self.configuration.maskBackgroundOpacity;
    } completion:^(BOOL finished) {
        _isShowing = NO;
    }];
}

-(void)hideMenu{
    if (_isShowing) return;
    
    _isShowing = YES;
    // Rotate arrow
    [self rotateArrow];
    
    self.isShown = NO;
    
    // Change background alpha
    self.backgroundView.alpha = self.configuration.maskBackgroundOpacity;
    
//    [UIView animateWithDuration:self.configuration.animationDuration * 1.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        CGRect tableFrame = self.tableView.frame;
//        tableFrame.origin.y = -200;
//        self.tableView.frame = tableFrame;
//    } completion:nil];
//    
    
    // Animation
    [UIView animateWithDuration:self.configuration.animationDuration delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        CGRect tableFrame = self.tableView.frame;
        tableFrame.origin.y = -(self.items.count *self.configuration.cellHeight) - 300;
        self.tableView.frame = tableFrame;
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.isShown==NO && self.tableView.frame.origin.y == -self.items.count * self.configuration.cellHeight - 300) {
            self.menuWrapper.hidden = YES;
        }
        _isShowing = NO;
    }];
    
}

-(void)rotateArrow{
    [UIView animateWithDuration:self.configuration.animationDuration animations:^{
        self.menuArrow.transform = CGAffineTransformRotate(self.menuArrow.transform, 180 * (M_PI / 180));
    }];
}

-(void)menuButtonTapped{
    self.isShown == YES ? [self hideMenu] : [self showMenu];
}

-(void)updateItems:(NSArray<NSString *> *)items{
    if (items.count) {
        self.items = items;
        self.tableView.items = items;
        [self.tableView reloadData];
    }
    
}

@end
