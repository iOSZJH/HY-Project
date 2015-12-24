//
//  FindViewController.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/5.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "FriendViewController.h"

@interface FriendViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    UITableView *_tableView;
}

@property (nonatomic, strong)NSArray *titileArr;
@property (nonatomic, strong)NSArray *imageViewArr;

@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR;
    [self createNavBar];
    [self createTableView];
    
}
-(void)createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    cell.textLabel.text = @"1212121";
    return cell;
}


-(void)createNavBar {
    
    UIButton *btn = [ZCControl createButtonWithFrame:CGRectMake(0, 0, 44, 44) ImageName:@"closeicon_selecttype" Target:self Action:@selector(btnClick) Title:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIButton *btn2 = [ZCControl createButtonWithFrame:CGRectMake(0, 0, 44, 44) ImageName:nil Target:self Action:@selector(btn2Click) Title:@"筛选"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
}

-(void)btnClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)btn2Click {
    
    UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:@"筛选附近好友" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"全部",@"男",@"女",nil];
    sheet.tag=200;
    [sheet showInView:self.view];
}

#pragma mark -- UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 3) {
        return;
    }
    
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
