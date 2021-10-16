//
//  ZHAcceleroViewController.h
//  iOSReal
//
//  Created by LiZhaoJin on 13-6-3.
//  Copyright (c) 2013年 LiZhaoJin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
@interface ZHAcceleroViewController : UIViewController
{
    CMMotionManager *motionManager;
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *accelerationX;
    IBOutlet UILabel *accelerationY;
    IBOutlet UILabel *accelerationZ;
}
@end
