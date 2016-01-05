//
//  IndexViewController.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "IndexViewController.h"
#import "IndexTableViewCell.h"
//#import <AFNetworking/AFHTTPSessionManager.h>
#import <AFNetworking/AFHTTPSessionManager.h>
@interface IndexViewController ()<UITableViewDataSource,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation IndexViewController
#pragma mark    //559 203
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
    [self requestModel];
}
- (void)requestModel{
    NSString *URLString = @"http://e.kumi.cn/app/v1.3/index.php?_s_=02a411494fa910f5177d82a6b0a63788&_t_=1451307342&channelid=appstore&cityid=1&lat=34.62172291944134&limit=30&lng=112.4149512442411&page=1";
//    NSURL *url = [NSURL URLWithString:URLString];
//    NSMutableURLRequest *requst = [NSMutableURLRequest requestWithURL:url];
//    NSMutableURLRequest *requst = [NSMutableURLRequest ]
    
//    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
//    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:nil error:nil];
    
    /*
    //创建manager实例
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //给manager传入参数
    [manager GET:@"http://example.com/resources.json" parameters:nil       success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //处理返回的Object
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //处理失败
            NSLog(@"Error: %@", error);  }];
    //2.设置安全策略
    manager.securityPolicy.allowInvalidCertificates = YES;
    //AFHTTPRequestOperationManager的作用更多是管理Operation，实际的网络请求操作由AFHTTPRequestOperation来完成
     */
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManager GET:URLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
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




























