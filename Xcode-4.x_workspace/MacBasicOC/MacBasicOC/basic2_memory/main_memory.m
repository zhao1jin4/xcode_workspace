#import <Foundation/Foundation.h>
#import "person.h"

int main_memory(int argc,const char* argv[])
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
		
		NSLog(@"hello world");
	
		
		NSMutableString *str=[[NSMutableString alloc]init];//alloc 后变1
		[str retain];//2  ,加1
		[str retain];//3
		int count=[str retainCount];//查看
		NSLog(@"str retainCount:%ld\n",count);//3
		[str release];//2 ,减1
		[str release];//1
		[str release];//0 ,到0调用 dealloc 函数
		
		//----------------
		Book *book=[[Book alloc]init];
		Book *book2=[[Book alloc]init];
		 
		 Person *lisi=[[Person alloc]init];
		[lisi setBook:book];
		[lisi setBook:book];
		[lisi setBook:book2];
		
		count=[book retainCount];
		NSLog(@"book retainCount:%ld\n",count);
	
		Person *wang=[[Person alloc]init];
		[wang setBook:book];
		[wang setBook:book];
		
		count=[book retainCount];
		NSLog(@"book retainCount:%ld\n",count);
		 
		 
		[book2  release];
		[book  release];
		[wang  release];
		[lisi  release];
		
		//--数组
		NSMutableArray *array=[[NSMutableArray alloc]init];
		int i;
		for(i=0;i<5;i++)
		{
			Book *temp =[[Book alloc]init];
			temp.ID=i;//ID是基本类型不用release
			[array addObject:temp];//向数组加元素
			[temp release];//记得release
		}
		for (Book *b in array)
		{
			NSLog(@"book ID is %d",[b ID]);
		}
		[array release];
 	
		
		NSLog(@"auto release test");
		//调用autorelease方法,会把自己放入,离自己最近的释放池中,栈顶的池
		NSAutoreleasePool *pool2 = [[NSAutoreleasePool alloc] init];
			Book *other =[[[Book alloc]init]autorelease];//以后不可再使用other,只会在pool release时把这个才会被release
			//...其它地方可以用 other
			Person *zhao=[[Person alloc]init];
			[zhao setBook:[[[Book alloc]init]autorelease]]; //特殊用法,如是release是错误的
			//zhao.book=[[[Book alloc]init]autorelease]; 
			[zhao release];
		
		[pool2 release];
		
		
		
	[pool release];

//gcc -c book.m person.m main.m  -ID:/Program/GNUstep/GNUstep/System/Library/Headers -fconstant-string-class=NSConstantString -LD:/Program/GNUstep/GNUstep/System/Library/Libraries -lobjc -lgnustep-base
//gcc -o person person.o book.o  main.o -ID:/Program/GNUstep/GNUstep/System/Library/Headers -fconstant-string-class=NSConstantString -LD:/Program/GNUstep/GNUstep/System/Library/Libraries -lobjc -lgnustep-base	
 	return 0;
}
 
