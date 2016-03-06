//
//  AppDelegate.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "WeiboSDK.h"
#import "WXApi.h"
#import <BmobSDK/Bmob.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate ()<UITabBarControllerDelegate,WeiboSDKDelegate,WXApiDelegate,CLLocationManagerDelegate>
{
    /** 创建定位所需要的类的实例对象 */
    CLLocationManager *_locationManager;
    /** 编码 */
    CLGeocoder *_geocoder;
}
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
    
    //初始化
    _locationManager = [[CLLocationManager alloc] init];
    _geocoder = [[CLGeocoder alloc] init];
    if (![CLLocationManager locationServicesEnabled]) {
        fSLog(@"定位服务当前可能尚未打开，请设置打开！");
    }
    // 判断是否是iOS8
//    if([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0){
////        NSLog(@"是iOS8以上");
//        // 主动要求用户对我们的程序授权, 授权状态改变就会通知代理
//        [_locationManager requestAlwaysAuthorization]; // 请求前台和后台定位权限
//        //[self.mgr requestWhenInUseAuthorization];// 请求前台定位权限
//    }else{
//        NSLog(@"是iOS7");
//        // 3.开始监听(开始获取位置)
//        [_locationManager startUpdatingLocation];
//    }

    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestWhenInUseAuthorization];
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
    //设置代理
    _locationManager.delegate = self;
    //设置定位精度,精度越高越耗电
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    //定位频率，每隔多少米定位一次
    CLLocationDistance distance = 10.0;
    _locationManager.distanceFilter = distance;
    //启动跟踪定位
    [_locationManager startUpdatingLocation];
}
    self.window.rootViewController = [TabBarViewController new];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //取出第一个位置
    CLLocation *location = [locations lastObject];
    //获取坐标
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:[NSNumber numberWithDouble:coordinate.latitude] forKey:@"lat"];
    [userDefault setValue:[NSNumber numberWithDouble:coordinate.longitude] forKey:@"lng"];
    //汉字多了之后就不提示
//    fSLog(@"经度：%f  维度：%f 海拔：%f 航向：%f行走速度：%f", coordinate.longitude, coordinate.latitude, location.altitude,location.course,location.speed);
    
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placeMark = [placemarks firstObject];
        [[NSUserDefaults standardUserDefaults] setValue:placeMark.addressDictionary[@"City"] forKey:@"city"];
        //保存
        [userDefault synchronize];
//        fSLog(@"%@", placeMark.addressDictionary);
//        fSLog(@"获取地理位置成功 name = %@ locality = %@", placeMark.name, placeMark.locality);
    }];
    
    //如果不需要实时定位，使用完即使关闭定位服务
    //    [_locationManager stopUpdatingLocation];
    
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
