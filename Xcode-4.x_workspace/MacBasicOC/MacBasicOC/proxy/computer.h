#import <Foundation/Foundation.h>
#import "programmer.h" 
#import "myprotocol.h" 
@protocol MyMouseProtocol;//声明

@interface Computer:NSObject
{
	id<MyMouseProtocol>  delegate;//如不加<>就是任何类型
	void (^positionCallBack)(int x,int y);//声明block变量 ,GnuSetup不认^
	NSTimer* timer;
	int count;
	int ID;
}

-(void) setPositionCallBack:(  void (^)(int x,int y)  )callback;//声明函数参数为block,GnuSetup不认^
@property(assign) int ID;
@property(assign) id<MyMouseProtocol> delegate;//应该对称的加<>,id 只是一个数,地址值不用retain
-(void)dealloc;
-(id)init;

@end