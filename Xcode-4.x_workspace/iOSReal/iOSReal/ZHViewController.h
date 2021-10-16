//
//  ZHViewController.h
//  iOSReal
//
//  Created by LiZhaoJin on 13-4-24.
//  Copyright (c) 2013年 LiZhaoJin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

//--camera
#import <AssetsLibrary/AssetsLibrary.h>
#import  <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
//--
#import "ZHThreeTouchView.h"
#import "MyMapAnnotation.h"
@interface ZHViewController : UIViewController<MKMapViewDelegate,UIAccelerometerDelegate,CLLocationManagerDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate>
{
    UIAccelerometer *_accelerometer;
    BOOL isCamera;
    
    CLLocationManager* compassLocationManager;//为指南针
    
   IBOutlet MKMapView *mapView;
    
    float _lastScale;
    float _lastRotation;
    float _firstX;
    float _firstY;
    
}
@property(nonatomic) UIImageView *touchView;

@property(nonatomic) IBOutlet UITextView *output;
@property(nonatomic) IBOutlet UIImageView *arrow;
@property(nonatomic) IBOutlet UIImageView *cameraView;
@property(nonatomic) IBOutlet UIImageView *gestureView;
-(IBAction)startCamera:(id)sender;


@end
