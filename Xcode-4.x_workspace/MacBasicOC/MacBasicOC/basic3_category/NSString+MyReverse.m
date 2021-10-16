#import <Foundation/Foundation.h>
#import "NSString+MyReverse.h"
@implementation NSString(MyReverse)
-(id) myreverse
{
	NSUInteger len=[self length];//length属性
	NSMutableString * str=[NSMutableString stringWithCapacity:len];//stringWithCapacity 方法
	while(len>0)
	{
		unichar c=[self characterAtIndex:--len];//characterAtIndex 方法 , unichar 类型
		NSLog(@"c is %C",c);//%C 是Unicode
		NSString *s=[NSString stringWithFormat:@"%C",c];//stringWithFormat 方法
		[str appendString:s];//appendString 方法
	}
	return str;
}
@end