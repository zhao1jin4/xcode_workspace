//
//  ZHPerson.h
//  MacBasicOC
//
//  Created by LiZhaoJin on 13-4-30.
//  Copyright (c) 2013年 zhaojin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHPerson : NSObject
{
    @protected
        NSString * _name;
}
@property (nonatomic,retain) NSString *name;
-(void)printDescription;

@end
