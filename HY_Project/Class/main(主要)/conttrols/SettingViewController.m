//
//  SettingViewController.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/4.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "SettingViewController.h"
#import "HYNavigationController.h"
#import "UMFeedbackViewController.h"

#import "FriendViewController.h"
#import "FindViewController.h"
#import "FeedBackViewController.h"
#import "AboutViewController.h"
#import "SetViewController.h"
#import "ViewController1.h"
#import "UCViewController.h"


@interface SettingViewController () <UITableViewDataSource,UITableViewDelegate>
{
    //上面一半的图片
    UIImageView*bgImageView;
    //用户头像
    UIImageView*headerImageView;
    //用户昵称
    UILabel*nickLabel;
    //用户签名
    UILabel*qmdLabel;
    UITableView*_tableView;
    NSInteger num;
    UIButton *logoBtn;
    UIButton *cancelBtn;
    BOOL isLogo;
    UMSocialAccountEntity *snsAccount;
}

@property(nonatomic,strong)NSArray*titleArray;
@property(nonatomic,strong)NSArray*imageNameArray;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

-(void)createUI {
    num = 0;

    bgImageView = [ZCControl createImageViewWithFrame:CGRectMake(0, 0, WIDTH, 200) ImageName:nil];
    
    bgImageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];
    
    //头像
    headerImageView = [ZCControl createImageViewWithFrame:CGRectMake(40, bgImageView.frame.size.height-150, 60, 60) ImageName:@"big_defaulthead_head"];
    headerImageView.layer.cornerRadius = 30;
    headerImageView.layer.masksToBounds = YES;
    headerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerClick:)];
    [headerImageView addGestureRecognizer:tap];
    
    [bgImageView addSubview:headerImageView];
    
    //昵称
    nickLabel = [ZCControl createLabelWithFrame:CGRectMake(130, bgImageView.frame.size.height-125, 180, 30) Font:17 Text:@"昵称"];
    nickLabel.textColor = [UIColor whiteColor];
    [bgImageView addSubview:nickLabel];
    
    //登陆按钮
 
    logoBtn = [ZCControl createButtonWithFrame:CGRectMake(30, bgImageView.frame.size.height-50, 60, 30) ImageName:nil Target:self Action:@selector(btnClick) Title:nil];
    logoBtn.layer.borderWidth = 2;
    logoBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    logoBtn.layer.cornerRadius = 8;
    [logoBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    logoBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    logoBtn.enabled = YES;
    [logoBtn setTitle:@"登录" forState:UIControlStateNormal];
    [bgImageView addSubview:logoBtn];
    
    cancelBtn = [ZCControl createButtonWithFrame:CGRectMake(130, logoBtn.frame.origin.y, 60, 30) ImageName:nil Target:self Action:@selector(btn2Click) Title:@"注销"];
    cancelBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cancelBtn.layer.borderWidth = 2;
    cancelBtn.layer.cornerRadius = 8;
    [cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [bgImageView addSubview:cancelBtn];
    
    [self.view addSubview:bgImageView];
    
    
    //下部分TableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 230, 300, HEIGHT-170) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] init];
    
    self.titleArray = @[@"附近涵友",@"我的发现",@"用户反馈",@"关于我们",@"应用设置",@"笑逗浏览器"];
    self.imageNameArray = @[@"附近涵友",@"我的收藏",@"用户反馈",@"关于我们",@"应用设置",@"浏览器"];
}

-(void)headerClick:(UITapGestureRecognizer *)tap {

    ViewController1 *vc = [[ViewController1 alloc] init];
    vc.url = snsAccount.profileURL;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)btn2Click {

    nickLabel.text = @"昵称";
    headerImageView.image = [UIImage imageNamed:@"big_defaulthead_head"];
    logoBtn.enabled =  YES;
}

-(void)btnClick {

    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].loginClickHandler(self,([UMSocialControllerService defaultControllerService]),YES,^(UMSocialResponseEntity*response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            nickLabel.text = snsAccount.userName;
            [headerImageView sd_setImageWithURL:[NSURL URLWithString:snsAccount.iconURL]];
            
            if (nickLabel.text) {
                logoBtn.enabled = NO;
            }
            else {
            
                logoBtn.enabled = YES;
            }
        }
    });
}

#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        //cell.backgroundColor = [UIColor grayColor];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.imageNameArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.row) {
            
        case 0:
        {
            FriendViewController *vc = [[FriendViewController alloc] init];
            HYNavigationController *nvc = [[HYNavigationController alloc] initWithRootViewController:vc];
            vc.title = @"附近涵友";
            [self presentViewController:nvc animated:YES completion:nil];
        }
            
            break;
        case 1:
        {
            FindViewController *vc = [[FindViewController alloc] init];
            HYNavigationController *nvc = [[HYNavigationController alloc] initWithRootViewController:vc];
            vc.title = @"发现";
            [self presentViewController:nvc animated:YES completion:nil];
        }
            
            break;
        case 2:
        {
            [self showNativeFeedbackWithAppkey:APPKEY];
        }
            break;
        case 3:
        {
            AboutViewController *vc = [[AboutViewController alloc] init];
            HYNavigationController *nvc = [[HYNavigationController alloc] initWithRootViewController:vc];
            vc.title = @"关于我们";
            [self presentViewController:nvc animated:YES completion:nil];
        }
            break;
        case 4:
        {
            SetViewController *vc = [[SetViewController alloc] init];
            HYNavigationController *nvc = [[HYNavigationController alloc] initWithRootViewController:vc];
            vc.title = @"应用设置";
            [self presentViewController:nvc animated:YES completion:nil];
        }
            break;
        case 5:
        {
            UCViewController *uc = [[UCViewController alloc] init];
            [self.navigationController pushViewController:uc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark 反馈
- (void)showNativeFeedbackWithAppkey:(NSString *)appkey {
    UMFeedbackViewController *feedbackViewController = [[UMFeedbackViewController alloc] initWithNibName:@"UMFeedbackViewController" bundle:nil];
    feedbackViewController.appkey = appkey;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    navigationController.navigationBar.barStyle = UIBarStyleBlack;
    navigationController.navigationBar.translucent = NO;
    [self presentModalViewController:navigationController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
