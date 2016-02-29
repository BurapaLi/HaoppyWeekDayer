//
//  goodViewController.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "goodViewController.h"
#import "GoodTableViewCell.h"
#import "GoodModel.h"
#import "AcitivyViewController.h"

@interface goodViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    NSInteger _pagecount;
}
@property (nonatomic, strong) PullingRefreshTableView *tableView;
@property (nonatomic, assign) BOOL refreshing;
@property (nonatomic, strong) GoodTableViewCell *goodTableViewCell;
@property (nonatomic, strong) NSMutableArray *acArray;

@end

@implementation goodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"精选活动";
    self.tabBarController.tabBar.hidden = YES;
    
    [self.view addSubview:self.tableView];
    [self showBackButton];
    self.tableView.tableFooterView = [[UITableView alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView launchRefreshing];
}
- (void)loadData{
    
    [self getModel];
    
    [self.tableView tableViewDidFinishedLoading];
    self.tableView.reachedTheEnd = NO;
    
    self.tableView.rowHeight = 90;
    
}
- (NSMutableArray *)acArray
{
    if (!_acArray) {
        self.acArray = [[NSMutableArray alloc] init];
    }
    return _acArray;
}

//tableView下拉刷新开始的时候调用
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    
    self.refreshing = YES;
    _pagecount = 1;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
    
    
}
//上拉
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    self.refreshing = NO;
    _pagecount += 1;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
    
    
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

- (PullingRefreshTableView *)tableView{
    if (!_tableView) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:self.view.frame pullingDelegate:self];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return _tableView;
}


- (void)getModel{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    

    [sessionManager GET:[NSString stringWithFormat:@"%@&page=%ld", khuodong, _pagecount] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self make:responseObject];
        
        //////
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //////
        fSLog(@"%@", error);
    }];
}
- (void)make:(NSDictionary *)responseObject{
//        fSLog(@"%@",responseObject);
    NSDictionary *dic = responseObject;
    NSString *status = dic[@"status"];
    NSInteger code = [dic[@"code"] integerValue];
//    if ([status isEqualToString:@"success"] && code == 0) {
//        self.goodTableViewCell.dataDic = dic[@"success"];
//    }
    if (self.refreshing) {
        //下拉刷新的时候需要移除数组中的元素
        if (self.acArray.count > 0) {
            [self.acArray removeAllObjects];
        }
    }
    if ([status isEqualToString:@"success"] && code == 0) {
        NSDictionary *successDic = dic[@"success"];
        NSArray *array = successDic[@"acData"];
        for (NSDictionary *dic in array) {
            [self.acArray addObject:[[GoodModel alloc]initWithDicticionary:dic]];
        }
        //刷新tableView,他会重新执行tableView的所有代理方法
        [self.tableView reloadData];
    }
    [self.tableView tableViewDidFinishedLoading];
    self.tableView.reachedTheEnd = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.acArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.goodModel = self.acArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Index" bundle:nil];
    AcitivyViewController *activityDetailVC = [storyBoard instantiateViewControllerWithIdentifier:@"123"];
    GoodModel *goodModel = self.acArray[indexPath.row];
    activityDetailVC.activityId = goodModel.ID;
    [self.navigationController pushViewController:activityDetailVC animated:YES];
}

@end

























