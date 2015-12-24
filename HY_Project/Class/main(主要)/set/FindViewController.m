//
//  FindViewController.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/5.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "FindViewController.h"
#import "FindCell.h"
#import "Find1ViewController.h"


@interface FindViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    UITableView *_tableView;
}

@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    [self createTableView];
    [self loadData];
    
}
-(void)loadData
{
    NSString*path=[[NSBundle mainBundle] pathForResource:@"FindPlist" ofType:@"plist"];
    NSArray*array=[NSArray arrayWithContentsOfFile:path];
    self.dataArr=[NSMutableArray arrayWithArray:array];
    [_tableView reloadData];
}

-(void)createTableView {
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain] ;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FindCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ID1"];
    if (!cell) {
        cell=[[FindCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID1"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray*array=self.dataArr[indexPath.row];
    [cell config:array];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDate*dateNow=[NSDate date];
    NSString*nowTimeStr=[NSString stringWithFormat:@"%ld",(long)[dateNow timeIntervalSince1970]];
    NSArray*array=@[@"69",@"7",@"6",@"3",@"62",@"12",@"15",@"8",@"9",@"47",@"51",@"46",@"10",@"39",@"58",@"45",@"32",@"25",@"26",@"49",@"16",@"19",@"33",@"35",@"53",@"50",@"56",@"34",@"52",@"60",@"28",@"48",@"27",@"31",@"36"];
    
    Find1ViewController *vc = [[Find1ViewController alloc] init];
    vc.urlStr = MAIN_URL;
    vc.level = @"6";
    vc.category_id = array[indexPath.row];
    vc.numOfVeiw = 2;
    vc.min_time = nowTimeStr;//@"1422155632";
    
    vc.imageStr = self.dataArr[indexPath.row][0];
    vc.titleStr = self.dataArr[indexPath.row][1];
    vc.desStr = self.dataArr[indexPath.row][2];
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


-(void)createNavBar {
    
    UIButton *btn = [ZCControl createButtonWithFrame:CGRectMake(0, 0, 44, 44) ImageName:@"leftBackButtonFGNormal" Target:self Action:@selector(btnClick) Title:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}


-(void)btnClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end