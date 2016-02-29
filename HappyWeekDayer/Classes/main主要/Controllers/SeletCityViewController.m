//
//  SeletCityViewController.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "SeletCityViewController.h"

@interface SeletCityViewController ()

@end

@implementation SeletCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.title = @"切换城市";
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end













