//
//  ZHUserBean.h
//  MyMac
//
//  Created by LiZhaoJin on 13-4-12.
//  Copyright (c) 2013年 zhaojin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHUserBean : NSObject
{
    NSString* userName;
    NSString* userPass;
    
}

@property(copy,nonatomic)  NSString* userName,*userPass; //有assign,retain,copy 另一个有atomic,另一个readonly,readwrite，可以一行写
//@property(copy,nonatomic)  NSString* userPass;

+(ZHUserBean*)singleInstance;
-(BOOL)checkLogin;
@end
