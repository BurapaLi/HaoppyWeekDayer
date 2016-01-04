//
//  AppDelegate.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "AppDelegate.h"
#import "IndexViewController.h"
#import "FindViewController.h"
#import "OwerViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
//    UITabBarController *tabBarVc = [UITabBarController new];
//    
//    IndexViewController *weChatVc = [IndexViewController new];
//    UINavigationController *weChatVcNav = [[UINavigationController alloc] initWithRootViewController:weChatVc];
//    
//    FindViewController *addVc = [FindViewController new];
//    UINavigationController *addVcNav = [[UINavigationController alloc] initWithRootViewController:addVc];
//    
//    OwerViewController *disVc = [OwerViewController new];
//    UINavigationController *disVcNav = [[UINavigationController alloc] initWithRootViewController:disVc];
//    
//    
//    weChatVc.tabBarItem.title = @"主页";
//    addVc.tabBarItem.title = @"发现";
//    disVc.tabBarItem.title = @"我的";
//    
//    weChatVc.tabBarItem.image = [UIImage imageNamed:@"09-chat2.png"];
//    addVc.tabBarItem.image = [UIImage imageNamed:@"38-airplane.png"];
//    disVc.tabBarItem.image = [UIImage imageNamed:@"84-lightbulb.png"];
//    
//    
////    tabBarVc.tabBar.backgroundColor = [UIColor purpleColor];
//    
//    tabBarVc.viewControllers = @[weChatVcNav,addVcNav,disVcNav];
//    tabBarVc.delegate = self;
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:tabBarVc];
    
    //UITabBarController
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    //创建被tabBarVC管理的视图控制器
    //主页
    //欢乐周末
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
    tabBarVC.viewControllers = @[mainNav, discoverNav, mineNav];
    self.window.rootViewController = tabBarVC;
    
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
