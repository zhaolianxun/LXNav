//
//  NextViewController.m
//  newNavBar
//
//  Created by 赵连勋 on 2019/9/16.
//  Copyright © 2019 师董会. All rights reserved.
//

#import "NextViewController.h"
#import "LXNavigation/LXNavigation.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    self.lx_barAlpha = 0;
    self.lx_titleColor = [UIColor clearColor];
    self.lx_shadowHidden = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
