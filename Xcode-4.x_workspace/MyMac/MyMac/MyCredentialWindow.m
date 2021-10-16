//
//  MyCredentialWindow.m
//  MyMac
//
//  Created by zhaojin  on 12-11-8.
//  Copyright (c) 2012年 zhaojin . All rights reserved.
//

#import "MyCredentialWindow.h"

@implementation MyCredentialWindow  //做为 用户认证的窗口的类，自定义显示

//NSWindow 的初始化方法
-(id)initWithContentRect:(NSRect)contentRect
			   styleMask:(NSUInteger)aStyle
				 backing:(NSBackingStoreType)bufferingType
				   defer:(BOOL)flag
{
	
    self=[super initWithContentRect:contentRect
						  styleMask:aStyle
							backing:bufferingType
							  defer:flag];
    

	 if(self)
	{
		[self setContentBorderThickness:32 forEdge:NSMinYEdge];//自定义窗口风格
	}
	return self;
}

@end
