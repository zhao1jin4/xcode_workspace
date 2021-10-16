//
//  BankCustomer.h
//  MacBasicOC
//
//  Created by zhaojin  on 13-9-15.
//  Copyright (c) 2013年 zhaojin . All rights reserved.
//
#import "BankAccount.h"
#import <Foundation/Foundation.h>

@interface BankCustomer : NSObject
{
	BankAccount *_account;
}
@property(nonatomic,assign) BankAccount *account;
-(void)myRegstierMonitor;
@end
