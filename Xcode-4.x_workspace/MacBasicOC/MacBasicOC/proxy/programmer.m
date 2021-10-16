#import "programmer.h"
#import "computer.h"
@implementation Programmer :NSObject //不能加 <MyMouseProtocol,MyKeyProtocol>,也可不加 :NSObject
	
	-(void)onMove:(int)x y:(int)y//实现 optional
	{
		printf("recieve Move x=%d,y=%d\n",x,y);
		
	}
	-(void)onClick//实现 required
	{
		//如何event转为Computer
		
		printf("recieve Click id\n");
	}
	-(void)onKeyDown:(int)code//实现 optional
	{	
		printf("recieve KeyDown ,code is %d\n",code);
	}
	-(void)otherBussiness
	{
		printf("recieve otherBussiness\n");
	}
	 
	@synthesize computer=_computer;
	@synthesize ID;
 	-(void)dealloc
	{
		printf("Programmer dealloc! \n");
		[super dealloc];
		self.computer=nil;//声明为@property(retain)
	}

	-(void)setComputer:(Computer *)computer
	{
		if(_computer!=computer)//防止相同参数调两次
		{
			[_computer release];
			_computer=[computer retain];
			//[computer retain]; //声明为@property(retain)不要做这步
		 	
            [_computer setDelegate:self];//GnuSetup加NSTimer不能调用这个
			//_computer.delegate=self;//点语法
			
			
			[_computer setPositionCallBack:^(int x,int y){  //传递匿名函数实现,GnuSetup不认^
							printf("in setPositionCallBack,x=%d,y=%d",x,y);
						}];
			//带函数名如何做,有返回值的怎么写
		}
	}
 
	
@end
 