//
//  ZHAppDelegate.h
//  OpenGLES
//
//  Created by LiZhaoJin on 13-4-27.
//  Copyright (c) 2013年 LiZhaoJin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenGLView.h"
@interface ZHAppDelegate : UIResponder <UIApplicationDelegate>
{
    OpenGLView* _glView;
}
@property (strong, nonatomic)IBOutlet UIWindow *window;
@property (strong, retain) IBOutlet OpenGLView *glView;
@end
