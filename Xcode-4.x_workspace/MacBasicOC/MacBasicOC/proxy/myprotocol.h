#import <Foundation/Foundation.h>   

//类似于C++的纯虚函数,Java中的接口,只写在.h中
@protocol MyMouseProtocol <NSObject> //至少要继承NSObject
	@optional //表示方法可以不实现,是默认的
		-(void)onMove:(int)x y:(int)y;//方法的标签和名字可以取相同值
	@required //表示方法必须实现,
        -(void)onClick;
@end

@protocol MyKeyProtocol <NSObject>  
	@optional  
		-(void)onKeyDown:(int)code;
@end
 

