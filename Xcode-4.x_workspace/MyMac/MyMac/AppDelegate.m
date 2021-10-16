//
//  AppDelegate.m
//  MyMac
//
//  Created by zhaojin  on 12-11-4.
//  Copyright (c) 2012年 zhaojin . All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate


+(void)initialize//NSObject的方法,static方法
{
    
    //会记录在 ~/Library/Preferences/<包名>.<项目名>.plist,
    //包名是配置在 Supporting Files/<Project>－info.plist文件中bundle identifier中
	NSUserDefaults * userDef=[NSUserDefaults standardUserDefaults];
	NSString *setting = [NSString stringWithFormat:@"http://www.baidu.com\n" @"http://cn.bing.com"];

    
	NSDictionary *dict= [NSDictionary dictionaryWithObjectsAndKeys:setting,@"urls",nil];
	[userDef registerDefaults:dict];//加新的记录
    
   //Dock中显示新消息数
    NSDockTile *dockTile = [NSApp dockTile];
    [dockTile setBadgeLabel:@"10"];
    [dockTile display];
}
-(void)awakeFromNib//NSNibAwaking的方法
{
    
	NSUserDefaults * userDef=[NSUserDefaults standardUserDefaults];
	NSString * urls=[userDef objectForKey:@"urls"];//取值
	[textURL setString:urls];
}

-(NSMenu *)applicationDockMenu:(NSApplication *)sender //Dock上加菜单,NSApplicationDelegate,也可.xib中右击Application->dockMenu关联菜单
{
    NSMenu *menu = [[[NSMenu alloc] initWithTitle:@"DocTile Menu"]//修改默认标题
                    autorelease];
    NSMenuItem *item = [[[NSMenuItem alloc] initWithTitle:@"Hello"
                                                   action:@selector(hello) keyEquivalent:@"k"] autorelease];
    [menu addItem:item];
    return menu;
}
- (void) hello {
    [[NSAlert alertWithMessageText:@"Hello!" defaultButton:@"OK"
                   alternateButton:nil otherButton:nil
         informativeTextWithFormat:@"Hello Message!"] runModal];
}

-(IBAction)comapreButtonClicked:(id)sender //选中按钮，属性页中有一个,key equiivalent设置回车键
{
    NSString * one=[fieldOne stringValue];
    NSString * two =[fieldTwo stringValue];
    if([one isEqualToString:two])
    {
        [fieldResult setStringValue:@"exactly equal"];
    }else if([one localizedCaseInsensitiveCompare:two]==0)//不区分大小写
    {
         [fieldResult setStringValue:@"is equal"];
    }else
    {
        [fieldResult setStringValue:@"not equal"];
    }
}

-(IBAction)buttonClicked:(id)sender
{
     NSLog(@"当前调用的方法是:%s",__PRETTY_FUNCTION__);
    
	int age=[textAge intValue];
	NSString* result=(age>18)?@"Audlt":(age>13)?@"Teenager":@"Child";
	[textResult setStringValue:result];
}

-(IBAction)openBrowserClicked:(id)sender
{
	NSString* urls=[textURL string];
	NSArray* array=[urls componentsSeparatedByString:@"\n"];
	for(NSString* url in array )
	{
		[[NSWorkspace sharedWorkspace]openURL:[NSURL URLWithString:url]];//使用浏览器打开URL
	}
}
-(void)applicationWillTerminate:(NSNotification *)notification//AppDelegate的方法
{
    //要在Dock中退出，而不是在Xcode中停止
	NSUserDefaults * userDef=[NSUserDefaults standardUserDefaults];
	[userDef setObject:[textURL string] forKey:@"urls"];
	[userDef synchronize];//更新值
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
}

@end
