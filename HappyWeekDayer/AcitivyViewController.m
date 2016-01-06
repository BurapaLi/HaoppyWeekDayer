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

@interface AcitivyViewController ()

@end

@implementation AcitivyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"活动详情";
    [self showBackButton];
}

#pragma mark   ------ Custom Method
- (void)getModel{
    NSLog(@"!!!!!!@!#@#!@$#@#");
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [sessionManager GET:[NSString stringWithFormat:@"%@&id=%@", kActicityDetail, self.activityId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        fSLog(@"%@", error);
    }];
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













