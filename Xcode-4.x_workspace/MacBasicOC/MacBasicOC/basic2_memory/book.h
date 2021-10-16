#import <Foundation/Foundation.h>

@interface Book:NSObject{
	@private int _id;
}
@property int ID;//ID是基本类型不用release
-(void) dealloc;

@end