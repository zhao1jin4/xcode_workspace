//
//  main_proxy.c
//  MacBasicOC
//
//  Created by LiZhaoJin on 13-4-2.
//  Copyright (c) 2013年 zhaojin . All rights reserved.
//

#include <stdio.h>
#import "myprotocol.h"
#import "programmer.h"
#import "computer.h"
 int main_proxy (int argc, const char *argv[])
{
    //单击项目进入项目属性->PROJECT中的项目名选中->Apple LLVM Compiler 4.1-Language卷栏中,Objective-C Automatic Reference Counting(ARC)设置Yes/No
    //在TARGES中选中项目->Build Phases 标签->Compile Sources标签,把所有要参与编译的原文件加入
    
    //-----
    id<MyMouseProtocol> xcode=[[Programmer alloc] init];
    
    //GnuSetup不认 repondsToSelector
//    if( [xcode respondsToSelector:@selector( onClick ) ])//onMove:y: 判断是否实现了@optinoal的方法
//    {
//        [xcode onMove:20 y:30];
//    }
    //----或者
    SEL sel=@selector(onClick);
    if( [xcode respondsToSelector:sel ])//onMove:y: 判断是否实现了@optinoal的方法
    {
        [xcode onMove:20 y:30];
    }
    
    [xcode release];

     //---- 代理
    
    
    Programmer * programmer = [[Programmer alloc]init];
    [programmer setID:10];
    Computer* computer =[[Computer alloc]init];//autorelease 
    [computer setID:50];
    printf("before seComputer \n");
    [programmer setComputer:computer];
    printf("after seComputer \n");
    while(1)//为定时器可向下走
    {
        [[NSRunLoop currentRunLoop] run];
    }
    [computer release];
    [programmer release];
    
    
    
    
    
    return 1;
  }
