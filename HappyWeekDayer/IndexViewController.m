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
 广告
 */
@property (nonatomic, strong) NSMutableArray *themeArray;
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
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:96.0/255.0 green:185.0/255.0 blue:191.0/255.0 alpha:1.000];
    
    self.tableView.rowHeight = 203;
    /**
     注册CELL 96 185 191 // 98 288 288 
     */
    [self.tableView registerNib:[UINib nibWithNibName:@"IndexTableViewCell"bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self button];
//    [self requestModel];
    [self configTableViewHeaderView];
}
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight  [UIScreen mainScreen].bounds.size.height
- (void)configTableViewHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 343)];
    headerView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = headerView;
}
- (void)requestModel{
    NSString *URLString = @"http://e.kumi.cn/app/v1.3/index.php?_s_=02a411494fa910f5177d82a6b0a63788&_t_=1451307342&channelid=appstore&cityid=1&lat=34.62172291944134&limit=30&lng=112.4149512442411&page=1";
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManager GET:URLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
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
        
        //推荐专题
        NSArray *adDataArray = dic[@"adData"];
        for (NSDictionary *dict in adDataArray) {
            IndexModel *model = [IndexModel getDictionary:dict];
            [self.themeArray addObject:model];
        }
        [self.listArray addObject:self.themeArray];

//==============================================================================
        //推荐广告
        NSArray *rcDataArray = dic[@"rcData"];
        for (NSDictionary *dict in rcDataArray) {
            IndexModel *model = [IndexModel getDictionary:dict];
        }
        
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


//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    
//    
//    
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndexTableViewCell *indexCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return indexCell;
    
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end




























