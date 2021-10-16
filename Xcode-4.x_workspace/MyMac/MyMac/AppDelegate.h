//
//  AppDelegate.h
//  MyMac
//
//  Created by zhaojin  on 12-11-4.
//  Copyright (c) 2012年 zhaojin . All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <GLUT/GLUT.h>
@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSTextField *fieldOne;
    IBOutlet NSTextField *fieldTwo;
    IBOutlet NSTextField *fieldResult;
    
	IBOutlet NSTextField *textAge;
	IBOutlet NSTextField *textResult;
	IBOutlet NSTextView *textURL;


}
@property (assign) IBOutlet NSWindow *window;
-(IBAction)comapreButtonClicked:(id)sender;
-(IBAction)buttonClicked:(id)sender;
-(IBAction)openBrowserClicked:(id)sender;
@end
