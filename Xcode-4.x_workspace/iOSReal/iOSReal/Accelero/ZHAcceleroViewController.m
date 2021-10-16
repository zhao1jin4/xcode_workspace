//
//  ZHAcceleroViewController.m
//  iOSReal
//
//  Created by LiZhaoJin on 13-6-3.
//  Copyright (c) 2013年 LiZhaoJin. All rights reserved.
//

#import "ZHAcceleroViewController.h"

@interface ZHAcceleroViewController ()

@end


@implementation ZHAcceleroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
     motionManager = [[CMMotionManager alloc] init];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//---加速度 加CoreMontion.framework,#import <CoreMotion/CoreMotion.h>
- (void)startDrifting:(UIImageView *)imgView
{
    [motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
     //这里会不停的被调用1
        
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            //这里会不停的被调用2
            CGRect imgFrame = imgView.frame;//imgFrame是临时的
            NSLog(@"x increment valu=%f",accelerometerData.acceleration.x * 4);
            imgFrame.origin.x += accelerometerData.acceleration.x * 4;
            if(!CGRectContainsRect(self.view.bounds, imgFrame))
               imgFrame.origin.x = imgView.frame.origin.x;
            
            imgFrame.origin.y -= accelerometerData.acceleration.y * 4; //减法,方向是反的
            if(!CGRectContainsRect(self.view.bounds, imgFrame))
              imgFrame.origin.y = imgView.frame.origin.y;
           
           NSLog(@"before imgView.frame    ,x=%f,y=%f",imgView.frame.origin.x ,imgView.frame.origin.y);
           imgView.frame = imgFrame;//这里修改下次读的值还是老值,每次都一样,无效???

           NSLog(@"imgFrame.origin ,x=%f,y=%f",imgFrame.origin.x      ,imgFrame.origin.y);
           NSLog(@"imgView.frame    ,x=%f,y=%f",imgView.frame.origin.x ,imgView.frame.origin.y);
            
            accelerationX.text = [NSString stringWithFormat:@"accelerationX : %f", accelerometerData.acceleration.x];
            accelerationY.text = [NSString stringWithFormat:@"accelerationY : %f", accelerometerData.acceleration.y];
            accelerationZ.text = [NSString stringWithFormat:@"accelerationZ : %f", accelerometerData.acceleration.z ];//不动时保持在-0.98左右,向下加速变到-1.x
        });
    }];
}
- (IBAction)driftingImage:(UIButton *)sender
{
    if ([motionManager isAccelerometerActive]) {
        [motionManager stopAccelerometerUpdates];
    } else {
        [self startDrifting:imageView];
    }
}


@end
