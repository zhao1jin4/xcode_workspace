#import "dog.h"
@implementation Dog
 
-(void) setAge:(int)newAge
{
	age=newAge;
}
-(int) getAge
{
	return age;
}

@synthesize  price = _price;//使用指定属性自动生成 setPrice , price 的方法实现,也可不指定名字相同
/*
-(void) setPrice:(float)newPrice
{
	_price=newPrice;
}
-(float) price
{
	return _price;
}
*/
-(id)initWithOther:(int)newAge :(float)newPrice//:前是标签,如没有是匿名标签,第一个:前的是函数名,第二个:前要有空格
{
	self=[super init];
	age=newAge;
	_price=newPrice;
	return self;
}
-(id)init
{
	return [self initWithOther:5 :100.0f];
}
-(void)print:(int)newID andAge:(int)newAge{
	ID=newID;
	age=newAge;
}
-(void)print:(int)newID andPrice:(float)newPrice//OC函数重载不区分类型,要使用不同标签来区分
{
	ID=newID;
	_price=newPrice;
}
@end

