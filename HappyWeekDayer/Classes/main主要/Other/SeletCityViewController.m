//
//  SeletCityViewController.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "SeletCityViewController.h"
#import "HeadCollectionReusableView.h"
#import "FootCollectionReusableView.h"
#import <CoreLocation/CoreLocation.h>

static NSString *itemIdentifier = @"itemIdentifier";
static NSString *headIdentifier = @"headIdentifier";
//static NSString *footIdentifier = @"footIdentifier";

@interface SeletCityViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
}
/** collectionView */
@property (nonatomic, retain) UICollectionView *collectionView;
/** 城市cat_name */
@property (nonatomic, retain) NSMutableArray *cityListArray;
/** 城市cat_id */
@property (nonatomic, retain) NSMutableArray *cityIdArray;

@end

@implementation SeletCityViewController
- (NSMutableArray *)cityListArray
{
    if (!_cityListArray) {
        self.cityListArray = [[NSMutableArray alloc] init];
    }
    return _cityListArray;
}
- (NSMutableArray *)cityIdArray
{
    if (!_cityIdArray) {
        self.cityIdArray = [[NSMutableArray alloc] init];
    }
    return _cityIdArray;
}

- (NSMutableArray *)getCity:(void (^)(NSMutableArray *))city{
    
    return self.cityListArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"切换城市";
    self.tabBarController.tabBar.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.collectionView];
    [self showBackButtonWithImage:@"camera_cancel_up"];
    [self requestModel];
}
- (void)backButtonAction:(UIButton *)btn{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)requestModel{
    NSString *URLString = kCity;
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManager GET:URLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        fSLog(@"%@",responseObject);
        [self make:responseObject];
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fSLog(@"%@",error);
    }];
    
}
- (void)make:(NSMutableDictionary *)responseObject{
    NSDictionary *dic = responseObject;
    NSString *status = dic[@"status"];
    NSInteger code = [dic[@"code"] integerValue];
    if ([status isEqualToString:@"success"] && code == 0) {
        NSDictionary *successdic = dic[@"success"];
        NSArray *cat_name = successdic[@"list"];
        for (NSDictionary *dict in cat_name) {
            [self.cityListArray addObject:dict[@"cat_name"]];
            [self.cityIdArray addObject:dict[@"cat_id"]];
        }
    }
    
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //默认垂直
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置每个Item的大小
        layout.itemSize = CGSizeMake(kWidth / 3 - 10 , kWidth / 6 -10 );
        //通过一个layout布局来创建一个collectionView
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor clearColor];
        //注册item类型
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:itemIdentifier];
        //设置每一行的间距
        layout.minimumLineSpacing = 10;
        //设置item的间距
        layout.minimumInteritemSpacing = 1;
        //section的间距
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        //设置collectionView的区头区尾大小
        layout.headerReferenceSize = CGSizeMake(kWidth, 137);
//        layout.footerReferenceSize = CGSizeMake(kWidth, 100);
        //注册头部
//        [self.collectionView registerClass:[HeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier];
        [self.collectionView registerNib:[UINib nibWithNibName:@"HeadCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier];
        
        //注册尾部
//        [self.collectionView registerClass:[FootCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"cellFooter"];
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.cityListArray.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate getcityName:self.cityListArray[indexPath.row] cityId:self.cityListArray[indexPath.row]];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemIdentifier forIndexPath:indexPath];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.cityListArray[indexPath.row];
    titleLabel.backgroundColor = [UIColor colorWithRed:0.818 green:0.784 blue:0.224 alpha:1.000];
    [cell addSubview:titleLabel];
    
    return cell;
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    if (kind == UICollectionElementKindSectionHeader) {
        HeadCollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headIdentifier forIndexPath:indexPath];
        //定位城市标签
    NSString *city = [[NSUserDefaults standardUserDefaults] valueForKey:@"city"];
//    headView.changLabel.text = city;
        headView.changLabel.text = [city substringToIndex:city.length - 1];
        //重新定位
        [headView.locationBtn addTarget:self action:@selector(reLocationAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
    return headView;
//    FootCollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"cellfooter" forIndexPath:indexPath];
//    return footView;
    
}
- (void)reLocationAction:(UIButton *)btn {
    [ProgressHUD show:@"定位中..."];
    _locationManager = [[CLLocationManager alloc] init];
    //设置代理
    _locationManager.delegate = self;
    //定位精度
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    //多少米定位一次
    CLLocationDistance distance = 10.0;
    _locationManager.distanceFilter = distance;
    //开始定位
    [_locationManager startUpdatingLocation];
    
    _geocoder = [[CLGeocoder alloc] init];
}

#pragma mark ------  LocationDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //从数组中取出一个定位的信息
    CLLocation *location = [locations lastObject];
    //从CLLoction中取出坐标
    //CLLocationCoordinate2D 坐标系，里边包含经度和纬度
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:[NSNumber numberWithDouble:coordinate.latitude] forKey:@"lat"];
    [userDefault setValue:[NSNumber numberWithDouble:coordinate.longitude] forKey:@"lng"];
    
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placeMark = [placemarks firstObject];
        [[NSUserDefaults standardUserDefaults] setValue:placeMark.addressDictionary[@"City"] forKey:@"city"];
        //保存
        [userDefault synchronize];
        [ProgressHUD showSuccess:@"定位成功"];
        [self.collectionView reloadData];
    }];
    //如果不需要使用定位服务的时候，及时关闭定位服务
    [_locationManager stopUpdatingLocation];
}



@end













