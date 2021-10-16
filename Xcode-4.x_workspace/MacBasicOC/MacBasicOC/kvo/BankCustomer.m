//
//  BankCustomer.m
//  MacBasicOC
//
//  Created by zhaojin  on 13-9-15.
//  Copyright (c) 2013年 zhaojin . All rights reserved.
//

#import "BankCustomer.h"

@implementation BankCustomer

@synthesize account=_account;

static void * contextOne=(void*)&contextOne;//这个指针指向自己

-(void)myRegstierMonitor
{
	[self.account addObserver:self forKeyPath:@"balance" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld
				 context:contextOne];
	//addObserver:self调用 observeValueForKeyPath
}
//当balance属性变化时回调这个系统方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if(context==contextOne && [keyPath isEqualToString:@"balance"])
	{
		id old=[change objectForKey:NSKeyValueChangeOldKey];
		id new=[change objectForKey:NSKeyValueChangeNewKey];

		NSLog(@"(对象)%@银行账号余额(属性)%@ 变化,由%@ 到 %@",object,keyPath,old,new);
				
		
	}
}
@end
