//
//  FriendViewController.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/5.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "FriendViewController.h"
#import "FriendCell.h"

@interface FriendViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,MJRefreshBaseViewDelegate>
{
    UITableView *_tableView;
    NSString *str;
    NSString *_time;
    MJRefreshHeaderView *header;
    MJRefreshFooterView *footer;
    NSInteger numOfTop;
    NSString *urlStr;//地址
    NSString*min_time;//刷新
    NSString*max_time;//加载
    NSString*category_id;
    NSString*level;//分组
}

@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation FriendViewController
-(void)dealloc {
    
    if (header) {
        [header free];
        
    }
    if (footer) {
        [footer free];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    urlStr = FRIEND;
    NSDate*dateNow=[NSDate date];
    NSString*nowTimeStr=[NSString stringWithFormat:@"%ld",(long)[dateNow timeIntervalSince1970]];
      NSString*timeStr=[NSString stringWithFormat:@"%ld",[nowTimeStr integerValue]-1000];
    min_time = nowTimeStr;
    max_time = timeStr;
    NSArray *arr = @[@"1",@"2",@"65"];
    category_id = arr[arc4random() % 3];
    NSArray * arr2 = @[@"6",@"5",@"4"];
    level = arr2[arc4random() % 3];
   
    [self createNavBar];
    [self createTableView];
    
    [self createRefreshView];
    [header beginRefreshing];
}

#pragma mark -- 建立刷新
-(void)createRefreshView
{
    header=[MJRefreshHeaderView header];
    header.delegate=self;
    header.scrollView=_tableView;
    footer=[MJRefreshFooterView footer];
    footer.delegate=self;
    footer.scrollView=_tableView;
}

#pragma mark --MJRefreshBaseViewDelegate
//刷新成功
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    
    if (refreshView==header) {
        NSArray*array=[urlStr componentsSeparatedByString:@"&max_time"];
        if (array.count>1) {
            urlStr = [NSString stringWithFormat:@"%@&min_time%@",[array firstObject],[array lastObject]];
        }
        _time=min_time;
        [self loadData:refreshView];
    }
    else{
        NSArray*array=[urlStr componentsSeparatedByString:@"&min_time"];
        if (array.count>1) {
            urlStr=[NSString stringWithFormat:@"%@&max_time%@",[array firstObject],[array lastObject]];
            
        }
        _time = max_time;
        [self loadData:refreshView];
    }
}

//刷新失败
-(void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView {
    
    if (refreshView==header) {
        if (self.dataArr.count==0) {
            NSLog(@"重新刷新");
            if (numOfTop==0) {
                [self performSelector:@selector(refreshClick) withObject:nil afterDelay:0.3];
                numOfTop++;
            }
        }
        else{
            numOfTop++;
        }
    }
}

-(void)refreshClick {
    
    [header beginRefreshing];
}

-(void)loadData:(MJRefreshBaseView*)refreshView{

    HttpRequestBlock*block;
    block=[[HttpRequestBlock alloc]initWithUrlPath:[NSString stringWithFormat:urlStr,category_id,level,_time] Block:^(BOOL isSucceed, HttpRequestBlock *http) {
        if (isSucceed) {
            if (refreshView == header) {
                self.dataArr = [NSMutableArray arrayWithCapacity:0];
            }
            
            NSDictionary *dict = http.dataDic[@"data"];
            min_time = [dict [@"min_time"] stringValue];
            max_time = [dict [@"max_time"] stringValue];
            NSArray *arr = dict[@"data"];
            
            if (arr.count) {
                for (int i = 0; i < arr.count; i++) {
                    
                    if ([arr[i] isKindOfClass:[NSDictionary class]]) {
                        HYModel *model = [[HYModel alloc] init];
                        [model setValuesForKeysWithDictionary:arr[i]];
                        [self.dataArr addObject:model];
                        
                        NSDictionary *dict = arr[i][@"group"];
                        HYGroupModel *groupModel = [[HYGroupModel alloc] init];
                        [groupModel setValuesForKeysWithDictionary:dict];
                        model.group = (NSDictionary *)groupModel;
                        groupModel.share_url = dict[@"share_url"];
                        NSDictionary *dict1 = dict[@"user"];
                        HYGroupUserModel *userModel = [[HYGroupUserModel alloc] init];
                        [userModel setValuesForKeysWithDictionary:dict1];
                        groupModel.user = userModel;
                        
                        userModel.name = dict1[@"name"];
                        userModel.avatar_url = dict1[@"avatar_url"];
                    }
                }
            }
            
            [_tableView reloadData];
            [refreshView endRefreshing];
        }
    }];
}

-(void)createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UILabel *view1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, WIDTH - 40, 30)];
    view1.backgroundColor = COLOR;
    view1.textColor = [UIColor orangeColor];
    view1.text = @"附近1000米内好友";
    view1.textAlignment = NSTextAlignmentCenter;
    _tableView.tableHeaderView = view1;
    
    [self.view addSubview:_tableView];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[FriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    HYModel*model=self.dataArr[indexPath.row];
    HYGroupModel*groupModel=(HYGroupModel*)model.group;
    [cell configModel:groupModel];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 80;
}


-(void)createNavBar {
    
    UIButton *btn = [ZCControl createButtonWithFrame:CGRectMake(0, 0, 44, 44) ImageName:@"leftBackButtonFGNormal" Target:self Action:@selector(btnClick) Title:nil];
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
    if (buttonIndex == 0 || buttonIndex == 1 || buttonIndex == 2) {
        [header beginRefreshing];
    }
    
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
