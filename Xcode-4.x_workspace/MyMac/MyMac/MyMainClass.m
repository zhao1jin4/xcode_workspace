//
//  MyMainClass.m
//  MyMac
//
//  Created by zhaojin  on 12-11-8.
//  Copyright (c) 2012年 zhaojin . All rights reserved.
//

#import "MyMainClass.h"
#import "ZHUserBean.h"

#define singleObj [ZHUserBean singleInstance]  // #define的使用
#define ZHLog(str) NSLog(@"%@",str)

//下拉选择Objects& controllers 拖动Object到设计界面左侧工具栏上，属性面板选择关联的类名，如删除，选中按delete
//下拉选择Windows & Menus 可拖窗口，选中窗口在Attribute Inspector中取消复选Resize,Visible At Launch

@implementation MyMainClass //用于关联界面组件

-(IBAction)submitClicked:(id)sender
{
	singleObj.userName=[textUsername stringValue];
	singleObj.userPass=[textPassword stringValue];//NSSecureTextField
    
    NSLog(@"登录验证结果,%d",[singleObj checkLogin]);
    ZHLog(@"日志");
    
    //--调用系统命令 , 管道
	NSString* value=[NSString stringWithFormat:@"%@ %@" ,singleObj.userName,singleObj.userPass];
	NSArray* arguments =[NSArray arrayWithObject:value];
	NSPipe* pipe=[NSPipe pipe]; //Pipe
	NSFileHandle *file =[pipe fileHandleForReading];//使用临时文件来读管道
	
	NSTask* task =[[NSTask alloc]init];
	[task setLaunchPath:@"/bin/echo"];//调用系统命令，可用curl 命令做 webService client
	[task setArguments:arguments];
	[task setStandardOutput:pipe];//命令 标准输出 到 管道(是文件)
	[task launch];
	
	NSData* data=[file readDataToEndOfFile];//文件->管道->标准输出 ,读,如不启动任务，这里会阻塞
	NSString *string =[[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]autorelease];
	NSLog(@"get user and password is :%@",string);
	[task release];
    
    //#progma mark -
    //#progma mark MyParseXML
   //mark 后的内容,只起标记作用,相当于标签,可以快速定位, 如是- 是分隔线,编译失败????
    
    //--解析XML
	NSString *xmlString=@"<root><userid>123</userid><age>30</age><birthDay>1988-08-08</birthDay></root";
	if([xmlString rangeOfString:@"error"].location == NSNotFound)
    {
        NSLog(@"验证成功");
    }
    
    NSError *error;
	NSXMLDocument *xmlDoc =[[NSXMLDocument alloc]initWithXMLString:xmlString options:NSXMLDocumentTidyXML error:&error];//&的使用
	NSXMLElement *root=[xmlDoc rootElement];
	NSArray* array=	[root nodesForXPath:@"//age" error:&error];
	NSString *age=[[array objectAtIndex:0]stringValue];
	NSLog(@"XML Parsed age=:%@",age);
	
    
	//--关闭窗口
	[NSApp endSheet:[sender window]];//sender window是过时的
	[[sender window] orderOut:self];

	//--弹Alert窗口
	NSAlert *alert=[[NSAlert alloc]init];
	[alert addButtonWithTitle:@"OK"];
	[alert setMessageText:@"我的提示噢！"];
	[alert setInformativeText:@"内容"];
	[alert setAlertStyle:NSWarningAlertStyle];
	
	[alert beginSheetModalForWindow:mainWindow modalDelegate:self	 didEndSelector:nil contextInfo:nil];
    
}
-(IBAction)cancelClicked:(id)sender //关闭窗口,sender 是按钮
{
	[NSApp endSheet:[sender window]];//sender window方法是过时的
	[[sender window] orderOut:self];
}
-(IBAction)showCredentialWindow:(id)sender
{
	[NSApp beginSheet:credentialWindow 
	   modalForWindow:mainWindow
		modalDelegate:nil
	   didEndSelector:nil
		  contextInfo:NULL];//弹出窗口
	
}


-(void)mySelector:(NSNotification*)anotification//所有的文本框改变都会被调用
{
    NSLog(@"invoked");
    NSUInteger size=[[textUsername stringValue] length];
	NSString* statusText=[NSString stringWithFormat:@"The Username count:%ld" ,size ];
    
    NSAttributedString *attr=[[NSAttributedString alloc]initWithString:statusText attributes:boldYellowDict];//修改文字外观
    [textStatus setAttributedStringValue:attr];
    
    //[textStatus setStringValue:statusText];
}
-(void)awakeFromNib //NSNibAwaking Protocol
{
	[[NSNotificationCenter defaultCenter]addObserver:self
											selector:@selector(mySelector:)
												name:NSTextDidChangeNotification
										  object:nil];//注册通知
	//设置颜色
	[textStatus setFont:[NSFont fontWithName:@"Message" size:18]];
	[textStatus setTextColor:[NSColor redColor]];
	 
    
    boldYellowDict=[[NSDictionary alloc]initWithObjectsAndKeys:
                            [NSColor yellowColor],NSForegroundColorAttributeName,
                            [NSFont boldSystemFontOfSize:11.0],NSFontAttributeName,
                            nil];
	
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter]removeObserver:self
												   name:NSTextDidChangeNotification
												 object:nil];//取消注册通知
	[boldYellowDict release];
    [super dealloc];
}

@end
