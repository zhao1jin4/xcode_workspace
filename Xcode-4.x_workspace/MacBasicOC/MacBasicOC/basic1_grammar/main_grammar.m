#import <Foundation/Foundation.h>
#import "dog.h"
int main_grammar(int argc,const char* argv[])
{
	//@autoreleasepool {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];  
		NSLog(@"hello");
		//建立对象 
		Dog *dog =[Dog alloc];//所有的对象必须加* ,也表示一个引用,也表示一个指针,alloc 是NSObject的方法
		[dog init];
		//或者用一行函数的两次调用   Dog *dog =[[Dog alloc]init];
		
		[dog initWithOther:5 :200];//调用传参
		int age=[dog getAge];
		printf("age is:%d\n",age);
		[dog print:1 andAge:5];//带标签的传参
		[dog print:1 andPrice:105.0f];
		
		
		
		dog.age=10;//相当于调用[dog setAge:10] ,age属性是private的
		int age1=dog.getAge;
		//dog.setAge=20;//错误
		//age1=dog.age;//错误
		NSLog(@"age1 is:%d\n",age1);
		
		//dog.price=122.5f;
		float price=dog.price;
		NSLog(@"price:%3.2f\n",price);
	
		
		[dog  release];//销毁对象
	[pool release];  	
	//}
	
	
//gcc -c dog.m main.m -ID:/Program/GNUstep/GNUstep/System/Library/Headers -fconstant-string-class=NSConstantString -LD:/Program/GNUstep/GNUstep/System/Library/Libraries -lobjc -lgnustep-base
//gcc -o dog dog.o  main.o -ID:/Program/GNUstep/GNUstep/System/Library/Headers -fconstant-string-class=NSConstantString -LD:/Program/GNUstep/GNUstep/System/Library/Libraries -lobjc -lgnustep-base
 
 	return 0;
}