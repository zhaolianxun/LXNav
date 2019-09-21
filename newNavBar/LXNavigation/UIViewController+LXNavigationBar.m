//
//  UIViewController+LXNavigationBar.m
//  newNavBar
//
//  Created by 赵连勋 on 2019/9/1.
//  Copyright © 2019 师董会. All rights reserved.
//

#import "UIViewController+LXNavigationBar.h"
#import <objc/runtime.h>
#import "LXNavigationController.h"

@implementation UIViewController (LXNavigationBar)
#pragma mark - 导航栏背景相关的属性
//导航栏背景透明度
- (void)setLx_barAlpha:(CGFloat)lx_barAlpha {
    objc_setAssociatedObject(self, @selector(lx_barAlpha), @(lx_barAlpha), OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self lx_setNeedsNavigationBarBackgroundUpdate];
    
}
-(CGFloat)lx_barAlpha {
    NSNumber *alphaNum = objc_getAssociatedObject(self, @selector(lx_barAlpha));
    if (!alphaNum) {
        return 1.f;
    }
    return [alphaNum floatValue];
}
//背景图
- (void)setLx_backgroundImage:(UIImage *)lx_backgroundImage {
    objc_setAssociatedObject(self, @selector(lx_backgroundImage), lx_backgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self lx_setNeedsNavigationBarBackgroundUpdate];
}
-(UIImage *)lx_backgroundImage {
    UIImage *image = objc_getAssociatedObject(self, @selector(lx_backgroundImage));
    if (!image) {
        image = [UINavigationBar.appearance backgroundImageForBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    return image;
}
//导航栏底部细线隐藏属性
- (void)setLx_shadowHidden:(BOOL)lx_shadowHidden {
    objc_setAssociatedObject(self, @selector(lx_shadowHidden), @(lx_shadowHidden), OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self lx_setNeedsNavigationBarShadowUpdate];
}
-(BOOL)lx_shadowHidden {
    NSNumber *shadowHiddenNum = objc_getAssociatedObject(self, @selector(lx_shadowHidden));
    if (!shadowHiddenNum) {
        return NO;
    }
    return [shadowHiddenNum boolValue];
}
//底部线颜色
-(void)setLx_shadowColor:(UIColor *)lx_shadowColor {
    objc_setAssociatedObject(self, @selector(lx_shadowColor), lx_shadowColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self lx_setNeedsNavigationBarShadowUpdate];
}
-(UIColor *)lx_shadowColor {
    UIColor *color = objc_getAssociatedObject(self, @selector(lx_shadowColor));
    if (!color) {
        color = [UIColor blackColor];
    }
    return color;
}
//bar 背景色
-(void)setLx_backgroundColor:(UIColor *)lx_backgroundColor {
    objc_setAssociatedObject(self, @selector(lx_backgroundColor), lx_backgroundColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self lx_setNeedsNavigationBarBackgroundUpdate];
}
-(UIColor *)lx_backgroundColor {
    UIColor *color = objc_getAssociatedObject(self, @selector(lx_backgroundColor));
    if (color) {
        return color;
    }
    UIColor *backgroundColor = UINavigationBar.appearance.barTintColor;
    if (backgroundColor) {
        return backgroundColor;
    }
    return [UIColor whiteColor];
}
#pragma mark - 前景相关属性
//statusStyle
-(void)setLx_barStyle:(UIBarStyle)lx_barStyle {
    objc_setAssociatedObject(self, @selector(lx_barStyle), @(lx_barStyle), OBJC_ASSOCIATION_ASSIGN);
    [self lx_setNeedsNavigationBarTintUpdate];
}
-(UIBarStyle)lx_barStyle {
    NSNumber *barStyleNum = objc_getAssociatedObject(self, @selector(lx_barStyle));
    if (!barStyleNum) {
        return UINavigationBar.appearance.barStyle;
    }
    return barStyleNum.integerValue;
}
//标题色
- (void)setLx_titleColor:(UIColor *)lx_titleColor {
    objc_setAssociatedObject(self, @selector(lx_titleColor), lx_titleColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self lx_setNeedsNavigationBarTintUpdate];
}
-(UIColor *)lx_titleColor {
    UIColor *color = objc_getAssociatedObject(self, @selector(lx_titleColor));
    if (color) {
        return color;
    }
    UIColor *navTitleColor = [UINavigationBar.appearance.titleTextAttributes valueForKey:NSForegroundColorAttributeName];
    if (navTitleColor) {
        return navTitleColor;
    }
    return [UIColor whiteColor];;
}
//按钮颜色
-(void)setLx_tintColor:(UIColor *)lx_tintColor {
    objc_setAssociatedObject(self, @selector(lx_tintColor), lx_tintColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self lx_setNeedsNavigationBarTintUpdate];
}
-(UIColor *)lx_tintColor {
    UIColor *color = objc_getAssociatedObject(self, @selector(lx_tintColor));
    if (color) {
        return color;
    }
    UIColor *tintColor = UINavigationBar.appearance.tintColor;
    if (tintColor) {
        return tintColor;
    }
    return [UIColor whiteColor];
}
//标题字体
- (void)setLx_titleFont:(UIFont *)lx_titleFont {
    objc_setAssociatedObject(self, @selector(lx_titleFont), lx_titleFont, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self lx_setNeedsNavigationBarTintUpdate];
}
-(UIFont *)lx_titleFont {
    UIFont * font = objc_getAssociatedObject(self, @selector(lx_titleFont));
    if (font) {
        return font;
    }
    UIFont *titleFont = [UINavigationBar.appearance.titleTextAttributes valueForKey:NSFontAttributeName];
    if (titleFont) {
        return titleFont;
    }
    return [UIFont boldSystemFontOfSize:17];
}

#pragma mark - 更新背景
- (void) lx_setNeedsNavigationBarBackgroundUpdate {
    LXNavigationController *nav = (LXNavigationController *)self.navigationController;
    if (!nav) {
        return;
    }
    [nav lx_updateNavigationBarBackgroundForViewController:self];
}

#pragma mark - 更新shadow
- (void) lx_setNeedsNavigationBarShadowUpdate {
    LXNavigationController *nav = (LXNavigationController *)self.navigationController;
    if (!nav) {
        return;
    }
    [nav lx_updateNavigationBarShadowForViewController:self];
}
#pragma mark - 更新文字、title颜色
- (void) lx_setNeedsNavigationBarTintUpdate {
    LXNavigationController *nav = (LXNavigationController *)self.navigationController;
    if (!nav) {
        return;
    }
    [nav lx_updateNavigationBarTintForViewController:self];
}
@end
