//
//  UCViewController.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/16.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "UCViewController.h"

@interface UCViewController ()<UIWebViewDelegate>
{
    UITextField *_tf;
    UIWebView *_webView;
}
@end

@implementation UCViewController

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
}

-(BOOL) prefersStatusBarHidden{
    return  YES;//隐藏状态栏
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[@"主页",@"前进",@"后退",@"停止",@"转到",@"刷新"];
    for (int i = 0; i<array.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.borderWidth = 2;
        btn.layer.cornerRadius = 8;
        btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];
        
        btn.frame = CGRectMake(i*(self.view.frame.size.width/array.count), 5, self.view.frame.size.width/array.count, 30);
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    _tf = [[UITextField alloc]initWithFrame:CGRectMake(50, 50, self.view.frame.size.width-60, 30)];
    _tf.borderStyle = UITextBorderStyleBezel;
    _tf.placeholder = @"🔍  输入要搜索的内容" ;
    [self.view addSubview:_tf];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-80)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    [self web];
    
    UIButton *btn1 =[ZCControl createButtonWithFrame:CGRectMake(10, 50, 40, 30) ImageName:@"leftBackButtonFGNormal" Target:self Action:@selector(btn1Click) Title:nil];
    btn1.backgroundColor = [UIColor lightGrayColor];
    btn1.layer.borderWidth = 1;
    btn1.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:btn1];
}

-(void)btn1Click {

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)web{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"xml2" ofType:@"html"];
    //html的字符串取出
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:html baseURL:nil];//nil 写后面的东西
}

-(void)go{

    if (![_tf.text hasSuffix:@"http"]) {
        _tf.text = [NSString stringWithFormat:@"http://%@",_tf.text];
    }
    NSURL *url = [NSURL URLWithString:_tf.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [_tf resignFirstResponder];
}

-(void)btnClick:(UIButton *)sender{
    //后退
    if (sender.tag == 100) {
      
        [self web];
    }
    //前进
    if (sender.tag == 101) {
        [_webView goForward];
    }
    //主页
    if (sender.tag == 102) {
         [_webView goBack];
    }
    //停止
    if (sender.tag == 103) {
        [_webView stopLoading];
    }
    //转到
    if (sender.tag == 104) {
        [self go];
    }
    //刷新
    if (sender.tag == 105) {
       [_webView reload];
    }
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //请求前调用该方法
    //刷新地址栏
    _tf.text = request.URL.absoluteString;//Java scirpt能调用oc的方法
    //分割字符串
    NSArray *array = [_tf.text componentsSeparatedByString:@"://"];
    if ([array[0] isEqualToString:@"oc"]) {
        //获取到java script想调用的方法名称
        
        SEL sel = NSSelectorFromString(array[1]);//方法名称NSSelectorFromString
        [self performSelector:sel];//调用方法
    }
    return YES;
}

-(void)sel {

}

@end
