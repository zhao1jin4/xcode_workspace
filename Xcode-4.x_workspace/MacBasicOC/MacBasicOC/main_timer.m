#import <Foundation/Foundation.h>


@interface MyTimer:NSObject{
    NSTimer *timer;
}
@end

@implementation MyTimer
 -(void)init_timer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    //[timer invalidate];//取消定时
}
- (void) timerFired:(NSTimer *)timer {
	NSLog(@"Timer Fired: %@", [[NSDate date] description]);
}
@end
 
int main_timer( int argc, const char *argv[] )
{
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
    MyTimer *my=[[MyTimer alloc]init];
    [my init_timer];

    while(1)//为定时器可向下走
    {
        [[NSRunLoop currentRunLoop] run];
    }

    [pool release];
	return 0;
}


