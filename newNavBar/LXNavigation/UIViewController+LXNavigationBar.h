//
//  UIViewController+LXNavigationBar.h
//  newNavBar
//
//  Created by 赵连勋 on 2019/9/1.
//  Copyright © 2019 师董会. All rights reserved.
//

#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LXNavigationBar)
/** 状态栏样式 */
@property (nonatomic, assign) UIBarStyle lx_barStyle;
/** 导航栏前景色（item的文字图标颜色），默认黑色 */
@property (nonatomic, strong) UIColor *lx_tintColor;
/** 导航栏标题文字颜色，默认黑色 */
@property (nonatomic, strong) UIColor *lx_titleColor;
/** 导航栏标题文字字体，默认17号粗体 */
@property (nonatomic, strong) UIFont *lx_titleFont;
/** 导航栏背景色，默认白色 */
@property (nonatomic, strong) UIColor *lx_backgroundColor;
/** 导航栏背景图片 */
@property (nonatomic, strong) UIImage *lx_backgroundImage;
/** 导航栏背景透明度，默认1 */
@property (nonatomic, assign) CGFloat lx_barAlpha;
/** 导航栏底部分割线是否隐藏，默认不隐藏*/
@property (nonatomic, assign) BOOL lx_shadowHidden;
/** 导航栏底部分割线颜色 */
@property (nonatomic, strong) UIColor *lx_shadowColor;

@end

//NS_ASSUME_NONNULL_END
