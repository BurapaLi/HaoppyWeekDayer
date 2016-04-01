//
//  OwerViewController.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "OwerViewController.h"
#import <MessageUI/MessageUI.h>
#import "ShareView.h"
#import "WeiboSDK.h"
#import "WXApi.h"


@interface OwerViewController ()<UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate,WeiboSDKDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) UIButton *headImageButton;
@property (nonatomic, strong) UILabel *nikeNameLabel;
@property (nonatomic, strong) ShareView *shareView;
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) UIView *chidrenView;


@end

@implementation OwerViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SDImageCache *cache = [SDImageCache sharedImageCache];
    NSInteger cacheSize = [cache getSize];
    NSString *cacheStr = [NSString stringWithFormat:@"清除图片缓存(%.02fM)", (double)cacheSize / 1024 / 1024];
    [self.titleArray replaceObjectAtIndex:0 withObject:cacheStr];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)login:(UIButton *)btn{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UINavigationController *nav = sb.instantiateInitialViewController;
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpTableViewHeaderView];
}
- (void)setUpTableViewHeaderView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 160)];
    headView.backgroundColor = RGBACOLOR(96, 185, 191, 1.0);
    [headView addSubview:self.headImageButton];
    [headView addSubview:self.nikeNameLabel];
    self.tableView.tableHeaderView = headView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellidentifier];
    }
   
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            //清除缓存
            SDImageCache *cache = [SDImageCache sharedImageCache];
            [cache clearDisk];
            [self.titleArray replaceObjectAtIndex:0 withObject:@"清除缓存"];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;
        case 1:
        {
            //发送邮件
            [self sendEmail];
        }
            break;
        case 2:
        {
            //检测新版本
            [ProgressHUD show:@"正在为你检测"];
            [self performSelector:@selector(checkAppVersion) withObject:nil afterDelay:2.0];
            
        }
            break;
        case 3:
        {
            //appStore评分
            NSString *str = [NSString stringWithFormat:
                             @"itms-apps://itunes.apple.com/1091500740.app"];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;
        case 4:
        {
            [self share];
            
        }
            break;
            
        default:
            break;
    }
}
- (void)share {
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    self.chidrenView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight - 300, kWidth, 300)];
    
    [UIView animateWithDuration:1.0 animations:^{

        [window addSubview:self.chidrenView];
        
        self.shareView = [ShareView addAnimateView];
        [self.shareView.weiboBtn addTarget:self action:@selector(ssoshareWeibo) forControlEvents:UIControlEventTouchUpInside];
        [self.shareView.friengBtn addTarget:self action:@selector(friengShare) forControlEvents:UIControlEventTouchUpInside];
        [self.shareView.circleBtn addTarget:self action:@selector(circleShare) forControlEvents:UIControlEventTouchUpInside];
        [self.shareView.removeBtn addTarget:self action:@selector(removeShare) forControlEvents:UIControlEventTouchUpInside];
        
        [self.chidrenView addSubview:self.shareView];
        
        /*
        //weibo
        UIButton *weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        weiboBtn.frame = CGRectMake(20, 40, 70, 70);
        [weiboBtn setImage:[UIImage imageNamed:@"share_weibo"] forState:UIControlStateNormal];
        [shareView addSubview:weiboBtn];
        
        
        //friend
        UIButton *friendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        friendBtn.frame = CGRectMake(130, 40, 70, 70);
        [friendBtn setImage:[UIImage imageNamed:@"share_friend"] forState:UIControlStateNormal];
        [shareView addSubview:friendBtn];
        
        //Circle
        UIButton *circleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        circleBtn.frame = CGRectMake(210, 40, 70, 70);
        [circleBtn setImage:[UIImage imageNamed:@"share_pengyouquan"] forState:UIControlStateNormal];
        [shareView addSubview:circleBtn];
        
        //remove
        UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        removeBtn.frame = CGRectMake(20, 100, kWidth - 40, 44);
        [removeBtn setTitle:@"取消" forState:UIControlStateNormal];
        [removeBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [shareView addSubview:removeBtn];
        */
        
    }];
    
    
}
- (void)ssoshareWeibo{
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kAppKey;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:nil];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}
- (WBMessageObject *)messageToShare{
    WBMessageObject *message = [WBMessageObject message];
    message.text = @"#分享#";
    
    return message;
}
/*
 [4] 如果你的程序要发消息给微信，那么需要调用WXApi的sendReq函数：
 -(BOOL) sendReq:(BaseReq*)req
 其中req参数为SendMessageToWXReq类型。
 需要注意的是，SendMessageToWXReq的scene成员，如果scene填WXSceneSession，那么消息会发送至微信的会话内。如果scene填WXSceneTimeline，那么消息会发送至朋友圈。如果scene填WXSceneFavorite,那么消息会发送到“我的收藏”中。scene默认值为WXSceneSession。
 */
- (void)friengShare{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = @"#分享#";
    req.bText = YES;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
    
}
- (void)circleShare{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = @"#分享#";
    req.bText = YES;
    req.scene = WXSceneFavorite;
    [WXApi sendReq:req];
    
}
/*
 
 - (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
 
 
 
 }
 //微信
 -(void)onReq:(BaseReq*)req
 
 
 }
 
 -(void) onResp:(BaseResp*)resp{
 
 
 }
 */
- (void)removeShare{
    [UIView animateWithDuration:1.0 animations:^{
        
    } completion:^(BOOL finished) {
        [self.chidrenView removeFromSuperview];
        [self.shareView removeFromSuperview];
    }];
    
}
- (void)checkAppVersion{
    [ProgressHUD showSuccess:@"已为最先版！"];
    
}
- (void)sendEmail{
    //初始化
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    //设置代理
    picker.mailComposeDelegate = self;
    //设置主题
    [picker setSubject:@"用户反馈"];
    //设置收件人
    NSArray *recive = [NSArray arrayWithObjects:@"1713396133@qq.com", nil];
    [picker setToRecipients:recive];
    //设置发送内容
    NSString *text = @"请留下您宝贵的意见";
    [picker setMessageBody:text isHTML:NO];
    //推出视图
    [self presentViewController:picker animated:YES completion:nil];
}
//邮件发送完成调用的方法
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    //关闭邮件发送窗口
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"用户取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"用户成功保存邮件";
            break;
        case MFMailComposeResultSent:
            msg = @"用户点击发送，将邮件放到队列中，还没发送";
            break;
        case MFMailComposeResultFailed:
            msg = @"用户试图保存或者发送邮件失败";
            break;
        default:
            msg = @"";
            break;
    }
}

- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        self.titleArray = [NSMutableArray arrayWithObjects:@"清除缓存",  @"用户反馈", @"当前版本1.0", @"给我评分", @"分享给朋友", nil];
    }
    return _titleArray;
}

- (UIButton *)headImageButton {
    if (_headImageButton == nil) {
        self.headImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headImageButton.frame = CGRectMake(20, 20, 130, 130);
        [self.headImageButton setTitle:@"登陆/注册" forState:UIControlStateNormal];
        [self.headImageButton setBackgroundColor:[UIColor whiteColor]];
        [self.headImageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.headImageButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        self.headImageButton.layer.cornerRadius = 65;
        self.headImageButton.clipsToBounds = YES;
    }
    return _headImageButton;
}

- (UILabel *)nikeNameLabel {
    if (_nikeNameLabel == nil) {
        self.nikeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 55, kWidth - 200, 60)];
        self.nikeNameLabel.numberOfLines = 0;
        self.nikeNameLabel.text = @"欢迎来到Happy Weekend";
        self.nikeNameLabel.textColor = [UIColor whiteColor];
    }
    return _nikeNameLabel;
}


@end








