//
//  LXNavigationController.m
//  newNavBar
//
//  Created by 赵连勋 on 2019/8/31.
//  Copyright © 2019 师董会. All rights reserved.
//

#import "LXNavigationController.h"
#import "LXNavigationBar.h"
#import "UIViewController+LXNavigationBar.h"

@interface LXNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *fakeNavSuper;
@property (nonatomic, weak) UIViewController *poppingVC;
@property (nonatomic, strong) LXNavigationBar *navBar;
@property (nonatomic, strong) LXNavigationBar *toFakeBar;
@property (nonatomic, strong) LXNavigationBar *fromFakeBar;
@end

@implementation LXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.interactivePopGestureRecognizer.delegate = self;
    [self.interactivePopGestureRecognizer addTarget:self action:@selector(handleinteractivePopGesture:)];
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
}
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.fakeNavSuper addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"frame"] && [object isKindOfClass:self.fakeNavSuper.class]) {
        for (UIView *subB in self.fakeNavSuper.subviews) {
            [subB removeFromSuperview];
        }
        
        self.navBar.frame = self.fakeNavSuper.bounds;
        [self.fakeNavSuper addSubview:self.navBar];
    }
}
#pragma mark - 更新 UI
- (void)lx_updateNavigationBarForViewController:(UIViewController *)viewController {
    [self lx_updateNavigationBarTintForViewController:viewController];
    [self lx_updateNavigationBarShadowForViewController:viewController];
    [self lx_updateNavigationBarBackgroundForViewController:viewController];
}
- (void)lx_updateNavigationBarBackgroundForViewController:(UIViewController *)viewController {
    if (viewController != self.topViewController) {
        return;
    }
    [self.navBar lx_updateFakeBarBackgroundForViewContrller:viewController];
}

- (void)lx_updateNavigationBarShadowForViewController:(UIViewController *)viewController {
    if (viewController != self.topViewController) {
        return;
    }
    [self.navBar lx_updateFakeBarShadowForViewContrller:viewController];
}
- (void)lx_updateNavigationBarTintForViewController:(UIViewController *)viewController {
    [self lx_updateNavigationBarTintForViewController:viewController ignoreTintColor:NO];
}
- (void)lx_updateNavigationBarTintForViewController:(UIViewController *)viewController ignoreTintColor:(BOOL)ignoreTintColor {
    if (self.topViewController != viewController) {
        return;
    }
    [UIView setAnimationsEnabled:NO];
    self.navigationBar.barStyle = viewController.lx_barStyle;
    NSDictionary *titleTextAttributes = @{NSFontAttributeName:viewController.lx_titleFont,NSForegroundColorAttributeName:viewController.lx_titleColor};
    self.navigationBar.titleTextAttributes = titleTextAttributes;
    if (!ignoreTintColor) {
        self.navigationBar.tintColor = viewController.lx_tintColor;
    }
    [UIView setAnimationsEnabled:YES];
}

#pragma mark - nav 切换滑动相关
-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    id<UIViewControllerTransitionCoordinator> coordinator = self.transitionCoordinator;
    UIViewController *fromVC = [coordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (coordinator) {
        if (!fromVC && [fromVC isKindOfClass:self.poppingVC.class]) {
            [self lx_updateNavigationBarForViewController:fromVC];
        }
    } else {
        if (self.topViewController) {
            [self lx_updateNavigationBarForViewController:self.topViewController];
        }
    }
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated {
    self.poppingVC = self.topViewController;
    UIViewController *viewController = [super popViewControllerAnimated:animated];
    if (self.topViewController) {
        [self lx_updateNavigationBarTintForViewController:self.topViewController ignoreTintColor:YES];
    }
    return viewController;
}

-(NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    self.poppingVC = self.topViewController;
    NSArray *vcArray = [super popToRootViewControllerAnimated:animated];
    if (self.topViewController) {
        [self lx_updateNavigationBarTintForViewController:self.topViewController ignoreTintColor:YES];
    }
    return vcArray;
}
-(NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.poppingVC = self.topViewController;
    NSArray *vcArray = [super popToViewController:viewController animated:animated];
    if (self.topViewController) {
        [self lx_updateNavigationBarTintForViewController:self.topViewController ignoreTintColor:YES];
    }
    return vcArray;
}
- (void)handleinteractivePopGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    id<UIViewControllerTransitionCoordinator> coordinator = self.transitionCoordinator;
    UIViewController *fromVC = [coordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [coordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    if (coordinator != nil && fromVC != nil && toVC != nil) {
        if (gesture.state == UIGestureRecognizerStateChanged) {
            self.navigationBar.tintColor = [self averageFromColor:fromVC.lx_tintColor toColor:toVC.lx_tintColor precent:coordinator.percentComplete];
        }
    }
}

- (UIColor *)averageFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor precent:(CGFloat)percent {
    CGFloat fromRed = 0;
    CGFloat fromGreen = 0;
    CGFloat fromBlue = 0;
    CGFloat fromAlpha = 0;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed = 0;
    CGFloat toGreen = 0;
    CGFloat toBlue = 0;
    CGFloat toAlpha = 0;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    CGFloat red = fromRed + (toRed - fromRed) * percent;
    CGFloat green = fromGreen + (toGreen - fromGreen) * percent;
    CGFloat blue = fromBlue + (toBlue - fromBlue) * percent;
    CGFloat alpha = fromAlpha + (toAlpha - fromAlpha) * percent;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (void) showViewController:(UIViewController *)viewController coordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    UIViewController *fromVC = [coordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [coordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    if (fromVC == nil || toVC == nil) {
        return;
    }
    [self resetButtonLabelsInView:self.navigationBar];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self lx_updateNavigationBarTintForViewController:viewController ignoreTintColor:context.isInteractive];
        if (viewController == toVC) {
            [self showTempFakeBarFromVc:fromVC toVc:toVC];
        } else {
            [self lx_updateNavigationBarBackgroundForViewController:viewController];
            [self lx_updateNavigationBarShadowForViewController:viewController];
        }
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        if (context.isCancelled) {
            [self lx_updateNavigationBarForViewController:fromVC];
        } else {
            [self lx_updateNavigationBarForViewController:viewController];
        }
        if (viewController == toVC) {
            [self clearTempFakeBar];
        }
    }];
}
- (void) showTempFakeBarFromVc:(UIViewController *)fromVc toVc:(UIViewController *)toVc {
    [UIView setAnimationsEnabled:NO];
    self.navBar.alpha = 0;
    //from
    [fromVc.view addSubview:self.fromFakeBar];
    self.fromFakeBar.frame = [self fakerBarFrameForViewController:fromVc];
    [self.fromFakeBar setNeedsLayout];
    [self.fromFakeBar lx_updateFakeBarShadowForViewContrller:fromVc];
    [self.fromFakeBar lx_updateFakeBarBackgroundForViewContrller:fromVc];
    //to
    [toVc.view addSubview:self.toFakeBar];
    self.toFakeBar.frame = [self fakerBarFrameForViewController:toVc];
    [self.toFakeBar setNeedsLayout];
    [self.toFakeBar lx_updateFakeBarBackgroundForViewContrller:toVc];
    [self.toFakeBar lx_updateFakeBarShadowForViewContrller:toVc];
    [UIView setAnimationsEnabled:YES];
}

- (void) clearTempFakeBar {
    self.navBar.alpha = 1;
    [self.fromFakeBar removeFromSuperview];
    [self.toFakeBar removeFromSuperview];
}

- (CGRect)fakerBarFrameForViewController:(UIViewController *)viewController {
    if (!self.fakeNavSuper) {
        return self.navigationBar.frame;
    }
    CGRect frame = [self.navigationBar convertRect:self.fakeNavSuper.frame toView:viewController.view];
    frame.origin.x = viewController.view.frame.origin.x;
    return frame;
}
- (void) resetButtonLabelsInView:(UIView *)view {
    NSString *viewClassName = NSStringFromClass([view classForCoder]);
    [viewClassName stringByReplacingOccurrencesOfString:@"_" withString:@""];
    if ([viewClassName isEqualToString:@"UIButtonLabel"]) {
        view.alpha = 1;
    } else {
        if (view.subviews.count > 0) {
            for (UIView *subview in view.subviews) {
                [self resetButtonLabelsInView:subview];
            }
        }
    }
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.transitionCoordinator) {
        [self showViewController:viewController coordinator:self.transitionCoordinator];
    } else {
        if (!animated && self.viewControllers.count > 1) {
            UIViewController *lastButOneVc = self.viewControllers[self.viewControllers.count - 2];
            [self showTempFakeBarFromVc:lastButOneVc toVc:viewController];
            return;
        }
        [self lx_updateNavigationBarForViewController:viewController];
    }
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!animated) {
        [self lx_updateNavigationBarForViewController:viewController];
        [self clearTempFakeBar];
    }
    self.poppingVC = nil;
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1) {
        return NO;
    }
//    if (self.topViewController) {
//        return self.topViewController.lx_enablePopGesture;
//    }
    return YES;
}
-(UIView *)fakeNavSuper {
    if (!_fakeNavSuper) {
        _fakeNavSuper = self.navigationBar.subviews.firstObject;
        self.navBar.frame = self.fakeNavSuper.bounds;
        [_fakeNavSuper insertSubview:self.navBar atIndex:0];
    }
    return _fakeNavSuper;
}

-(LXNavigationBar *)navBar {
    if (!_navBar) {
        _navBar = [LXNavigationBar new];
    }
    return _navBar;
}
-(LXNavigationBar *)fromFakeBar {
    if (!_fromFakeBar) {
        _fromFakeBar = [LXNavigationBar new];
    }
    return _fromFakeBar;
}

-(LXNavigationBar *)toFakeBar {
    if (!_toFakeBar) {
        _toFakeBar = [LXNavigationBar new];
    }
    return _toFakeBar;
}

@end
