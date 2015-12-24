//
//  ViewController1.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/16.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()
{
   
    UIWebView *_webView;
}

@end

@implementation ViewController1

-(BOOL) prefersStatusBarHidden{
    return  YES;//隐藏状态栏
}

- (void)viewDidLoad {
    [super viewDidLoad];
   _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:request];
    [self .view addSubview:_webView];
    
    UIButton *btn1 =[ZCControl createButtonWithFrame:CGRectMake(10, 50, 40, 30) ImageName:@"leftBackButtonFGNormal" Target:self Action:@selector(btn1Click) Title:nil];
    btn1.backgroundColor = [UIColor lightGrayColor];
    btn1.layer.borderWidth = 1;
    btn1.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:btn1];
}

-(void)btn1Click {
    
    [self.navigationController popViewControllerAnimated:YES];
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
