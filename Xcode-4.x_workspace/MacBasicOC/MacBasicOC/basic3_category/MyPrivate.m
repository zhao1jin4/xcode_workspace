#import <Foundation/Foundation.h>
#import "MyPrivate.h"


//下面部分写在.m文件,而不写在.h文件中,实现方法私有
@interface My(Private)
-(void)privateMethod;
@end
 
@implementation My(Private)
 -(void) privateMethod
{
	printf("execute in privateMethod \n");
}
@end

//实现.h文件
@implementation My
-(void) publicMethod
{
	[self privateMethod];
}
@end
