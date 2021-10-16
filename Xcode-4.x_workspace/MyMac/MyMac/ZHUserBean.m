//
//  ZHUserBean.m
//  MyMac
//
//  Created by LiZhaoJin on 13-4-12.
//  Copyright (c) 2013年 zhaojin . All rights reserved.
//

#import "ZHUserBean.h"

@implementation ZHUserBean

@synthesize userName,userPass;//可写在一行上,不用加 类名*

+(ZHUserBean*)singleInstance //单例模式
{
    static id single=nil;
    if(single == nil)
    {
        single=[[self alloc]init];
    }
    return single;
}
-(BOOL)checkLogin
{
    return (self.userName==nil ||self.userPass==nil) ? YES:NO;//YES,NO的定义
}

-(void)dealloc
{
    
    //[userName release];
    //[self setUserName:nil];
    
    self.userName=nil;//一行相当于上两行
    self.userPass=nil;
}

@end
