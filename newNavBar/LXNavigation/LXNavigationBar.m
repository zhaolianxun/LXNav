//
//  LXNavigationBar.m
//  newNavBar
//
//  Created by 赵连勋 on 2019/8/31.
//  Copyright © 2019 师董会. All rights reserved.
//

#import "LXNavigationBar.h"
#import "UIViewController+LXNavigationBar.h"

@interface LXNavigationBar ()
/**  背景图 */
@property (nonatomic, strong) UIImageView *fakeBackgroundImageView;
/** 背景 effectView */
@property (nonatomic, strong) UIVisualEffectView *fakeBackgroundEffectView;
/**  细线 */
@property (nonatomic, strong) UIImageView *fakeShadowImageView;

@end

@implementation LXNavigationBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.fakeBackgroundEffectView];
    [self addSubview:self.fakeBackgroundImageView];
    [self addSubview:self.fakeShadowImageView];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.fakeBackgroundImageView.frame = self.bounds;
    self.fakeBackgroundEffectView.frame = self.bounds;
    self.fakeShadowImageView.frame = CGRectMake(0, self.bounds.size.height - 0.5, self.bounds.size.width, 0.5);
}

- (void)lx_updateFakeBarBackgroundForViewContrller:(UIViewController *)viewController {
    self.fakeBackgroundEffectView.alpha = viewController.lx_barAlpha;
    self.fakeBackgroundEffectView.backgroundColor = viewController.lx_backgroundColor;
    UIImage *image = viewController.lx_backgroundImage;
    self.fakeBackgroundImageView.image = image;
    self.fakeBackgroundImageView.alpha = viewController.lx_barAlpha;
    self.fakeShadowImageView.alpha = viewController.lx_barAlpha;
}
- (void)lx_updateFakeBarShadowForViewContrller:(UIViewController *)viewController {
    self.fakeShadowImageView.hidden = viewController.lx_shadowHidden;
    self.fakeShadowImageView.backgroundColor = viewController.lx_shadowColor;
}

-(UIImageView *)fakeShadowImageView {
    if (!_fakeShadowImageView) {
        _fakeShadowImageView = [UIImageView new];
        _fakeShadowImageView.userInteractionEnabled = NO;
        _fakeShadowImageView.contentScaleFactor = 1;
        _fakeShadowImageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _fakeShadowImageView.layer.masksToBounds = YES;
    }
    return _fakeShadowImageView;
}
-(UIImageView *)fakeBackgroundImageView {
    if (!_fakeBackgroundImageView) {
        _fakeBackgroundImageView = [UIImageView new];
        _fakeBackgroundImageView.userInteractionEnabled = NO;
        _fakeBackgroundImageView.layer.masksToBounds = YES;
        _fakeBackgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _fakeBackgroundImageView;
}
-(UIVisualEffectView *)fakeBackgroundEffectView {
    if (!_fakeBackgroundEffectView) {
        _fakeBackgroundEffectView = [UIVisualEffectView new];
        _fakeBackgroundEffectView.userInteractionEnabled = NO;
    }
    return _fakeBackgroundEffectView;
}
@end
