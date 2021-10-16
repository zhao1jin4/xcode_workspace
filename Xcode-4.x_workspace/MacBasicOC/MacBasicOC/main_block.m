#import <Foundation/Foundation.h>


         
typedef int (^SumBockT)(int a,int b);//和C类似

@interface CloudCalc:NSObject
{
}
-(void) cloudSum:(SumBockT)callback;
@end;

@implementation CloudCalc
-(void) cloudSum:(SumBockT)callback{
    int result=callback(2,4);
    NSLog(@"use blocks result:%d",result);
}
@end;


int main_block( int argc, const char *argv[] )
{
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
    //GNUSetup要加 -fobjc-exceptions
 
     //---
    void (^myblock)(void)=NULL;//GnuSetup不支持^
    myblock=^(void)//实现
    {
        NSLog(@"in block method");
    };//要有;
    NSLog(@"---before invoke myblock");
    myblock();//调用
    NSLog(@"---after invoke myblock");
    
    //---
    __block int sum=0;//全局变量
    int (^myblock2)(int a,int b)=^(int a,int b)
    {
        sum=a+b;//不能仿问外部的auto变量,要定义为__block
        int c=a+b;
        return c;
    };
    int res=myblock2(10,20);
    NSLog(@"myblock2 ressult is %d ,sum is %d ",res,sum);
    
    //---
    SumBockT myblockT=^(int a,int b)
    {
        int c=a+b;
        return c;
    };
    int typeRes=myblockT(10,20);
    NSLog(@"myblock2 typeRes is %d",typeRes);
    
    //---
    CloudCalc *cloud=[[CloudCalc alloc]init];
    [cloud cloudSum:myblockT];//传实名
     
    //---
    
	NSArray *array = [NSArray arrayWithObjects:@"one", @"two", @"three", @"four", nil];
    
	array = [array sortedArrayUsingComparator:
             ^(id a, id b)
             {
                 if ([a isKindOfClass:[NSString class]] && [b isKindOfClass:[NSString class]]) {
                     return [a compare:b options:NSCaseInsensitiveSearch];
                 }
                 
                 return NSOrderedSame;
             }];
	
	
	void (^printItem)(id obj, NSUInteger idx, BOOL *stop);
	
	printItem = ^ (id obj, NSUInteger idx, BOOL *stop) {
		NSLog(@"Object: %@", obj);
	};
	
	
	[array enumerateObjectsUsingBlock:printItem];

    
    
    
	[pool release];
	return 0;
}
 
