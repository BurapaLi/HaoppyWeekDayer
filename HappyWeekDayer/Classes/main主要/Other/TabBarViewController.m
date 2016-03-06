//
//  TabBarViewController.m
//  HappyWeekDayer
//
//  Created by scjy on 16/3/2.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //主页
    UIStoryboard *mainStroyBoard = [UIStoryboard storyboardWithName:@"Index" bundle:nil];
    UINavigationController *mainNav = mainStroyBoard.instantiateInitialViewController;
    //发现
    UIStoryboard *discoverStroyBoard = [UIStoryboard storyboardWithName:@"FindView" bundle:nil];
    UINavigationController *discoverNav = discoverStroyBoard.instantiateInitialViewController;
    //我的
    UIStoryboard *mineStroyBoard = [UIStoryboard storyboardWithName:@"Ower" bundle:nil];
    UINavigationController *mineNav = mineStroyBoard.instantiateInitialViewController;
    
    mainNav.tabBarItem.image = [UIImage imageNamed:@"ft_found_normal_ic"];
    discoverNav.tabBarItem.image = [UIImage imageNamed:@"ft_home_normal_ic"];
    mineNav.tabBarItem.image = [UIImage imageNamed:@"ft_person_normal_ic"];
    
    //上左下右
    mainNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    discoverNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    mineNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    
    mainNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"ft_found_selected_ic"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    discoverNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"ft_home_selected_ic"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"ft_person_selected_ic"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //添加被管理的视图控制器
    self.viewControllers = @[mainNav, discoverNav, mineNav];
    
    
}


@end
