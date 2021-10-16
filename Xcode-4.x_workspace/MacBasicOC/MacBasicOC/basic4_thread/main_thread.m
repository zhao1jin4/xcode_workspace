#import <Foundation/Foundation.h>

NSCondition *ticketCondition;
int tickets = 100;
int count= 0;
 

NSLock *lock;
@interface MyObject : NSObject
+(void)aMethod:(id)param;
@end
@implementation MyObject
+(void)aMethod:(id)param{
    int x;
    for(x=0;x<50;++x)
    {
        [lock lock];
        printf("Object Thread says x is %i\n",x);
        NSLog(@"param=%@",param);
        usleep(1);
        [lock unlock];
    }
}
+ (void)run{
    while (TRUE) {
        [ticketCondition lock];//正常,只可一个线程得到lock
        if(tickets > 0){
            [NSThread sleepForTimeInterval:0.5];
            count = 100 - tickets;
            NSLog(@"当前票数是:%d,售出:%d,线程名:%@",tickets,count,[[NSThread currentThread] name]);
            tickets--;
        }else{
            break;
        }
        [ticketCondition unlock];
    }
}
@end


int main_thread(int argc, char *argv[])
{
    
    //-----ticket
   /*
    [NSThread sleepForTimeInterval:0.5];
     ticketCondition = [[NSCondition alloc] init];
    NSThread *ticketsThreadone = [[NSThread alloc] initWithTarget:[MyObject class] selector:@selector(run) object:nil];
    [ticketsThreadone setName:@"Ticket-1"];
    [ticketsThreadone start];

    NSThread *ticketsThreadtwo = [[NSThread alloc] initWithTarget:[MyObject class] selector:@selector(run) object:nil];
    [ticketsThreadtwo setName:@"Ticket-2"];
    [ticketsThreadtwo start];
    //[NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
    
    //主线程等子线程
    while(1){
        [[NSRunLoop currentRunLoop] run];
    }
    */

     //----- 
    
    int x;
    lock = [[NSLock alloc] init];//好像不对,两个线程都可以得到lock
    
    [NSThread detachNewThreadSelector:@selector(aMethod:) toTarget:[MyObject class] withObject:@"abc"];
    
    for(x=0;x<50;++x)
    {
        [lock lock];
        printf("Main thread says x is %i\n",x);
        usleep(10000);
     
        printf("Main thread lets go\n",x);
        [lock unlock];
        usleep(100);
    }
     
    return 0;
    
    }



