//
//  ViewController.m
//  newNavBar
//
//  Created by 赵连勋 on 2019/8/31.
//  Copyright © 2019 师董会. All rights reserved.
//

#import "ViewController.h"
#import "LXNavigation/LXNavigationBar.h"
#import "UIViewController+LXNavigationBar.h"
#import "NextViewController.h"

@interface ViewController ()
//@property (nonatomic, strong) UIView *fakeNavSuper;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"xxxxxx";
    self.lx_backgroundImage = [UIImage imageNamed:@"sunset"];
}
- (IBAction)barAlphaChanged:(UISlider *)sender {
    self.lx_barAlpha = sender.value;
}
- (IBAction)showImage:(UISwitch *)sender {
    if (sender.isOn) {
        self.lx_backgroundImage = [UIImage imageNamed:@"sunset"];
    } else {
        self.lx_backgroundImage = nil;
    }
}
- (IBAction)shadowHidden:(UISwitch *)sender {
    if (sender.isOn) {
        self.lx_shadowHidden = NO;
    } else {
        self.lx_shadowHidden = YES;
    }
}
- (IBAction)barStyle:(UISwitch *)sender {
    if (sender.isOn) {
        self.lx_barStyle = UIBarStyleDefault;
    } else {
        self.lx_barStyle = UIBarStyleBlack;
    }
}

- (IBAction)nextVc:(UIBarButtonItem *)sender {
    NextViewController *vc = [NextViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)barBackgroundColor:(UIButton *)sender {
    self.lx_backgroundColor = sender.backgroundColor;
}
- (IBAction)shadowBackgroundColor:(UIButton *)sender {
    self.lx_shadowColor = sender.backgroundColor;
}
- (IBAction)tintColor:(UIButton *)sender {
    self.lx_tintColor = sender.backgroundColor;
}
- (IBAction)titleColor:(UIButton *)sender {
    self.lx_titleColor = sender.backgroundColor;
}
- (IBAction)fontSizeChangeSlider:(UISlider *)sender {
    self.lx_titleFont = [UIFont systemFontOfSize:(15 + 15*sender.value)];
}
- (IBAction)pushVc:(UIButton *)sender {
//    DemoViewController *vc = [DemoViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *nav = sb.instantiateInitialViewController;
    UIViewController *vc = nav.topViewController;
    vc.title = [NSString stringWithFormat:@"%d",(arc4random() % 1000) + 1];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
