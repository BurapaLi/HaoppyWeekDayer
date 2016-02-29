//
//  FindViewController.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "FindViewController.h"
#import "ImageTableViewCell.h"

@interface FindViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSMutableArray *likeArray;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.tableView];
//    self.tableView.transform = CGAffineTransformMakeRotation(- M_PI_2);
    self.tableView.frame = CGRectMake(0, 0, kWidth, kWidth / 3);
    self.tableView.rowHeight = kWidth / 3;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    [self loadData];
}
- (void)loadData {
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [ProgressHUD show:@"拼命加载中..."];
    [sessionManager GET:kfound parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self make:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:[NSString stringWithFormat:@"%@", error]];
        [ProgressHUD dismiss];
    }];
}

- (void)make:(NSDictionary *)responseObject{
    [ProgressHUD showSuccess:@"数据已为您加载完毕."];
    NSDictionary *dic = responseObject;
    NSString *status = dic[@"status"];
    NSInteger code = [dic[@"code"] integerValue];
    if ([status isEqualToString:@"success"] && code == 0) {
        NSDictionary *successDic = dic[@"success"];
        NSArray *likeArr = successDic[@"like"];
        //下拉刷新删除原来数据
        //            if (self.refreshing) {
        //                if (self.likeArray.count > 0) {
        //                    [self.likeArray removeAllObjects];
        //                }
        //            }
        for (NSDictionary *dict in likeArr) {
            DiscoverModel *model = [[DiscoverModel alloc] initWithDictionary:dict];
            [self.likeArray addObject:model];
        }
    }
    //完成加载
    //        [self.tableView tableViewDidFinishedLoading];
    //        self.tableView.reachedTheEnd = NO;
    //刷新tableView，他会重新执行tableView的所有代理方法
    [self.tableView reloadData];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] init];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor colorWithRed:arc4random() %256/255.0f green:arc4random() %256/255.0f blue:arc4random() %256/255.0f alpha:arc4random() %256/255.0f];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.likeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    fSLog(@"%@",cell.model.title);
    cell.model = self.likeArray[indexPath.row];
    
    
   
//    cell.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    return cell;
    
}
@end




























