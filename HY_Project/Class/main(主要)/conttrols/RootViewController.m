//
//  RootViewController.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/4.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "RootViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UMSocial.h"
//控制器
#import "DuanziViewController.h"
#import "PictureViewController.h"
#import "VideoViewController.h"
#import "PlayViewController.h"
//详情
#import "HYDelailsViewController.h"
#import "FindDelailsViewController.h"


@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,UIAlertViewDelegate>
{
    BOOL isTapAgain;//判断是否重复
    UIImageView *levelImageView;//弹出的提示框
    UILabel *titleLabel;
    NSInteger category;//选择
    UITableView*_tableView;
    NSString*_time;//时间戳
    NSInteger isLarge;//判断图片大小,isLarge == 0图片为大图
    //刷新
     MJRefreshHeaderView* header;
     MJRefreshFooterView* footer;
     NSInteger numOfTop;
    UIButton *btn;//显示刷新的消息
}

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation RootViewController

-(void)dealloc{
    if (header) {
        [header free];
        
    }
    if (footer) {
        [footer free];
    }
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroud2"]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent=NO;
    [self addLeftBarButton];
    [self addTitleView];
    [self addRightBarButton];
    [self createTableView];
    
    //显示信息条数
    btn = [ZCControl createButtonWithFrame:CGRectZero ImageName:nil Target:self Action:nil Title:nil];
    btn.alpha = 0.5;
    [self.view addSubview:btn];
    
   NSArray *arr1 = @[@"1",@"6"];
   NSArray *arr2 = @[@"2",@"3",@"7",@"69",@"12",@"15",@"62",@"8",@"9",@"47",@"51",@"46",@"10",@"39",@"58",@"45",@"32",@"25",@"26",@"49",@"16",@"19",@"33",@"35",@"53",@"50",@"56",@"34",@"52",@"60",@"28",@"48",@"27",@"31",@"36"];//图片
    NSArray *arr3 = @[@"18",@"65"];//视频
    
    for (NSString *str in arr1) {//段子
        if ([_category_id isEqualToString:str]) {
            category = 1;
            break;
        }
    }
    
    for (NSString *str in arr2) {//图片
        if ([_category_id isEqualToString:str]) {
            category = 2;
            break;
        }
    }
    
    for (NSString *str in arr3) {//视
        if ([_category_id isEqualToString:str]) {
            category = 3;
            break;
        }
    }
    
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
    //再次刷新成功，原来的btn就消失
    [btn removeFromSuperview];
    
    if (refreshView==header) {
        NSArray*array=[self.urlStr componentsSeparatedByString:@"&max_time"];
        if (array.count>1) {
            self.urlStr=[NSString stringWithFormat:@"%@&min_time%@",[array firstObject],[array lastObject]];
            
        }
        _time=self.min_time;
        [self loadData:refreshView];
    }
    else{
        NSArray*array=[self.urlStr componentsSeparatedByString:@"&min_time"];
        if (array.count>1) {
            self.urlStr = [NSString stringWithFormat:@"%@&max_time%@",[array firstObject],[array lastObject]];
            
        }
        _time=self.max_time;
        [self loadData:refreshView];
    }
}

//刷新失败
-(void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView {

    if (refreshView==header) {
        if (self.dataArray.count==0) {
            if (numOfTop==0) {
                [self performSelector:@selector(refreshClick) withObject:nil afterDelay:0.3];
                numOfTop++;
            }
            else if (numOfTop>0) {
                UIAlertView*al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"暂无更新,休息一会儿" delegate:self cancelButtonTitle:nil otherButtonTitles:@"返回", nil];
                [al show];
            }
        }
        else{
            numOfTop++;
        }
    }
}

-(void)refreshClick {

    [header beginRefreshing];//
}

#pragma mark -- UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [header beginRefreshing];
}

#pragma mark -- 请求数据
-(void)loadData:(MJRefreshBaseView*)refreshView
{
    HttpRequestBlock*block;
    block=[[HttpRequestBlock alloc]initWithUrlPath:[NSString stringWithFormat:self.urlStr,self.category_id,self.level,_time] Block:^(BOOL isSucceed, HttpRequestBlock *http) {
        if (isSucceed) {
            if (refreshView==header) {
                self.dataArray=[NSMutableArray arrayWithCapacity:0];
            }
            NSDictionary *dict = http.dataDic[@"data"];
            
            NSString *tip = dict[@"tip"];
            self.min_time = [dict [@"min_time"] stringValue];
            self.max_time = [dict [@"max_time"] stringValue];
            
            NSArray *arr = dict[@"data"];
            if (arr.count) {
                for (int i = 0; i < arr.count; i ++) {
                    if ([arr[i] isKindOfClass:[NSDictionary class]]) {
                        HYModel *model = [[HYModel alloc] init];
                        [model setValuesForKeysWithDictionary:arr[i]];
                        [self.dataArray addObject:model];
                        
                        //评论comments
                        NSArray *subArr = arr[i][@"comments"];
                        if (subArr.count) {
                            for (int j = 0; j < subArr.count; j++) {
                                if ([subArr[j] isKindOfClass:[NSDictionary class]]) {
                                    HYCommentModel *commentModel = [[HYCommentModel alloc] init];
                                    [commentModel setValuesForKeysWithDictionary:subArr[j]];
                                    [model.comments addObject:commentModel];//comments是数组
                                }
                            }
                        }
                        
                        //分组group
                        NSDictionary *dict1 = arr[i][@"group"];
                        if (category == 1 || category == 2) {
                            HYGroupModel *groupModel = [[HYGroupModel alloc] init];
                            [groupModel setValuesForKeysWithDictionary:dict1];
                            model.group = (NSDictionary *)groupModel;//group是字典
                            groupModel.content = dict1[@"content"];
                            groupModel.max_screen_width_percent = dict1[@"max_screen_width_percent"];
                            groupModel.min_screen_width_percent = dict1[@"min_screen_width_percent"];
                            
                            //group中的user
                            NSDictionary *dict2 = dict1[@"user"];
                            HYGroupUserModel *userModel = [[HYGroupUserModel alloc] init];
                            [userModel setValuesForKeysWithDictionary:dict2];
                            groupModel.user = userModel;
                            
                            //因为段子和图片的上面数据一样，只有图片数据不一样所以
                            if (category == 2) {
                                NSDictionary *dict3 = dict1[@"middle_image"];
                                NSDictionary *dict31 = dict1[@"large_image"];
                                PictureModel *picModel = [[PictureModel alloc] init];
                                PictureModel *picModel2 = [[PictureModel alloc] init];
                                picModel.height = dict3[@"height"];
                                picModel.width = dict3[@"width"];
                                picModel2.height = dict31[@"height"];
                                picModel2.width = dict31[@"width"];
                                [picModel setValuesForKeysWithDictionary:dict3];
                                [picModel2 setValuesForKeysWithDictionary:dict31];
                                groupModel.large_image = picModel2;
                                groupModel.middle_image = picModel;
                            }
                        }
                        else if (category == 3) {
                            VideoModel *videoModel = [[VideoModel alloc] init];
                            [videoModel setValuesForKeysWithDictionary:dict1];
                            model.group = (NSDictionary *)videoModel;
                            videoModel.mp4_url = dict1[@"mp4_url"];
                            videoModel._360p_video = dict1[@"360p_video"];
                            videoModel._480p_video = dict1[@"480p_video"];
                            videoModel._720p_video = dict1[@"720p_video"];
                            videoModel.medium_cover = dict1[@"medium_cover"];
                            videoModel.origin_video = dict1[@"origin_video"];
                            
                            //group中的user
                            NSDictionary *dict2 = dict1[@"user"];
                            HYGroupUserModel *userModel = [[HYGroupUserModel alloc] init];
                            [userModel setValuesForKeysWithDictionary:dict2];
                            videoModel.user = userModel;
                            
                        }
                    }
                }
            }

            [_tableView reloadData];
            [refreshView endRefreshing];
            
            //显示内容条数
            [self.view bringSubviewToFront:btn];
            btn = [ZCControl createButtonWithFrame:CGRectMake(0,0,WIDTH,25) ImageName:nil Target:self Action:@selector(btn1Click) Title:tip];
            btn.backgroundColor = [UIColor cyanColor];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [self.view addSubview:btn];
            
            //NSLog(@"%@",_dataArray);
        }
    }];
}

-(void)btn1Click {

    btn.frame = CGRectZero;
}

#pragma mark -- 表视图
-(void)createTableView {

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self createHeaderView];
    [self.view addSubview:_tableView];
    
    
}

-(void)createHeaderView {
    
    UIImageView *view1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    view1.backgroundColor = [UIColor whiteColor];
    view1.layer.cornerRadius = 10;
    view1.layer.borderColor = [[UIColor orangeColor]CGColor];
    view1.layer.borderWidth = 3;
    
    UIImageView *imageView = [ZCControl createImageViewWithFrame:CGRectMake(10, 10, 60, 60) ImageName:self.imageStr];
    imageView.layer.cornerRadius = 8;
    imageView.layer.masksToBounds = YES;
    [view1 addSubview:imageView];
    view1.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *nameLabel = [ZCControl createLabelWithFrame:CGRectMake(100, 10, 200, 30) Font:0 Text:self.titleStr];
    nameLabel.font = [UIFont boldSystemFontOfSize:18];
    nameLabel.textColor = [UIColor orangeColor];
    [view1 addSubview:nameLabel];
    
    UILabel *desLabel = [ZCControl createLabelWithFrame:CGRectMake(100, 40, 200, 40) Font:13 Text:self.desStr];
    desLabel.textColor = [UIColor redColor];
    [view1 addSubview:desLabel];
    
    if (self.numOfVeiw == 2) {
        desLabel.numberOfLines = 0;
        
        _tableView.tableHeaderView = view1;
    }
}

#pragma mark--UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (category==1) {
        DuanziCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ID"];
        if (!cell) {
            cell=[[DuanziCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
            CustomView*custView=(CustomView*)[cell.contentView viewWithTag:500];
            for (int i=0; i<2; i++) {
                UIControl*control=(UIControl*)[custView viewWithTag:1000+i];
                [control addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        cell.contentView.tag=indexPath.row;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        HYModel*model=self.dataArray[indexPath.row];
        HYGroupModel*groupModel=(HYGroupModel*)model.group;
        cell.isDetails=NO;
        [cell configModel:groupModel];
        
        return cell;
        
    } else if (category == 2) {
        PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
        if (!cell) {
            cell = [[PictureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
            CustomView*custView=(CustomView*)[cell.contentView viewWithTag:600];
            for (int i=0; i<2; i++) {
                UIControl*control=(UIControl*)[custView viewWithTag:1000+i];
                [control addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        cell.contentView.tag = indexPath.row;
        cell.i = 0;
        HYModel*model=self.dataArray[indexPath.row];
        HYGroupModel*groupModel=(HYGroupModel*)model.group;
        cell.isDetails=NO;
        [cell configModel:groupModel];
        
        return cell;
        
    }else if (category == 3) {
    
        VideowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
        if (!cell) {
            cell = [[VideowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
            CustomView*custView=(CustomView*)[cell.contentView viewWithTag:700];
            for (int i=0; i<2; i++) {
                UIControl*control=(UIControl*)[custView viewWithTag:1000+i];
                [control addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            UIButton *sbtn = (UIButton *)[cell.contentView viewWithTag:2000];
            [sbtn addTarget:self action:@selector(buttonClick2:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        cell.contentView.tag=indexPath.row;
        HYModel*model=self.dataArray[indexPath.row];
        VideoModel*vioModel=(VideoModel*)model.group;
        cell.isDetails=NO;
        [cell configModel:vioModel];
        return cell;
    }
    return nil;
}

-(void)buttonClick2:(UIButton*)button{
    UIView*contentView=button.superview.superview;
    HYModel *model = self.dataArray[contentView.tag];
    VideoModel *vModel = (VideoModel *)model.group;
    PlayViewController *vc = [[PlayViewController alloc] initWithContentURL:[NSURL URLWithString:vModel.mp4_url]];
    [vc.moviePlayer prepareToPlay];
    [vc.moviePlayer play];
    [self presentViewController:vc animated:YES completion:nil];
    
}


-(void)controlClick:(UIControl *)control {
//要判断
    NSInteger row = control.tag - 1000;
    UIView*contentView=control.superview.superview;
    NSInteger cellRow = contentView.tag;
    if (row == 1) {
        
        HYModel *model = self.dataArray[cellRow];
        HYGroupModel *groupModel = (HYGroupModel *)model.group;
        PictureModel *pictModel = groupModel.middle_image;
        
        if (category == 1) {
            [UMSocialSnsService presentSnsIconSheetView:self appKey:APPKEY shareText:[NSString stringWithFormat:@"来自应用“掌上笑逗”:\n%@",groupModel.content] shareImage:nil shareToSnsNames:@[UMShareToSina] delegate:nil];
        }
        
        else if (category == 2) {
        
            NSArray * arr = pictModel.url_list;
            NSString *str = arr[1][@"url"];
            NSData*data=[NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
            UIImage*TPImage=[UIImage imageWithData:data];
            [UMSocialSnsService presentSnsIconSheetView:self appKey:APPKEY shareText:[NSString stringWithFormat:@"来自应用“掌上笑逗”:\n  %@",groupModel.content] shareImage:TPImage shareToSnsNames:@[UMShareToSina] delegate:nil ];
        }
        else {
        
            VideoModel *vmodel = (VideoModel *)model.group;
            NSDictionary *dict = vmodel.large_cover;
            NSArray *arr2 = dict[@"url_list"];
            NSString *str2 = arr2[0][@"url"];
            NSData*data=[NSData dataWithContentsOfURL:[NSURL URLWithString:str2]];
            UIImage*TPImage=[UIImage imageWithData:data];
            [UMSocialSnsService presentSnsIconSheetView:self appKey:APPKEY shareText:[NSString stringWithFormat:@"来自应用“掌上笑逗” : \n %@\n%@",vmodel.content,vmodel.mp4_url] shareImage:TPImage shareToSnsNames:@[UMShareToSina] delegate:nil ];
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //点击cell时消失
    [UIView animateWithDuration:0.3 animations:^{
        levelImageView.frame=CGRectMake(WIDTH/2, 0, 0, 0);
        for (int i=0; i<4; i++) {
            UIButton*button=(UIButton*)[self.view viewWithTag:200+i];
            [button removeFromSuperview];
        }
        isTapAgain=NO;
    }];

    HYModel *model = self.dataArray[indexPath.row];
    
    if (self.numOfVeiw == 1) {
        if (category == 1 || category == 2) {
            HYGroupModel *gruopModel = (HYGroupModel *)model.group;
            HYDelailsViewController *vc = [[HYDelailsViewController alloc] init];
            vc.UrlStr = DETAILS_URL;
            vc.group_id = [gruopModel.group_id stringValue];
            vc.category = category;
            vc.model = gruopModel;
            vc.numComments = gruopModel.comment_count;
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if (category == 3) {
            VideoModel *vModel = (VideoModel *)model.group;
            HYDelailsViewController *vc = [[HYDelailsViewController alloc]init];
            vc.category=category;
            vc.UrlStr = DETAILS_URL;
            vc.vModel = vModel;
            vc.numComments=vModel.comment_count;
            vc.group_id=[vModel.group_id stringValue];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (self.numOfVeiw == 2) {
    
        HYGroupModel *groupModel = (HYGroupModel *)model.group;
        FindDelailsViewController *vc = [[FindDelailsViewController alloc] init];
        vc.UrlStr = DETAILS_URL;
        vc.category = category;
        vc.group_id = [groupModel.group_id stringValue];
        vc.model = groupModel;
        vc.numComments = groupModel.comment_count;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     HYModel* model= self.dataArray[indexPath.row];
    if (category == 1) {
        HYGroupModel * groupModel = (HYGroupModel *)model.group;
        CGRect rect = [groupModel.content boundingRectWithSize:CGSizeMake(220, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName] context:nil];
        
        return rect.size.height + 36 + 60;
    }
    else if (category == 2){
        HYGroupModel * groupModel = (HYGroupModel *)model.group;
        PictureModel *pictureModel = groupModel.middle_image;
        
        CGRect rect = [groupModel.content boundingRectWithSize:CGSizeMake(220, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName] context:nil];
        
        CGFloat height = [pictureModel.height floatValue];
        CGFloat width = [pictureModel.width floatValue];
        CGFloat num = [groupModel.max_screen_width_percent floatValue];
        if (width > WIDTH) {
            width = width*num;
        }
        return height + 92+rect.size.height;
    }
    else if (category == 3){
        VideoModel *videoModel = (VideoModel *)model.group;
        NSDictionary*dict=videoModel.origin_video;
        
        CGRect rect = [videoModel.content boundingRectWithSize:CGSizeMake(220, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName] context:nil];
        CGFloat height = [dict[@"height"] floatValue];
        CGFloat width = [dict[@"width"] floatValue];
        CGFloat num = 0;
        if (width > WIDTH) {
            num = (WIDTH-10)/width;
            height = height * num;
            width = WIDTH - 10;
        }
        if (height >= 400) {
            return 400 + 80 + rect.size.height;
        }else {
        
            return height + 80 + rect.size.height;
        }
    }
    return 200;
}

#pragma mark -- 创建左Item
-(void)addLeftBarButton {

    if (self.numOfVeiw == 1) {
        UIButton *leftButton = [ZCControl createButtonWithFrame:CGRectMake(0, 0, 40, 40) ImageName:@"menu_ico_home@2x" Target:self Action:@selector(leftBtnClick) Title:nil];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    }
    else if (self.numOfVeiw == 2) {
        UIButton *leftButton = [ZCControl createButtonWithFrame:CGRectMake(0, 0, 40, 40) ImageName:@"leftBackButtonFGNormal" Target:self Action:@selector(leftBtnClick) Title:nil];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    }
    
}

-(void)leftBtnClick {
    if (self.numOfVeiw == 1) {
        SliderViewController *slider =[SliderViewController sharedSliderController];
        [slider showLeftViewController];
    }
    else if (self.numOfVeiw == 2) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark -- 头标题
-(void)addTitleView {
    
    UIImageView *titleImageView = [ZCControl createImageViewWithFrame:CGRectMake(WIDTH/2-40, 4, 80, 36) ImageName:nil];
    self.navigationItem.titleView = titleImageView;
    titleImageView.userInteractionEnabled = YES;
    //标题
    titleLabel = [ZCControl createLabelWithFrame:CGRectMake(0, 0, 50, 36) Font:18 Text:@"推荐"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [titleImageView addSubview:titleLabel];
    
    //上下按钮
    UIImageView *imageView1 = [ZCControl createImageViewWithFrame:CGRectMake(50, 10, 20, 20)ImageName:@"downarrow_titlebar_night"];
    [titleImageView addSubview:imageView1];
    
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick)];
    [titleImageView addGestureRecognizer:tap];
    
    isTapAgain = NO;
    
    levelImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tipsbar_review_night@3x"]];
    levelImageView.userInteractionEnabled = YES;
    levelImageView.frame = CGRectMake(WIDTH/2, 0, 0, 0);
    [self.view addSubview:levelImageView];
}

-(void)imageViewClick {
    btn.frame = CGRectZero;
    [self.view bringSubviewToFront:levelImageView];
    if (isTapAgain == NO) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            levelImageView.frame = CGRectMake(WIDTH/2-70, 0, 150, 140);
            isTapAgain = YES;
            
        }completion:^(BOOL finished) {
            
            NSArray*titleArray=@[@"推荐",@"精华",@"热门",@"新鲜"];
            NSArray*selectArray=@[@"favorite_content_select_press.png",@"essenceicon_dock_press.png",@"hoticon_dock_press.png",@"newicon_dock_press.png"];
            NSArray*unSelectArray=@[@"favorite_content_night.png",@"essenceicon_dock_night.png",@"hoticon_dock_night.png",@"newicon_dock_night.png"];
            for (int i=0; i<4; i++) {
                UIButton*buton= [ZCControl createButtonWithFrame:CGRectMake(20, 20+30*i, 110, 30) ImageName:nil Target:self Action:@selector(btnClick:) Title:titleArray[i]];
                buton.tag=200+i;
                [buton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                buton.titleLabel.font = [UIFont systemFontOfSize:13];
                UIImage*selectImage=[UIImage imageNamed:selectArray[i]];
                selectImage=[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                UIImage*unSelectImage=[UIImage imageNamed:unSelectArray[i]];
                unSelectImage=[unSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                [buton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
                [buton setImage:unSelectImage forState:UIControlStateNormal];
                [buton setImage:selectImage forState:UIControlStateHighlighted];
                [levelImageView addSubview:buton];
            }
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            levelImageView.frame=CGRectMake(WIDTH/2, 0, 0, 0);
            for (int i=0; i<4; i++) {
                UIButton*button=(UIButton*)[self.view viewWithTag:200+i];
                [button removeFromSuperview];
            }
            isTapAgain=NO;
        }];
    }
}

-(void)btnClick:(UIButton *)button {
    
    NSArray*titleArray=@[@"推荐",@"精华",@"热门",@"新鲜"];
    titleLabel.text = titleArray[button.tag-200];
    titleLabel.textColor = [UIColor whiteColor];
    NSString *levelID = [NSString stringWithFormat:@"%ld",6-(button.tag-200)];
    self.level = levelID;
    numOfTop = 0;
    [header beginRefreshing];
    
    //点击btn时收回图像
    [UIView animateWithDuration:0.3 animations:^{
        levelImageView.frame=CGRectMake(WIDTH/2, 0, 0, 0);
        for (int i=0; i<4; i++) {
            UIButton*button=(UIButton*)[self.view viewWithTag:200+i];
            [button removeFromSuperview];
        }
        isTapAgain=NO;
    }];
}

#pragma mark - 右Item刷新按钮

-(void)addRightBarButton {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH-45, HEIGHT-100-45, 36, 36)];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.image = [UIImage imageNamed:@"refresh_night"];
    imageView.layer.masksToBounds = YES;
    imageView.userInteractionEnabled = YES;
    imageView.layer.cornerRadius = 18;
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageView2Click:)];
    [imageView addGestureRecognizer:tap];
    [self.view addSubview:imageView];
    //实现view随时想加就加上去
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageView];
}

-(void)imageView2Click:(UITapGestureRecognizer *)tap {
    
    CAAnimationGroup *group =[RootViewController createAnimationGroup];
    [tap.view.layer addAnimation:group forKey:@"group"];
    
    [UIView animateWithDuration:0.5 animations:^{
        [header beginRefreshing];
    }];
}

/**刷新按钮动画*/
+(CAAnimationGroup *)createAnimationGroup{
    //创建一个动画 ,按照z轴旋转
    CABasicAnimation *basic1 =[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置转圈个数
    basic1.toValue = [NSNumber numberWithFloat:M_PI*2*2];
    //设置是否重复
    basic1.autoreverses = NO;
    //设置重复次数
    basic1.repeatCount = 2;
    CAAnimationGroup *group = [CAAnimationGroup animation];
    //设置一组动画执行的时间
    group.duration = 2;
    //group.autoreverses = YES;//是否返回
    group.animations = @[basic1];
    return group;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
