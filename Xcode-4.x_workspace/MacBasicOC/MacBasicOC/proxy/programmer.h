#import <Foundation/Foundation.h>   
#import "myprotocol.h"
#import "computer.h"

@class Computer;//@interface的定义使用@class声明

//程序员去实现,当单击时做什么,电脑发出单击事件
@interface Programmer :NSObject<MyMouseProtocol,MyKeyProtocol> //实现协议
	{
		Computer *_computer;
        int ID;
	}
	-(void)otherBussiness;
    @property (assign)int ID;
	@property(nonatomic, retain) Computer* computer;
 	-(void)dealloc;
@end