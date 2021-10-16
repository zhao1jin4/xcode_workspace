//
//  ZHBluethoothViewController.h
//  iOSReal
//
//  Created by LiZhaoJin on 13-6-7.
//  Copyright (c) 2013年 LiZhaoJin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
@interface ZHBluethoothViewController : UIViewController <GKPeerPickerControllerDelegate, GKSessionDelegate>
{
    GKSession				*currentSession;
	GKPeerPickerController	*picker;
    NSString* loginId;
     UITextView *output;
   IBOutlet  UITextField *txtLine;
}
@property IBOutlet UITextView *output;
@end
