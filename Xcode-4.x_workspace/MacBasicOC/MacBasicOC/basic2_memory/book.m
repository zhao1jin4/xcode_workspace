#import "book.h" 
@implementation Book 

@synthesize ID=_id;
-(void) dealloc
{
    NSLog(@"Book 的 dealloc 被调用");
	[super dealloc];
}
@end