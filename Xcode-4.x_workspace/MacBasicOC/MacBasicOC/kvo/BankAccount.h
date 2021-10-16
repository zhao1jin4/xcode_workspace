//
//  BankAccount.h
//  MacBasicOC
//
//  Created by zhaojin  on 13-9-15.
//  Copyright (c) 2013年 zhaojin . All rights reserved.
//
//#import "BankCustomer.m"
#import <Foundation/Foundation.h>

@interface BankAccount : NSObject
{
	float _balance;
}
@property(nonatomic,assign) float balance ;
-(void)balanceChanged:(NSTimer *)timer;
-(void)begainTimer;
@end
