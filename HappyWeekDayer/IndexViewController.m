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
#import "SeletCityViewController.h"
#import "SearchViewController.h"
#import "AcitivyViewController.h"
#import "ThemeViewController.h"
#import "ClassFiyViewController.h"
#import "goodViewController.h"
#import "hotViewController.h"

@interface IndexViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
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
@property (nonatomic, retain) UIScrollView   *scrollView;
@property (nonatomic, retain) UIPageControl  *pageControl;
@property (nonatomic, retain) NSTimer        *timer;
@property (nonatomic, strong) UIButton       *activityBtn;
@property (nonatomic, strong) UIButton       *themeBtn;

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
    /*
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:96.0/255.0 green:185.0/255.0 blue:191.0/255.0 alpha:1.000];
    
//    self.tableView.rowHeight = 203;
    */
    
     //注册CELL 96 185 191 // 98 288 288
    [self.tableView registerNib:[UINib nibWithNibName:@"IndexTableViewCell"bundle:nil] forCellReuseIdentifier:@"cell"];
    [self button];
    [self requestModel];
    [self configTableViewHeaderView];
    
}

#pragma mark    //滚图
- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 186)];
        self.scrollView.contentSize = CGSizeMake(self.adArray.count * kWidth, 186);
        
        self.scrollView.delegate = self;
        //整屏滑动
        self.scrollView.pagingEnabled = YES;
        //水平//滚动条showsVerticalScrollIndicator
        self.scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

#pragma mark    //page
- (UIPageControl *)pageControl{
    if (_pageControl == nil) {
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 186 - 30, kWidth, 30)];
        self.pageControl.pageIndicatorTintColor = [UIColor blackColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor cyanColor];
    }
    return _pageControl;
}
- (void)configTableViewHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 343)];
    self.tableView.tableHeaderView = headerView;
    //滚图
    for (int i = 0; i < self.adArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth * i, 0, kWidth, 186)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.adArray[i][@"url"]] placeholderImage:nil];
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
        UIButton *touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        touchBtn.frame = imageView.frame;
        touchBtn.tag = 100 + i;
        [touchBtn addTarget:self action:@selector(touchAdvertiseMent:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:touchBtn];
        
    }
    [headerView addSubview:self.scrollView];
    //page
    self.pageControl.numberOfPages = self.adArray.count;
    [headerView addSubview:self.pageControl];
    //4+2
    [self chidren:headerView];
    //时间控制器
    [self timerTo];

}
#pragma mark    //滚图按钮
- (void)touchAdvertiseMent:(UIButton *)adButton{
    //从数组中的字典里取出type类型
    NSString *type = self.adArray[adButton.tag - 100][@"type"];
    if ([type integerValue] == 1) {
//        AcitivyViewController *activityVC = [[AcitivyViewController alloc] init];
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Index" bundle:nil];
        AcitivyViewController *activityVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"123"];
        
        activityVC.activityId = self.adArray[adButton.tag - 100][@"id"];
        [self.navigationController pushViewController:activityVC animated:YES];
    } else {
        ThemeViewController *hotVC = [[ThemeViewController alloc] init];
        [self.navigationController pushViewController:hotVC animated:YES];
    }
}

- (void)timerTo{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(scrollViewAction) userInfo:nil repeats:YES];
}
- (void)scrollViewAction{
//    fSLog(@"%lu",self.adArray.count);
    NSInteger i = self.pageControl.currentPage;
    if (i == self.adArray.count - 1) {
        i = -1;
    }
    i++;
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = i * kWidth;
    [self.scrollView setContentOffset:offset animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.pageControl.currentPage = self.scrollView.contentOffset.x / kWidth;
}
//当用户拖拽scrollView的时候，移除定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate], self.timer = nil;
}
//当用户停止拖拽时，添加定时器
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    [self timerTo];
}
//切换视图时，移除定时器
- (void)viewWillDisappear:(BOOL)animated{
    [self.timer invalidate], self.timer = nil;
}

#pragma mark    //四个方框 == 下边两个方框
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
    //精选活动
    [headerView addSubview:self.activityBtn];
    //&推荐专题
    [headerView addSubview:self.themeBtn];
}

#pragma mark    //精选活动
- (UIButton *)activityBtn{
    if (_activityBtn == nil) {
        self.activityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.activityBtn.frame = CGRectMake(10, 186 + 157 / 2 + 10, kWidth / 2 - 10, 157 / 2 - 10);
        [self.activityBtn setImage:[UIImage imageNamed:@"home_huodong"] forState:UIControlStateNormal];
        self.activityBtn.tag = 104;
        [self.activityBtn addTarget:self action:@selector(goodActivityButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _activityBtn;
}

#pragma mark    //&推荐专题
- (UIButton *)themeBtn{
    if (_themeBtn == nil) {
        self.themeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.themeBtn.frame = CGRectMake(kWidth / 2, 186 + 157 / 2 + 10, kWidth / 2 - 10, 157 / 2 - 10);
        [self.themeBtn setImage:[UIImage imageNamed:@"home_zhuanti"] forState:UIControlStateNormal];
        self.themeBtn.tag = 105;
        [self.themeBtn addTarget:self action:@selector(goodActivityButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _themeBtn;
}

#pragma mark    //四个方框按钮方法
- (void)mainActivityButtonAction:(UIButton *)Btn{
    
    ClassFiyViewController *o = [[ClassFiyViewController alloc] init];
    [self.navigationController pushViewController:o animated:YES];
}
#pragma mark    //下边两个方框按钮方法
- (void)goodActivityButtonAction{
    
    goodViewController *o = [[goodViewController alloc] init];
    [self.navigationController pushViewController:o animated:YES];
}
- (void)hotActivityButtonAction{
    
    hotViewController *o = [[hotViewController alloc] init];
    [self.navigationController pushViewController:o animated:YES];
}

//======================================================================
//======================================================================
#pragma mark    //数据请求
- (void)requestModel{
    NSString *URLString = kIndexDataList;
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManager GET:URLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        fSLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        fSLog(@"%@",responseObject);
        [self make:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fSLog(@"%@",error);
    }];
    
}

#pragma mark    //解析数据
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
        for (NSDictionary *dic in adDataArray) {
//            [self.adArray addObject:dic[@"url"]];
            NSDictionary *dict = @{@"url" : dic[@"url"], @"type" : dic[@"type"], @"id" : dic[@"id"]};
            [self.adArray addObject:dict];
        }
        [self configTableViewHeaderView];
        
        NSString *cityName = dic[@"cityname"];
        /* 以请求回来的城市作为导航栏按钮标题 */
        self.navigationItem.leftBarButtonItem.title = cityName;
    }
}

#pragma mark    //导航栏按钮
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

#pragma mark    //导航栏按钮点击方法
- (void)selectCityBtn:(UIBarButtonItem *)barButton{
    SeletCityViewController *o = [[SeletCityViewController alloc] init];
    [self.navigationController presentViewController:o animated:YES completion:nil];
    
}
- (void)seacherActityBtn:(UIBarButtonItem *)barButton{
    SearchViewController *o = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:o animated:YES];
    
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
//    NSMutableArray *array = self.listArray[indexPath.section];
//    indexCell.model = array[indexPath.row];
    
    indexCell.model = self.listArray[indexPath.section][indexPath.row];
    return indexCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        AcitivyViewController *o = [[AcitivyViewController alloc] init];
        [self.navigationController pushViewController:o animated:YES];

    }else{
        ThemeViewController *o = [[ThemeViewController alloc] init];
        [self.navigationController pushViewController:o animated:YES];
    }
}


@end




























