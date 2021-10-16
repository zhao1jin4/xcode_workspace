//
//  ZHPerson.m
//  MacBasicOC
//
//  Created by LiZhaoJin on 13-4-30.
//  Copyright (c) 2013年 zhaojin . All rights reserved.
//

#import "ZHPerson.h"

@implementation ZHPerson
@synthesize name=_name;

-(void)printDescription
{
    NSLog(@"这是在Persion中,name=%@",self.name);
}
@end
