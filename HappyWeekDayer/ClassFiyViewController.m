//
//  ClassFiyViewController.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "ClassFiyViewController.h"
#import "AcitivyViewController.h"
#import "GoodModel.h"
#import "GoodTableViewCell.h"

@interface ClassFiyViewController ()<PullingRefreshTableViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _pagecount;
}
@property (nonatomic, strong) PullingRefreshTableView *tableView;
@property (nonatomic, assign) BOOL refreshing;
//展示数据
@property (nonatomic, strong) NSMutableArray *showDataArray;
@property (nonatomic, strong) NSMutableArray *showArray;
@property (nonatomic, strong) NSMutableArray *touristArray;
@property (nonatomic, strong) NSMutableArray *studentArray;
@property (nonatomic, strong) NSMutableArray *familyArray;
@property (nonatomic, strong) VOSegmentedControl *segmentedControl;

@end

@implementation ClassFiyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分类列表";
    self.tabBarController.tabBar.hidden = YES;
    
    [self.view addSubview:self.segmentedControl];
    [self showBackButton];
    self.tableView.tableFooterView = [[UITableView alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//    [self.tableView launchRefreshing];
    
    [self tou];
    [self getFourRequest];
    [self showPreviousSelectButton];
}
- (void)showPreviousSelectButton{
    switch (self.classifyType) {
        case ClassifyTypeShowRepertorie:{
            self.showDataArray = self.showArray;
        }
            break;
        case ClassifyTypeTouristPlace:{
            self.showDataArray = self.touristArray;
        }
            break;
        case ClassifyTypeFamilyTravel:{
            self.showDataArray = self.studentArray;
        }
            break;
        case ClassifyTypeStudyPUZ:{
            self.showDataArray = self.familyArray;
        }
            break;
            
        default:
            break;
    }
    [self.tableView reloadData];
}
//演出剧目 景点场馆 学习益智 亲子旅游
- (void)tou{
    self.segmentedControl = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText: @"演出剧目"}, @{VOSegmentText: @"景点场馆"},@{VOSegmentText: @"学习益智"}, @{VOSegmentText: @"亲子旅游"}]];
    
    self.segmentedControl.contentStyle = VOContentStyleTextAlone;
    self.segmentedControl.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
    self.segmentedControl.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.segmentedControl.selectedBackgroundColor = self.segmentedControl.backgroundColor;
    self.segmentedControl.allowNoSelection = NO;
    self.segmentedControl.frame = CGRectMake(10, 100, 300, 40);
    self.segmentedControl.indicatorThickness = 4;
    self.segmentedControl.tag = 1;
    [self.view addSubview:self.segmentedControl];
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"1: block --> %@", @(index));
    }];
    [self.segmentedControl addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];
    
    
}
- (void)segmentCtrlValuechange: (VOSegmentedControl *)segmentCtrl{
//    NSLog(@"%@: value --> %@",@(segmentCtrl.tag), @(segmentCtrl.selectedSegmentIndex));
}

#pragma mark    //数据请求
- (void)getFourRequest{
    //演出剧目typeid=6
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [sessionManager GET:[NSString stringWithFormat:@"%@&page=%@&typeid=%@", kclass , @(1),@(6)] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self make1:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        fSLog(@"%@", error);
    }];
    
    //= 景点场馆23
    [sessionManager GET:[NSString stringWithFormat:@"%@&page=%@&typeid=%@", kclass , @(1),@(23)] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self make2:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        fSLog(@"%@", error);
    }];
    //= 学习益智22
    [sessionManager GET:[NSString stringWithFormat:@"%@&page=%@&typeid=%@", kclass , @(1),@(22)] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self make3:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        fSLog(@"%@", error);
    }];
    //= 21
    [sessionManager GET:[NSString stringWithFormat:@"%@&page=%@&typeid=%@", kclass , @(1),@(21)] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self make4:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        fSLog(@"%@", error);
    }];

}

- (void)make1:(NSDictionary *)responseObject{
    NSDictionary *resultDic = responseObject;
    NSString *ststus = resultDic[@"status"];
    NSInteger code = [resultDic[@"code"] integerValue];
    if ([ststus isEqualToString:@"success"] && code == 0) {
        NSDictionary *dic = resultDic[@"success"];
        NSArray *acDataArray = dic[@"acData"];
        for (NSDictionary *dic in acDataArray) {
            GoodModel *model = [[GoodModel alloc] initWithDicticionary:dic];
            [self.showArray addObject:model];
        }
        //刷新tableView,他会重新执行tableView的所有代理方法
        [self.tableView reloadData];

    }
}
- (void)make2:(NSDictionary *)responseObject{
    NSDictionary *resultDic = responseObject;
    NSString *ststus = resultDic[@"status"];
    NSInteger code = [resultDic[@"code"] integerValue];
    
    if ([ststus isEqualToString:@"success"] && code == 0) {
        NSDictionary *dic = resultDic[@"success"];
        NSArray *acDataArray = dic[@"acData"];
        for (NSDictionary *dic in acDataArray) {
            GoodModel *model = [[GoodModel alloc] initWithDicticionary:dic];
            [self.touristArray addObject:model];
        }
        [self.tableView reloadData];
    }
}
- (void)make3:(NSDictionary *)responseObject{
    NSDictionary *resultDic = responseObject;
    NSString *ststus = resultDic[@"status"];
    NSInteger code = [resultDic[@"code"] integerValue];
    
    if ([ststus isEqualToString:@"success"] && code == 0) {
        NSDictionary *dic = resultDic[@"success"];
        NSArray *acDataArray = dic[@"acData"];
        for (NSDictionary *dic in acDataArray) {
            GoodModel *model = [[GoodModel alloc] initWithDicticionary:dic];
            [self.studentArray addObject:model];
        }
        [self.tableView reloadData];

    }

}
- (void)make4:(NSDictionary *)responseObject{
    NSDictionary *resultDic = responseObject;
    NSString *ststus = resultDic[@"status"];
    NSInteger code = [resultDic[@"code"] integerValue];
    
    if ([ststus isEqualToString:@"success"] && code == 0) {
        NSDictionary *dic = resultDic[@"success"];
        NSArray *acDataArray = dic[@"acData"];
        for (NSDictionary *dic in acDataArray) {
            GoodModel *model = [[GoodModel alloc] initWithDicticionary:dic];
            [self.familyArray addObject:model];
        }
        [self.tableView reloadData];

    }
}
#pragma mark    //CustomMethod

#pragma mark    //表格数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.goodModel = self.showArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Index" bundle:nil];
    AcitivyViewController *activityDetailVC = [storyBoard instantiateViewControllerWithIdentifier:@"123"];
//    GoodModel *goodModel = self.acArray[indexPath.row];
//    activityDetailVC.activityId = goodModel.ID;
    
    [self.navigationController pushViewController:activityDetailVC animated:YES];
}
#pragma mark    //表格代理

#pragma mark    //PullingRefreshTableViewDelegate
//tableView下拉刷新开始的时候调用
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    
    self.refreshing = YES;
    _pagecount = 1;
    [self performSelector:@selector(getFourRequest) withObject:nil afterDelay:1.0];
    
    
}
//上拉
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    self.refreshing = NO;
    _pagecount = 1;
    [self performSelector:@selector(getFourRequest) withObject:nil afterDelay:1.0];
}
//刷新完成时间
- (NSDate *)pullingTableViewRefreshingFinishedDate{
    return [DateTools getSystemNowDate];
    
}
//手指开始拖动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
    
}
//手指结束拖动方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

#pragma mark    //懒加载
- (PullingRefreshTableView *)tableView
{
    if (!_tableView) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, - 40, kWidth, kHeight - 64 - 40) pullingDelegate:self];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return _tableView;
}
- (NSMutableArray *)showArray
{
    if (!_showArray) {
        self.showArray = [[NSMutableArray alloc] init];
    }
    return _showArray;
}
- (NSMutableArray *)touristArray
{
    if (!_touristArray) {
        self.touristArray = [[NSMutableArray alloc] init];
    }
    return _touristArray;
}
- (NSMutableArray *)studentArray
{
    if (!_studentArray) {
        self.studentArray = [[NSMutableArray alloc] init];
    }
    return _studentArray;
}
- (NSMutableArray *)familyArray
{
    if (!_familyArray) {
        self.familyArray = [[NSMutableArray alloc] init];
    }
    return _familyArray;
}
- (VOSegmentedControl *)segmentedControl
{
    if (!_segmentedControl) {
        self.segmentedControl = [[VOSegmentedControl alloc] init];
    }
    return _segmentedControl;
}
@end
























