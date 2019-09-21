//
//  LXNavigationBar.h
//  newNavBar
//
//  Created by 赵连勋 on 2019/8/31.
//  Copyright © 2019 师董会. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXNavigationBar : UIView
/**
 更新背景
 
 @param viewController 更新的 VC
 */
- (void)lx_updateFakeBarBackgroundForViewContrller:(UIViewController *)viewController;
/**
 更新 shadow
 
 @param viewController 更新的 VC
 */
- (void)lx_updateFakeBarShadowForViewContrller:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
