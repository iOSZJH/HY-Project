//
//  HYDelailsViewController.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/11.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "HYDelailsViewController.h"
#import "ReportViewController.h"
#import "PlayViewController.h"

@interface HYDelailsViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    UITableView*_tableView;
    CGFloat hei;
    CGFloat hei1;
    CGFloat hei2;
    //上拉加载
    MJRefreshFooterView *footer;
    HttpRequestBlock *block;
    UIImageView *messegeImage;
    BOOL isTapAgain;
    //
    int num;
}
@property(nonatomic,strong)NSMutableArray*dataArray;

@end

@implementation HYDelailsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNavication];
    [self createView];
    [self createTableView];
    num = 0;
    [self loadData];
}


#pragma mark -- 加载数据
-(void)loadData{

    [MBProgressHUD showMessage:@"亲，正在加加载。。。。"];
    NSString *offset = [NSString stringWithFormat:@"%d",num];
    block = [[HttpRequestBlock alloc] initWithUrlPath:[NSString stringWithFormat:self.UrlStr,self.group_id,offset] Block:^(BOOL isSucceed, HttpRequestBlock *http) {
       
        if (isSucceed) {
            self.dataArray = [NSMutableArray arrayWithCapacity:0];
            NSDictionary *dict = http.dataDic[@"data"];
            NSArray *arr = dict[@"recent_comments"];
            for (NSDictionary *dict1 in arr) {
                HYCommentModel *model = [[HYCommentModel alloc] init];
                [model setValuesForKeysWithDictionary:dict1];
                [self.dataArray addObject:model];
            }
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"加载完成"];
            [_tableView reloadData];
        }
        else {
        
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"加载失败"];
        }
        
    }];
}

-(void)createView {

    //段子高度
    HYGroupUserModel *model=[[HYGroupUserModel alloc]init];
    model=self.model.user;
    CGRect rect1 = [self.model.content boundingRectWithSize:CGSizeMake(220, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName] context:nil];
    hei = rect1.size.height + 65;
    
    
    //图片高度
    PictureModel *pictureModel = self.model.large_image;
    CGRect rect2 = [self.model.content boundingRectWithSize:CGSizeMake(220, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName] context:nil];
    CGFloat height = [pictureModel.height floatValue];
    CGFloat width = [pictureModel.width floatValue];
    if (width > WIDTH) {
        width = width * [self.model.min_screen_width_percent floatValue];
        height = height *[self.model.max_screen_width_percent floatValue];
    }
    hei1 = rect2.size.height + height + 65;    
}

#pragma mark -- 创建表视图
-(void)createTableView {
    self.navigationController.navigationBar.translucent=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, -30, WIDTH, HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
}

#pragma --UITableViewDataSource 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 1) {
        HYCommentModel *model = self.dataArray[indexPath.row];
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
        if (!cell) {
            cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        }
        [cell configModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    else if (indexPath.section == 0) {
    
        if (self.category == 1) {
            DuanziCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DUANZI"];
            if (!cell) {
                cell = [[DuanziCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DUANZI"];
                CustomView*custView=(CustomView*)[cell.contentView viewWithTag:700];
                for (int i=0; i<2; i++) {
                    UIControl*control=(UIControl*)[custView viewWithTag:1000+i];
                    [control addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
                }

            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            HYGroupModel *model = self.model;
            cell.isDetails = YES;
            [cell configModel:model];
            return cell;
        }
        
        else if (self.category == 2) {
        
            PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PICTURE"];
            if (!cell) {
                cell = [[PictureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PICTURE"];
                CustomView*custView=(CustomView*)[cell.contentView viewWithTag:700];
                for (int i=0; i<2; i++) {
                    UIControl*control=(UIControl*)[custView viewWithTag:1000+i];
                    [control addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
                }

                
                UIButton *button = (UIButton *)[cell.contentView viewWithTag:3000];
                [button addTarget:self action:@selector(downClick) forControlEvents:UIControlEventTouchUpInside];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            HYGroupModel *model = self.model;
            cell.isDetails = YES;
            [cell configModel:model];
            return cell;
        }
        
        else if (self.category == 3) {
            
            VideowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VIDEO"];
            if (!cell) {
                cell = [[VideowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VIDEO"];
                CustomView*custView=(CustomView*)[cell.contentView viewWithTag:700];
                for (int i=0; i<2; i++) {
                    UIControl*control=(UIControl*)[custView viewWithTag:1000+i];
                    [control addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
                }
    
                UIButton *sbtn = (UIButton *)[cell.contentView viewWithTag:2000];
                [sbtn addTarget:self action:@selector(buttonClick2:) forControlEvents:UIControlEventTouchUpInside];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            VideoModel*Vmodel=self.vModel;
            [cell configModel:Vmodel];
            cell.isDetails= YES;
            return cell;
            }
        }
    return nil;
}

//开关点击事件
-(void)buttonClick2:(UIButton *)btn {

    VideoModel *vModel = self.vModel;
    NSLog(@"播放的视频为%@",vModel.mp4_url);
    PlayViewController *vc = [[PlayViewController alloc] initWithContentURL:[NSURL URLWithString:vModel.mp4_url]];
    [vc.moviePlayer prepareToPlay];
    [vc.moviePlayer play];
    [self presentViewController:vc animated:YES completion:nil];
}


-(void)controlClick:(UIControl *)control {
 
}


//下载按钮
-(void)downClick{
    
    UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:@"选择保存" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存到相册", nil];
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!buttonIndex) {
        HYGroupModel *model=self.model;
        PictureModel *photoModel = model.middle_image;
        NSString*str=photoModel.url_list[1][@"url"];
        //保存到相册
        UIImageView*tempImageView=[[UIImageView alloc]init];
        [tempImageView sd_setImageWithURL:[NSURL URLWithString:str]];
        UIImageWriteToSavedPhotosAlbum(tempImageView.image, nil, nil, nil);//存储本地
        
        UIAlertView*al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"图片已保存" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.category == 1) {
        
        if(indexPath.section == 0) {
        
            return hei;
        } else {
        
            return [self CommentCellHeight:indexPath.row];
        }
    }
    
    else if (self.category == 2) {
    
        if (indexPath.section == 0) {
            return hei1;
        } else {
        
            return [self CommentCellHeight:indexPath.row];
        }
    }
    
    else if (self.category == 3) {
    
        if (indexPath.section == 0) {
            
            VideoModel *model = self.vModel;
            NSDictionary *dict1 = model.origin_video;
            CGRect rect = [model.content boundingRectWithSize:CGSizeMake(220, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName] context:nil];
            CGFloat height = [dict1[@"height"] floatValue];
            CGFloat width = [dict1[@"width"] floatValue];
            CGFloat num3 = 0;
            if (width > WIDTH) {
                num3 = (WIDTH - 10)/width;
                width = WIDTH - 10;
                height = height * num3;
            }
            if (height >= 400) {
                return 400 + rect.size.height + 65;
            }
            else
                return height + rect.size.height + 65;
        } else {
        
            return [self CommentCellHeight:indexPath.row];
        }
    }
    
    else {
    
        return 100;
    }
}

/**评论cell的高度*/
-(CGFloat)CommentCellHeight:(NSInteger)i {

    HYCommentModel *model = self.dataArray[i];
    CGRect rect = [model.text boundingRectWithSize:CGSizeMake(220, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName] context:nil];
    return rect.size.height + 65;
}

-(void)createNavication {

    UIButton *leftBtn = [ZCControl createButtonWithFrame:CGRectMake(0, 0, 30, 30) ImageName:@"leftBackButtonFGNormal" Target:self Action:@selector(leftButtonClick) Title:nil];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [ZCControl createButtonWithFrame:CGRectMake(0, 0, 40, 40) ImageName:nil Target:self Action:@selector(right1ButtonClick) Title:@"举报"];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.title=@"详情";

}

-(void)leftButtonClick {

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)right1ButtonClick
{
    ReportViewController *vc=[[ReportViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if (section == 0) {
        return 0;
    }
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    if (section == 1) {
        NSInteger n = [self.model.comment_count integerValue];
        if (self.dataArray.count == 0 || n == 0) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
            UILabel *label = [ZCControl createLabelWithFrame:CGRectMake(0, 0, WIDTH, 40) Font:13 Text:nil];
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
            UIImageView *imageView = [ZCControl createImageViewWithFrame:CGRectMake(40, 40, WIDTH-80, 80) ImageName:@"picture_sofa_night"];
            [view addSubview:imageView];
            return view;
        }
        if (n > num + 20) {
            
            UIButton *btn1 = [ZCControl createButtonWithFrame:CGRectMake(20, 0,WIDTH , 40) ImageName:nil Target:self Action:@selector(jiazaiClick) Title:@"点击查看更早...."];
            btn1.backgroundColor = [UIColor brownColor];
            return btn1;
        }
        else if (n == 0) {
        
            UILabel *label = [ZCControl createLabelWithFrame:CGRectMake(0, 0, WIDTH, 40) Font:13 Text:@"暂无任何评论"];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor brownColor];
            label.textColor = [UIColor whiteColor];
            return label;

        }
        else {
        
            UILabel *label = [ZCControl createLabelWithFrame:CGRectMake(0, 0, WIDTH, 40) Font:13 Text:@"新鲜评论到此结束!!"];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor brownColor];
            label.textColor = [UIColor whiteColor];
            return label;
        }
    }
    else if (section == 0) {
    
        return nil;
    }
    return nil;
}

-(void)jiazaiClick {

    num = num + 20;
    NSString *offset = [NSString stringWithFormat:@"%d",num];
    block = [[HttpRequestBlock alloc] initWithUrlPath:[NSString stringWithFormat:self.UrlStr,self.group_id,offset] Block:^(BOOL isSucceed, HttpRequestBlock *http) {
        
        if (isSucceed) {
            self.dataArray = [NSMutableArray arrayWithCapacity:0];
            NSDictionary *dict = http.dataDic[@"data"];
            NSArray *arr = dict[@"recent_comments"];
            for (NSDictionary *dict1 in arr) {
                HYCommentModel *model = [[HYCommentModel alloc] init];
                [model setValuesForKeysWithDictionary:dict1];
                [self.dataArray addObject:model];
            }
            [_tableView reloadData];
        }
    }];
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
