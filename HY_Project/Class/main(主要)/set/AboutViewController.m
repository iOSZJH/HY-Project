//
//  AboutViewController.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/5.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    [self createView];
    
}

-(void)createView
{
    UITextView*_textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _textView.backgroundColor=[UIColor whiteColor];
    _textView.font=[UIFont systemFontOfSize:12];
    _textView.textColor=[UIColor brownColor];
    _textView.editable=NO;
    [self.view addSubview:_textView];
    NSString *str=@"                                       免责声明\n总则\n用户在掌上笑逗服务之前，请务必仔细阅读本条款并同意本声明。\n用户直接或通过各类方式（如站外API引用等）间接使用指掌上秀逗服务和数据的行为，都将被视作已无条件接受本声明所涉全部内容；若用户对本声明的任何条款有异议，请停止使用掌上笑逗所提供的全部服务。\n第一条\n用户以各种方式使用掌上笑逗服务和数据（包括但不限于发表、宣传介绍、转载、浏览及利用掌上笑逗或掌上笑逗用户发布内容）的过程中，不得以任何方式利用掌上笑逗直接或间接从事违反中国法律、以及社会公德的行为，且用户应当恪守下述承诺：\n1.发布、转载或提供的内容符合中国法律、社会公德。\n2.不得干扰、损害和侵犯掌上笑逗的各种合法权利与利益。3.遵守掌上笑逗以及与之相关的网络服务的协议、指导原则、管理细则等。\n掌上笑逗有权对违反上述承诺的内容予以删除。\n第二条\n用户以各种方式使用掌上笑逗服务和数据（包括但不限于发表、宣传介绍、转载、浏览及利用掌上笑逗或掌上笑逗用户发布内容）的过程中，不得以任何方式利用掌上笑逗直接或间接从事违反中国法律、以及社会公德的行为，且用户应当恪守下述承诺：\n1.掌上笑逗仅为用户发布的内容提供存储空间，掌上笑逗不对用户发表、转载的内容提供任何形式的保证：不保证内容满足您的要求，不保证掌上笑逗的服务不会中断。因网络状况、通讯线路、第三方网站或管理部门的要求等任何原因而导致您不能正常使用，掌上笑逗不承担任何法律责任。\n2.用户在掌上笑逗发表的内容（包含但不限于掌上笑逗目前各产品功能里的内容）仅表明其个人的立场和观点，并不代表掌上笑逗的立场或观点。作为内容的发表者，需自行对所发表内容负责，因所发表内容引发的一切纠纷，由该内容的发表者承担全部法律及连带责任。掌上笑逗不承担任何法律及连带责任。\n3.用户在指掌上笑逗发布侵犯他人知识产权或其他合法权益的内容，掌上笑逗有权予以删除，并保留移交司法机关处理的权利。\n4.个人或单位如认为掌上笑逗上存在侵犯自身合法权益的内容，应准备好具有法律效应的证明材料，及时与掌上笑逗取得联系，以便掌上笑逗迅速做出处理。\n掌上笑逗有权对违反上述承诺的内容予以删除。\n附则\n对免责声明的解释、修改及更新权均属于掌上笑逗所有。";
    _textView.text=str;
}

-(void)createNavBar {
    
    UIButton *btn = [ZCControl createButtonWithFrame:CGRectMake(0, 0, 44, 44) ImageName:@"leftBackButtonFGNormal" Target:self Action:@selector(btnClick) Title:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(void)btnClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
