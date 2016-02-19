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
#import "WeiboSDK.h"
#import "WXApi.h"
#import <BmobSDK/Bmob.h>
@interface AppDelegate ()<UITabBarControllerDelegate,WeiboSDKDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //weibo
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    //weixin
    [WXApi registerApp:kAppID];
    //bomb
    [Bmob registerWithAppKey:kbmobAppKey];
    
    
    //UITabBarController
    self.tabBarVC = [[UITabBarController alloc] init];
    //创建被tabBarVC管理的视图控制器
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
    self.tabBarVC.viewControllers = @[mainNav, discoverNav, mineNav];
    self.window.rootViewController = self.tabBarVC;
    
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark    //weibo
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    return [WeiboSDK handleOpenURL:url delegate:self];
//}
//
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    return [WeiboSDK handleOpenURL:url delegate:self];
//}

#pragma mark    //weixin
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    return  [WXApi handleOpenURL:url delegate:self];
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
//    NSLog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
//    return  isSuc;
//}


@end
