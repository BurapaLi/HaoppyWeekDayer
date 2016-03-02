//
//  RegisterViewController.m
//  HappyWeekDayer
//
//  Created by scjy on 16/3/2.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "RegisterViewController.h"
#import <BmobSDK/Bmob.h>
#import "OwerViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPassWord;
@property (weak, nonatomic) IBOutlet UITextField *userAgainPassWord;
@property (weak, nonatomic) IBOutlet UISwitch *SwitchOn;
@property (weak, nonatomic) IBOutlet UIButton *login;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    }
- (IBAction)SwitchOn:(id)sender {
    
    
}
- (IBAction)login:(id)sender {
    BmobUser *bUser = [[BmobUser alloc] init];
    bUser.username = self.userName.text;
    bUser.password = self.userPassWord.text;
    [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
            NSLog(@"Sign up successfully");
        } else {
            NSLog(@"%@",error);
        }
    }];
    UIStoryboard *ower = [UIStoryboard storyboardWithName:@"Ower" bundle:nil];
    OwerViewController *owerVc = ower.instantiateInitialViewController;
    [self presentViewController:owerVc animated:YES completion:nil];

    
}


@end
