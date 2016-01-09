//
//  AcitivyViewController.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "AcitivyViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "ActivityView.h"
#import "AppDelegate.h"

@interface AcitivyViewController ()
{
    NSString *number;
}
@property (strong, nonatomic) IBOutlet ActivityView *connectView;

@end

@implementation AcitivyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"活动详情";
    [self showBackButton];
    [self getModel];
    self.tabBarController.tabBar.hidden = YES;
    
    
    [self gogoo];
}
- (void)gogoo{
    //地图
    [self.connectView.mapButton addTarget:self action:@selector(mapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //打电话
    [self.connectView.makeCallButton addTarget:self action:@selector(makeCallButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)mapButtonAction:(UIButton *)button{
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://map.baidu.com"]];
    
}
- (void)makeCallButtonAction:(UIButton *)button{
    //程序外打电话，不返回
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]]];
    
    //程序内打电话，
    UIWebView *cell = [[UIWebView alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]]];
    [cell loadRequest:request];
    [self.view addSubview:cell];
}

#pragma mark   ------ Custom Method
- (void)getModel{
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [sessionManager GET:[NSString stringWithFormat:@"%@&id=%@", kActicityDetail, self.activityId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self make:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        fSLog(@"%@", error);
    }];
}

#pragma mark    //解析数据
- (void)make:(NSDictionary *)responseObject{
    NSDictionary *dic = responseObject;
    NSString *status = dic[@"status"];
    NSInteger code = [dic[@"code"] integerValue];
    if ([status isEqualToString:@"success"] && code == 0) {
        NSDictionary *successdic = dic[@"success"];
        self.connectView.dataDic = successdic;
        number = successdic[@"tel"];
    }else{
        
    }
}

@end













