#import "person.h" 
@implementation Person 


-(void) dealloc  //NSObject 有dealloc方法,是当retainCount为0时自动调用
{
	NSLog(@"Person 的 dealloc 被调用");
	
	//[_book release];//把自己引用其它的对象也release
	self.book=nil;//对应@property(retain),自动减一
	
	[super dealloc];
}

@synthesize  book=_book;
/*
-(void) setBook:(Book*)newBook{
	if(_book!=newBook)//是否被相同的调用两次
	{
		[_book release];//是否被不相同的调用两次
        _book=[newBook retain];
        //或者用两行 
		_book=newBook;
		[newBook retain];
		
	}	
}
-(Book*) book{
	return _book;
}
*/

@end