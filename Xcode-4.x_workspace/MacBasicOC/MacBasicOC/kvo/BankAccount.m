//
//  BankAccount.m
//  MacBasicOC
//
//  Created by zhaojin  on 13-9-15.
//  Copyright (c) 2013年 zhaojin . All rights reserved.
//

#import "BankAccount.h"

@implementation BankAccount
@synthesize balance=_balance;
 
-(void)begainTimer
{
	
	[NSTimer scheduledTimerWithTimeInterval:1.0f target:self
								   selector:@selector(balanceChanged:)
								   userInfo:nil
									repeats:YES];

}

-(void)balanceChanged:(NSTimer *)timer
{
	float f=arc4random()%100;
	//_balance=f;//无效的
	//self.balance=f;
	[self setValue:[NSNumber numberWithFloat:f] forKey:@"balance"];//属性可用字串来写
}

@end
