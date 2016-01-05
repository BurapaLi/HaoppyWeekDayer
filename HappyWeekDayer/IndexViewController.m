//
//  IndexViewController.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "IndexViewController.h"
#import "IndexTableViewCell.h"
#import "IndexModel.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface IndexViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 全部列表数据
 */
@property (nonatomic, strong) NSMutableArray *listArray;
/**
 活动
 */
@property (nonatomic, strong) NSMutableArray *activityAray;
/**
 专题
 */
@property (nonatomic, strong) NSMutableArray *themeArray;
/**
 广告
 */
@property (nonatomic, strong) NSMutableArray *adArray;
@end

@implementation IndexViewController
#pragma mark    //559 203

- (NSMutableArray *)listArray
{
    if (!_listArray) {
        self.listArray = [[NSMutableArray alloc] init];
    }
    return _listArray;
}
- (NSMutableArray *)activityAray
{
    if (!_activityAray) {
        self.activityAray = [[NSMutableArray alloc] init];
    }
    return _activityAray;
}
- (NSMutableArray *)themeArray
{
    if (!_themeArray) {
        self.themeArray = [[NSMutableArray alloc] init];
    }
    return _themeArray;
}
- (NSMutableArray *)adArray
{
    if (!_adArray) {
        self.adArray = [[NSMutableArray alloc] init];
    }
    return _adArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:96.0/255.0 green:185.0/255.0 blue:191.0/255.0 alpha:1.000];
    
//    self.tableView.rowHeight = 203;
    /**
     注册CELL 96 185 191 // 98 288 288 
     */
    [self.tableView registerNib:[UINib nibWithNibName:@"IndexTableViewCell"bundle:nil] forCellReuseIdentifier:@"cell"];
    [self button];
    [self requestModel];
    [self configTableViewHeaderView];
}
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight  [UIScreen mainScreen].bounds.size.height
- (void)configTableViewHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 343)];
    self.tableView.tableHeaderView = headerView;
    
    
    UIScrollView *carouseView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 186)];
    carouseView.contentSize = CGSizeMake(self.adArray.count * kWidth, 186);
    for (int i = 0; i < self.adArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth * i, 0, kWidth, 186)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.adArray[i]] placeholderImage:nil];
        [carouseView addSubview:imageView];
    }
    [headerView addSubview:carouseView];
    
    [self chidren:headerView];
    
}
- (void)chidren:(UIView *)headerView{
    
    //按钮
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * kWidth / 4 + 10, 196, kWidth / 4 * 2 / 3, 157 / 2 - 10);
        NSString *imageStr = [NSString stringWithFormat:@"home_icon_%d", i + 1];
        [btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(mainActivityButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:btn];
    }
    //精选活动&专门专题
    UIButton *activityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    activityBtn.frame = CGRectMake(10, 186 + 157 / 2 + 10, kWidth / 2 - 10, 157 / 2 - 10);
    [activityBtn setImage:[UIImage imageNamed:@"home_huodong"] forState:UIControlStateNormal];
    activityBtn.tag = 104;
    [activityBtn addTarget:self action:@selector(mainActivityButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:activityBtn];
    
    UIButton *themeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    themeBtn.frame = CGRectMake(kWidth / 2, 186 + 157 / 2 + 10, kWidth / 2 - 10, 157 / 2 - 10);
    [themeBtn setImage:[UIImage imageNamed:@"home_zhuanti"] forState:UIControlStateNormal];
    themeBtn.tag = 105;
    [themeBtn addTarget:self action:@selector(mainActivityButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:themeBtn];
    
}
- (void)mainActivityButtonAction:(UIButton *)Btn{
    
    
    
    
}
- (void)requestModel{
    NSString *URLString = @"http://e.kumi.cn/app/v1.3/index.php?_s_=02a411494fa910f5177d82a6b0a63788&_t_=1451307342&channelid=appstore&cityid=1&lat=34.62172291944134&limit=30&lng=112.4149512442411&page=1";
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManager GET:URLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        [self make:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)make:(NSDictionary *)responseObject{
    NSDictionary *resultDic = responseObject;
    NSString *ststus = resultDic[@"status"];
    NSInteger code = [resultDic[@"code"] integerValue];
    if ([ststus isEqualToString:@"success"] && code == 0) {
        NSDictionary *dic = resultDic[@"success"];
        //推荐活动
        NSArray *acDataArray = dic[@"acData"];
        for (NSDictionary *dict in acDataArray) {
            IndexModel *model = [IndexModel getDictionary:dict];
            [self.activityAray addObject:model];
        }
        [self.listArray addObject:self.activityAray];
        
        //推荐专题
        NSArray *rcDataArray = dic[@"rcData"];
        for (NSDictionary *dict in rcDataArray) {
            IndexModel *model = [IndexModel getDictionary:dict];
            [self.themeArray addObject:model];
        }
        [self.listArray addObject:self.themeArray];
        [self.tableView reloadData];
        
        //推荐广告
        NSArray *adDataArray = dic[@"adData"];
        for (NSDictionary *dict in adDataArray) {
            [self.adArray addObject:dict[@"url"]];
        }
        [self configTableViewHeaderView];
        
        NSString *cityName = dic[@"cityname"];
        /* 以请求回来的城市作为导航栏按钮标题 */
        self.navigationItem.leftBarButtonItem.title = cityName;
    }
}
- (void)button{
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"北京" style:UIBarButtonItemStylePlain target:self action:@selector(selectCityBtn:)];
    self.navigationItem.leftBarButtonItem = left;
    
//    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
//    right.frame = CGRectMake(0, 0, 14, 14);
//    [right setImage:[UIImage imageNamed:@"btn_search.png"] forState:UIControlStateNormal];
//    [right addTarget:self action:@selector(seacherActityBtn:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:right];
//    self.navigationItem.rightBarButtonItem = rightBtn;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(seacherActityBtn:)];
    self.navigationItem.rightBarButtonItem = right;
    
}

- (void)selectCityBtn:(UIBarButtonItem *)barButton{
    
    
}

- (void)seacherActityBtn:(UIBarButtonItem *)barButton{
    
    
}

#pragma mark    //自定义头部
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth / 2 - 160, 5, 320, 16)];
    if (section == 0) {
        imageview.image = [UIImage imageNamed:@"home_recommed_ac"];
    }else{
        imageview.image = [UIImage imageNamed:@"home_recommd_rc"];
    }
    [view addSubview:imageview];
    
    
    return view;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.activityAray.count;
    }
     return self.themeArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 203;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndexTableViewCell *indexCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSMutableArray *array = self.listArray[indexPath.section];
    indexCell.model = array[indexPath.row];
    return indexCell;
    
    
    
}



@end




























