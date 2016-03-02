//
//  HeadCollectionReusableView.m
//  HappyWeekDayer
//
//  Created by scjy on 16/3/1.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "HeadCollectionReusableView.h"
#import <CoreLocation/CoreLocation.h>

@interface HeadCollectionReusableView()<CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
}
@property (weak, nonatomic) IBOutlet UILabel *changLabel;

@end
@implementation HeadCollectionReusableView
- (IBAction)btn:(id)sender {
    //定位城市标签
    self.cityName = kUDDS(city);
    //重新定位
    [self.locationBtn addTarget:self action:@selector(relocationAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setCity:(NSString *)cityName{
    fSLog(@"%@",self.changLabel.text);
    self.changLabel.text = cityName;
    
}


//重新定位
- (void)relocationAction:(UIButton *)btn{
    [ProgressHUD show:@"正在定位"];
    _locationManager = [[CLLocationManager alloc] init];
    _geocoder = [[CLGeocoder alloc] init];
    if (![CLLocationManager locationServicesEnabled]) {
        fSLog(@"用户位置服务不可用");
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestWhenInUseAuthorization];
    } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        CLLocationDistance distance = 100.0;
        _locationManager.distanceFilter = distance;
        [_locationManager startUpdatingLocation];
    }
}
//重新定位代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    fSLog(@"%@", locations);
    [ProgressHUD showSuccess:@"定位成功"];
    //从数组中取出一个定位的信息
    CLLocation *location = [locations lastObject];
    //从CLLocation中取出坐标
    //CLLocationCoordinate2D 坐标系 里边包含经度和纬度
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:[NSNumber numberWithDouble:coordinate.latitude] forKey:@"lat"];
    [userDefault setValue:[NSNumber numberWithDouble:coordinate.longitude] forKey:@"lng"];
    
    fSLog(@"纬度:%f 经度:%f 海拔:%f 航向:%f 行走速度:%f", coordinate.latitude, coordinate.longitude, location.altitude, location.course, location.speed);
    
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placeMark = [placemarks lastObject];
        
        [[NSUserDefaults standardUserDefaults] setValue:placeMark.addressDictionary[@"City"] forKey:@"city"];
        //保存
        [userDefault synchronize];
        fSLog(@"%@", placeMark.addressDictionary);
    }];
    //如果不需要使用定位服务的时候,及时关闭定位服务
    [manager stopUpdatingLocation];
}



@end
