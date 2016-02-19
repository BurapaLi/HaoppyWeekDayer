//
//  LoginViewController.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/15.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "LoginViewController.h"
#import <BmobSDK/Bmob.h>
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *AddData;
@property (weak, nonatomic) IBOutlet UIButton *QueryData;
@property (weak, nonatomic) IBOutlet UIButton *ModeifyData;
@property (weak, nonatomic) IBOutlet UIButton *deledeData;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBackButton];
}
- (IBAction)ModeifyData:(id)sender {
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"MemberUser"];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:@"4188158b36" block:^(BmobObject *object,NSError *error){
        //没有返回错误
        if (!error) {
            //对象存在
            if (object) {
                BmobObject *obj1 = [BmobObject objectWithoutDatatWithClassName:object.className objectId:object.objectId];
                //设置cheatMode为YES
//                [obj1 setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
                [obj1 setObject:@"北上海" forKey:@"user_Name"];
                //异步更新数据
                [obj1 updateInBackground];
            }
        }else{
            //进行错误处理
        }
    }];
}
- (IBAction)deledeData:(id)sender {
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"MemberUser"];
    [bquery getObjectInBackgroundWithId:@"4188158b36" block:^(BmobObject *object, NSError *error){
        if (error) {
            //进行错误处理
        }
        else{
            if (object) {
                //异步删除object
                [object deleteInBackground];
            }
        }
    }];
}
- (IBAction)QueryData:(id)sender {
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"MemberUser"];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:@"4188158b36" block:^(BmobObject *object,NSError *error){
        if (error){
            //进行错误处理
        }else{
            //表里有id为0c6db13c的数据
            if (object) {
                //得到playerName和cheatMode
                NSString *playerName = [object objectForKey:@"user_Name"];
                BOOL cheatMode = [object objectForKey:@"user_cellPhone"];
                NSLog(@"%@----%i",playerName,cheatMode);
            }
        }
    }];
    
}
- (IBAction)AddData:(id)sender {
    //往User表添加一条user_name，user_age,user
    BmobObject *user = [BmobObject objectWithClassName:@"MemberUser"];
    [user setObject:@"小明" forKey:@"user_Name"];
    [user setObject:@18 forKey:@"user_Age"];
    [user setObject:@"女" forKey:@"user_Gender"];
    [user setObject:@"18860255643" forKey:@"user_cellPhone"];
    [user setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
    [user saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
        NSLog(@"成功");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backButtonAction:(UIButton *)btn{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}


@end










