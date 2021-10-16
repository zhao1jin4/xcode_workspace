#import <Foundation/Foundation.h>   
#import "MyPrivate.h"
int main_category (int argc, const char *argv[])
{    
	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];   
  		NSLog(@"Hello World!");    

		NSString * str=@"中华人民共和国";
		NSString * res=[str myreverse];//GnuSetup测试不行
		NSLog(@"the myreverse result is:%@	",res);


		My* my=[[My alloc]init];
 		[my publicMethod];
		[my privateMethod];//头文件中没有,也可调用,但要能猜到,只是写的时候不提示
		 
		[my release];

	[pool release];    
	return 0; 
}
  