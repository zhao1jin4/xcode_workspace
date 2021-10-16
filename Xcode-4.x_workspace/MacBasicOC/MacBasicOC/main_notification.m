#import <Foundation/Foundation.h>


@interface MyNotify:NSObject  {
	NSString *msg;
}
@end

@implementation MyNotify
-(void) init_register
{
    //先注册服务
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(handleMsgChange:) name:@"MsgChange" object:nil];
}
//[[NSNotificationCenter defaultCenter] removeObserver:self];//取消注册

-(void) send_msg
{
    //再向服务发消息
	NSDictionary *dictionary = [NSDictionary dictionaryWithObject:@"这个是业务消息值" forKey:@"msgKey"];
	
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	[notificationCenter postNotificationName:@"MsgChange" object:self userInfo:dictionary];
}
-(void) handleMsgChange:(NSNotification *)notification {
		
	NSDictionary *dictionary = [notification userInfo];
	NSString *msg = [dictionary objectForKey:@"msgKey"];
    NSLog(@"Received notification,msg=%@",msg);

	
}
@end



int main_notification( int argc, const char *argv[] )
{
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
   
    MyNotify *my=[[MyNotify alloc]init];
    [my init_register];
    [my send_msg];
    
	[pool release];
	return 0;
}


