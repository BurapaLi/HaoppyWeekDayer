//
//  ThemeViewController.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "ThemeViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "ThemeView.h"

@interface ThemeViewController ()
@property (nonatomic, strong) ThemeView *themeView;

@end

@implementation ThemeViewController
- (void)loadView{
    [super loadView];
    self.themeView = [[ThemeView alloc] initWithFrame:self.view.frame];
    self.view = self.themeView;
    [self getModel];
    self.tabBarController.tabBar.hidden = YES;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showBackButton];
}
- (void)getModel{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [sessionManager GET:[NSString stringWithFormat:@"%@&id=%@", kActicityTheme, self.themeid] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self make:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        fSLog(@"%@", error);
    }];
    
    
}
- (void)make:(NSDictionary *)responseObject{
//    NSLog(@"%@",responseObject);
    NSDictionary *dic = responseObject;
    NSString *status = dic[@"status"];
    NSInteger code = [dic[@"code"] integerValue];
    if ([status isEqualToString:@"success"] && code == 0) {
        
        self.themeView.dataDic = dic[@"success"];

    }else{
        
    }

    
}

@end
























