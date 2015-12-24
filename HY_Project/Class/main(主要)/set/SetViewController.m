//
//  SetViewController.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/5.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UILocalNotification*local;
    NSString *str;
}
@property (nonatomic,strong)NSArray *arr;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createNavBar];
    [self createTableView];
}

#pragma mark -- 建立推送
-(void)createNotifi {
    //xcode6多了一个方法才可以进行使用
    [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    
    NSDate*dateNow=[NSDate date];
    NSString*nowTimeStr=[NSString stringWithFormat:@"%ld",(long)[dateNow timeIntervalSince1970]];
    NSArray *arr1 = @[@"1",@"2",@"65"];
    NSArray *arr2 = @[@"6",@"5",@"4"];
    
    HttpRequestBlock*block;
    block=[[HttpRequestBlock alloc]initWithUrlPath:[NSString stringWithFormat:MAIN_URL,arr1[arc4random() % arr1.count],arr2[arc4random() % arr2.count],nowTimeStr] Block:^(BOOL isSucceed, HttpRequestBlock *http) {
        if (isSucceed) {
            
            NSDictionary *dict = http.dataDic[@"data"];
            
            NSString *tip = dict[@"tip"];
            
            local=[[UILocalNotification alloc]init];
            local.alertBody = tip;
            //设置什么时候显示推送
            local.fireDate=[NSDate dateWithTimeIntervalSinceNow:60*60*12];
            //设置推送的声音，这个推送的声音需要小于30秒，并且本地需要有这个声音文件
            local.soundName=@"音效.caf";
            //音效xcode时候需要真机才可以，模拟器无法出现
            //local.applicationIconBadgeNumber=30;
            //注册到系统中，本地推送最大好处就是程序就算被杀掉，依然能够执行
            [[UIApplication sharedApplication]scheduleLocalNotification:local];
        }
    }];
    
}

#pragma mark -- 界面设计
-(void)createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT - 124) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _arr = @[@"精彩段子推送",@"清除缓存",@"联系我们"];
    
    _tableView.tableFooterView = [[UIView alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"id"];
        
        switch (indexPath.row) {
//            case 0:
//            {
//                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH-110, 10, 100, 30)];
//                lab.text = @"当前版本1.0.0";
//                lab.font = [UIFont systemFontOfSize:10];
//                [cell.contentView addSubview:lab];
//                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//            }
//                break;
                
     
            case 0:
            {
                UISwitch *st = [[UISwitch alloc] initWithFrame:CGRectMake(WIDTH-65 , 10, 100, 50)];
                st.onTintColor = [UIColor greenColor];//开的颜色
                st.tintColor = [UIColor redColor];//关的颜色
                 st.on = YES;
                [st addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
                [cell.contentView addSubview:st];
                cell.accessoryType = UITableViewCellAccessoryNone;
                
            }
            
            default:
                break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _arr[indexPath.row];
    if (indexPath.row == 1) {
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row == 2) {
         cell.detailTextLabel.text = @"QQ:14108570741";
    }
    return cell;
}

-(void)switchValueChange:(UISwitch *)st {

    if (st.on == YES) {
        [self createNotifi];
    } else {
        //取消推送
        [self performSelector:@selector(cancelAllLocalNotificationsClick) withObject:nil afterDelay:2];
    }
}

#pragma mark -- 取消推送
-(void)cancelAllLocalNotificationsClick
{
    //首先先遍历推送
    NSArray*array=[[UIApplication sharedApplication]scheduledLocalNotifications];
    
    for (UILocalNotification*notification in array) {
        //对比提示文字
        if ([notification.alertBody isEqualToString:[NSString stringWithFormat:@"有新内容出现，注意查收！"]]) {
            //取消这个本地推送 该方法不能在加入后，马上进行取消
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
//        case 0:
//        {
//            [self createAlertWithTitle:@"当前是最新版本"];
//        }
            //break;
        case 1:
        {
            [MBProgressHUD showMessage:@"正在清除缓存内容..."];
            NSFileManager *fm = [NSFileManager defaultManager];
            [fm removeItemAtPath:[self filePathFromCache] error:nil];
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"清除完成"];
        }
            break;
        default:
            break;
    }
}

#pragma mark -- 清除缓存内容
-(NSString *)filePathFromCache {

    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"Library/Caches"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}



-(void)createAlertWithTitle:(NSString *)tiltle {
    
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:tiltle message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [al show];
}

-(void)createNavBar {
    
    UIButton *btn = [ZCControl createButtonWithFrame:CGRectMake(0, 0, 44, 44) ImageName:@"leftBackButtonFGNormal" Target:self Action:@selector(btnClick) Title:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(void)btnClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
