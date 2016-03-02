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

static NSString *itemIdentifier = @"itemIdentifier";
static NSString *headIdentifier = @"headIdentifier";
//static NSString *footIdentifier = @"footIdentifier";

@interface SeletCityViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** collectionView */
@property (nonatomic, retain) UICollectionView *collectionView;
/** 城市cat_name */
@property (nonatomic, retain) NSMutableArray *cityListArray;


@end

@implementation SeletCityViewController
- (NSMutableArray *)cityListArray
{
    if (!_cityListArray) {
        self.cityListArray = [[NSMutableArray alloc] init];
    }
    return _cityListArray;
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemIdentifier forIndexPath:indexPath];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.cityListArray[indexPath.row];
    titleLabel.backgroundColor = [UIColor grayColor];
    [cell addSubview:titleLabel];
    
    return cell;
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *headView = nil;
//    if (kind == UICollectionElementKindSectionHeader) {
        headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headIdentifier forIndexPath:indexPath];
    
    
        return headView;
//    }
//    FootCollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"cellfooter" forIndexPath:indexPath];
//    return footView;
    
}




@end













