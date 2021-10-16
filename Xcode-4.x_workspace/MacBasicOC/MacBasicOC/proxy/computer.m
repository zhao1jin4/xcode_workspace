#import "computer.h"

@implementation Computer
	@synthesize delegate;
	@synthesize ID;
	-(id)init //NSObject的方法
	{
		printf("Computer init \n");
		self=[super init];
		timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFunc:) userInfo:nil repeats:YES];
		//定时器,每隔1秒调用myFunction,  userInfo表示参数
        return self;//要return
	}

	-(void)dealloc
	{
		printf("Computer dealloc! \n");
		[super dealloc];
		//[positionCallBack release];//GnuSetup不认^
	}

-(void)timerFunc:(id)arg//要有(id)类型的参数
	{
		count++;
		NSLog(@"Computer timerFunc times %d",count);
        
		[delegate onMove:100+count y:count];//optional
		[delegate onClick];
		
		if(positionCallBack)//block可以做判断,GnuSetup不认^
			positionCallBack(100+count,count);//调用,//GnuSetup不认^
		
	}
 
-(void) setPositionCallBack:(  void (^)(int x,int y)  )callback//GnuSetup不认^
  {
	[positionCallBack release];//也要release
	positionCallBack=[callback copy];//copy为防止销毁
  }
 
@end
 