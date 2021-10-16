//
//  MyMainClass.h
//  MyMac
//
//  Created by zhaojin  on 12-11-8.
//  Copyright (c) 2012年 zhaojin . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyMainClass : NSObject
{
	IBOutlet NSTextField* textUsername;
	IBOutlet NSTextField* textPassword;//设计器修改关联类为 NSSecureTextField
	IBOutlet NSTextField* textStatus;
	IBOutlet NSWindow* mainWindow;
	IBOutlet NSWindow* credentialWindow;
    NSDictionary *boldYellowDict;
	
}

-(IBAction)submitClicked:(id)sender;
-(IBAction)cancelClicked:(id)sender;
-(IBAction)showCredentialWindow:(id)sender;
@end
