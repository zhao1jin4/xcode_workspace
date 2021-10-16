#import <Foundation/Foundation.h>
#import "book.h"
@interface Person:NSObject{
 Book * _book;
}
-(void) dealloc;

//@property(assign)是默认的
@property(retain) Book *book; //@synthesize 生成生成方法getter/setter实现,内部自动对计数器加减
//@property(copy) Book *book; //生成setBook方法是把传来的复制一份,形式为[_book copy]

//-(void) setBook:(Book*)newBook;
//-(Book*) book;

@end