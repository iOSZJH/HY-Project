//
//  ReportViewController.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/11.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "ReportViewController.h"
#import "MBProgressHUD+MJ.h"

@interface ReportViewController ()<UIAlertViewDelegate>
{
    BOOL isDid;
    UIAlertView*al;
}
@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isDid=NO;
    [self createView];
    self.view.backgroundColor = [UIColor lightGrayColor];
}

-(void)createView
{
    self.view.backgroundColor=[UIColor lightGrayColor];
    NSArray*array=@[@"垃圾广告",@"淫秽色情",@"煽情骗顶",@"以前看过",@"抄袭我的",@"其他原因"];
    
    for (int i=0; i<6; i++) {
        UIButton*button=[ZCControl createButtonWithFrame:CGRectMake(20/3+i%2*(150+30/3), 200/3+i/2*(40+20/3), 150, 40) ImageName:nil Target:self Action:@selector(buttonClick:) Title:array[i]];
        button.tag=100+i;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor orangeColor].CGColor;
        button.layer.borderWidth = 2;
        button.layer.cornerRadius = 8;
        button.backgroundColor=[UIColor brownColor];
        [self.view addSubview:button];
        
    }
   
    UIButton*button1=[ZCControl createButtonWithFrame:CGRectMake(WIDTH/2-60, 260, 120, 50) ImageName:nil Target:self Action:@selector(buttonClick1:) Title:@"提交"];
    button1.backgroundColor=[UIColor whiteColor];
    button1.layer.cornerRadius=10;
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.layer.masksToBounds=YES;
    [self.view addSubview:button1];
}
-(void)buttonClick:(UIButton*)button
{
    isDid=YES;
    for (int i=0; i<6; i++) {
        UIButton*button1=(UIButton*)[self.view viewWithTag:100+i];
        UIImage*image1=[UIImage imageNamed:@"selectround_detail_report.png"];
        [button1 setImage:image1 forState:UIControlStateNormal];
    }
    UIImage*image=[UIImage imageNamed:@"selectround_detail_report_press.png"];
    [button setImage:image forState:UIControlStateNormal];
    
}
-(void)buttonClick1:(UIButton*)button
{
    NSLog(@"提交");
    if (isDid==NO) {
        al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择一项理由" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [al show];
        [self performSelector:@selector(dismisAlert) withObject:self afterDelay:1];
        
        return;
    }
    [MBProgressHUD showMessage:@"正在提交..."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"提交成功"];
        button.backgroundColor=[UIColor orangeColor];
        UILabel*label=[ZCControl createLabelWithFrame:CGRectMake(WIDTH/2-60, 320, 120, 20) Font:15 Text:@"已提交"];
        label.textColor=[UIColor redColor];
        label.textAlignment=NSTextAlignmentCenter;
        [self.view addSubview:label];
        button.enabled=NO;
    });
    
}
-(void)dismisAlert
{
    [al dismissWithClickedButtonIndex:0 animated:YES];
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
