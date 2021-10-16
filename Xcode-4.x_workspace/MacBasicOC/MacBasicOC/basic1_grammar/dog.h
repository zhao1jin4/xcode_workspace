#import <Foundation/Foundation.h>  //编译会知道导入了一次,就不会再导入第二次了
@interface Dog:NSObject{
	//只能写字段,不能写函数
	@public 
	 	int ID; 
	@protected  //OC默认是@protected,也可是@public,@private
		int weight;
	@private 
		int age;
		float _price;
	
}
//这里写函数,OC叫消息,所有的函数全是没有作用域的,即@public的,可以把函数不声明在.h文件
//+表示类的方法,即static,-表示对象的方法,:后表示参数
-(void) setAge:(int)newAge;
-(int) getAge;

@property(readonly)float price;//自动生成setPrice , price 方法的声明
//默认是readwrite,可以是readonly
	
-(id)init; //要返回id
-(id)initWithOther:(int)newAge :(float)newPrice;//:前是标签,如没有是匿名标签,第一个:前的是函数名,第二个:前要有空格
-(void)print:(int)newID andAge:(int)newAge; 
-(void)print:(int)newID andPrice:(float)newPrice;//OC函数重载不区分类型,要使用不同标签来区分
@end