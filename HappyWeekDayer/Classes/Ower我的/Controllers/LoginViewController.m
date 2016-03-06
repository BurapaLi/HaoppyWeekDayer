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
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
/** 用户 */
@property (nonatomic, strong) BmobObject *userId;

@property (weak, nonatomic) IBOutlet UIButton *AddData;
@property (weak, nonatomic) IBOutlet UIButton *QueryData;
@property (weak, nonatomic) IBOutlet UIButton *ModeifyData;
@property (weak, nonatomic) IBOutlet UIButton *deledeData;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBackButtonWithImage:@"back"];
    
    
}

- (IBAction)loginBtn:(id)sender {
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUserName:@"小明"];
    [bUser setPassword:@"123456"];
    [bUser setObject:@18 forKey:@"age"];
    [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
            NSLog(@"Sign up successfully");
        } else {
            NSLog(@"%@",error);
        }
    }];
    
    }
//登录
- (void)testzc{
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"MemberUser"];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:@"MemberUser" block:^(BmobObject *object,NSError *error){
        if (error){
            //进行错误处理
        }else{
            //表里有id为0c6db13c的数据
            if (object) {
                //得到playerName和cheatMode
                NSString *playerName = [object objectForKey:@"playerName"];
                BOOL cheatMode = [[object objectForKey:@"cheatMode"] boolValue];
                NSLog(@"%@----%i",playerName,cheatMode);
                //打印objectId,createdAt,updatedAt
                NSLog(@"object.objectId = %@", [object objectId]);
                NSLog(@"object.createdAt = %@", [object createdAt]);
                NSLog(@"object.updatedAt = %@", [object updatedAt]);
            }
        }
    }];

}
//注册
- (void)testdl{
    
    //创表
    self.userId = [BmobObject objectWithClassName:@"MemberUser"];
    [self.userId setObject:self.userName.text forKey:@"user_Name"];
    [self.userId setObject:self.passWord.text forKey:@"user_passWord"];
    //异步保存到服务器
    [self.userId saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //创建成功后会返回objectId，updatedAt，createdAt等信息
            //创建对象成功，打印对象值
            NSLog(@"%@",self.userId);
        } else if (error){
            //发生错误后的动作
            NSLog(@"%@",error);
        } else {
            NSLog(@"Unknow error");
        }
    }];

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

//删除
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

//查询
- (IBAction)QueryData:(id)sender {
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"MemberUser"];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:@"6b908e5eb3" block:^(BmobObject *object,NSError *error){
        if (error){
            //进行错误处理
            fSLog(@"%@",error);
        }else{
            //表里有id为0c6db13c的数据
            if (object) {
                //得到playerName和cheatMode
                NSString *playerName = [object objectForKey:@"user_Name"];
                
                NSString *url = [object objectForKey:@"url"];
                fSLog(@"%@",url);
                
                NSString *cheatMode = [object objectForKey:@"user_cellPhone"];
                fSLog(@"%@----%@",playerName,cheatMode);
            }
        }
    }];
    
}

//添加
- (IBAction)AddData:(id)sender {
    //往User表添加一条user_name，user_age,user
    BmobObject *user = [BmobObject objectWithClassName:@"MemberUser"];
    [user setObject:@"小明" forKey:@"user_Name"];
    [user setObject:@18 forKey:@"user_Age"];
    [user setObject:@"女" forKey:@"user_Gender"];
    [user setObject:@"18860255643" forKey:@"user_cellPhone"];
    [user setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
    [user saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        NSLog(@"成功");
    }];
}
- (void)backButtonAction:(UIButton *)btn{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



@end










