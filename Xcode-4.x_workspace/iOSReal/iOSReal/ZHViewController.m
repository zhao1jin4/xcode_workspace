//
//  ZHViewController.m
//  iOSReal
//
//  Created by LiZhaoJin on 13-4-24.
//  Copyright (c) 2013年 LiZhaoJin. All rights reserved.
//

#import "ZHViewController.h"
/*
 
 Bundle identifier用来区分不同的应用,如多个两个应用使用相同Bundle identifier,即使图标名字不同,一个也会被覆盖
 如修改Bundle identifier在模拟器上不能测试,只是黑屏,只要撤消修改,启动模拟器把原来已有的应用删除,再设置正确的值就就可在模拟器上测试了
 ---发布真机应用
 修改项目的iOS版本以真机版本对应,Targets中Build Settings->Deployment栏->iOS deployment target中选择正确的版本
 
 签名Provision :先安装.mobileprovision(会打开iPhone Configuration Utility),再安装.p12文件(会打开KeyChain,要密码的)
 
 Targets 项目->Build Settings->Code Signing卷栏->在Release/Debug中选iPhone Distrution(默认是iPhone Developer),在子级的Any iOS SDK 中选iPhone Distribution对应的证书
 Product->Edit Schema->Archive->Build Configuration中选Release,上面Destination下拉选择真实的iPad
 Product->archive 开始编译(应用的-info.plist文件中的Bundle identifier的值要和证书中的值一样),编译成功后会打开Organier窗口的Archives标签
 ->点Distrubte...->选择Save for Enterprise or Ad-Hoc Develoyment->Code Signing Identify:中默认(是本机上的证书对应的项)->保存为.ipa文件
 
 
 打开iTunes ,command + o 打开生成的.app, 会生成在/Users/zhaojin/Music/iTunes/iTunes Media/Mobile Applications/下有生成的.ipa文件
 iTunes 中选择左侧的Apps项,后把自己生成的.ipa拖入,左侧DEVICES栏中选择自己的设备->Apps按钮->复选Sync Apps->提示会覆盖->Apply/Sync按钮->提示中点Don not Authorized
 mac 版本 iTools中左侧 on this Mac 中选择apps->Add按钮选择.ipa文件->install提示没有安装AppSync,不能安装
 
 如提示timed out waiting for app to launch,可以看到背景色,是证书的原因,不可以调试,但包可以安装到真机ipad
 */
@interface ZHViewController ()

@end

@implementation ZHViewController
@synthesize  output;
@synthesize  arrow;
@synthesize touchView = _touchView;
@synthesize gestureView;

-(void)log:(NSString * )text
{
    NSLog(text);
    NSString *out=[NSString stringWithFormat:@"%@\n %@",output.text,text];
    [output setText:@""];
    [output setText:out];//UITextView
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //---指南针 ,不能自动旋转屏幕,要在.plist文件中的Supported Interface orientations和(iPad)两个中删除只留一个Portrait(bottom home button)
    compassLocationManager = [[CLLocationManager alloc] init];
    compassLocationManager.delegate = self;
    if(CLLocationManager.headingAvailable)
    {
        [compassLocationManager startUpdatingHeading];
        //[compassLocationManager stopUpdatingHeading];
    }
    else
    {
        [self log:@"指南针无效"];
        arrow.alpha=0.0f;
    }
    //---多于两点触模
    //[self.simpleView setMultipleTouchEnabled:YES];//isMultipleTouchEnabled
    //动态建立View
    self.touchView = [[ZHThreeTouchView alloc] initWithFrame:CGRectMake(400, 350, 320, 320)];
    _touchView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_touchView];
    

    //---多指 GestureRecognizer
    [self.gestureView setUserInteractionEnabled:YES];  
 
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [panGesture setMaximumNumberOfTouches:3];//可设几点触模
    [panGesture setMinimumNumberOfTouches:3];//
    panGesture.delaysTouchesEnded = NO;
    //panGesture.delegate=self;//UIGestureRecognizerDelegate
    [self.gestureView addGestureRecognizer:panGesture];
    
    //下面两个有效果,但有点小问题
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)];
    //[pinchRecognizer setDelegate:self];
    [self.gestureView addGestureRecognizer:pinchRecognizer];
    
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    //[rotationRecognizer setDelegate:self];
    [self.gestureView addGestureRecognizer:rotationRecognizer];
 
    //--
    
    // UISwipeGestureRecognizer ,UITapGestureRecognizer
    //---Proximity 接近 未测试
    UIDevice *currentDev=[UIDevice currentDevice];
    [currentDev setProximityMonitoringEnabled:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sensorStateChange:)
                                                 name:@"UIDeviceProximityStateDidChangeNotification"
                                               object:nil];
}
 

- (IBAction)printDeviceInfo:(id)sender {
    
    //---系统版本
    UIDevice *currentDev=[UIDevice currentDevice];
    NSString *version=[NSString stringWithFormat:@"当前设备系统: %@,版本: %@", currentDev.systemName,currentDev.systemVersion];
    //currentDev.systemName在iPad上的是iPhone OS , systemVersion的是6.0
    [self log:version];
    
    //---设备方向
    NSString *orien;
    switch(currentDev.orientation)
    {
        case  UIDeviceOrientationPortrait:
            orien=@"肖像";
            break;
        case  UIDeviceOrientationPortraitUpsideDown:
            orien=@"反肖像";
            break;
        case  UIDeviceOrientationLandscapeLeft:
            orien=@"风景左";
            break;
        case  UIDeviceOrientationLandscapeRight:
            orien=@"风景右";
            break;
        case  UIDeviceOrientationFaceUp:
            orien=@"正面上";
            break;
        case  UIDeviceOrientationFaceDown:
            orien=@"正面下";
            break;
        case  UIDeviceOrientationUnknown:
            orien=@"未知";
            break;
    }
    NSString *orienLog=[NSString stringWithFormat:@"当前设备的方向是: %@",orien];
    [self log:orienLog];
    
    //---电池状态
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    NSString *state;
    switch (currentDev.batteryState) {
        case UIDeviceBatteryStateUnplugged:
            state=@"未插电";
            break;
        case UIDeviceBatteryStateCharging:
            state=@"正在充电";
            break;
        case UIDeviceBatteryStateFull:
            state=@"已充满";
            break;
        case UIDeviceBatteryStateUnknown:
            state=@"未知";
            break;
        default:
            break;
    }
    NSString *battery=[NSString stringWithFormat:@"可用电量:%0.2f% ,电池状态:%@",currentDev.batteryLevel*100,state];
    [self log:battery];
    
    //---空间状态
    NSFileManager *fm=[NSFileManager defaultManager];
    NSError *myError=[[NSError alloc]init];
    NSDictionary *attr=[fm attributesOfFileSystemForPath:NSHomeDirectory() error:&myError];
    if(myError.code)
    {
        NSString *diskError=[NSString stringWithFormat:@"查可用存储空间错误,%@",[myError userInfo]];
        [self log:diskError];
    }else{
        long long val=[[attr objectForKey:NSFileSystemFreeSize]longLongValue];
        NSString *disk=[NSString stringWithFormat:@"存储可用空间:%lld MB",(val/1024)/1024];//long long使用%lld格式化输出
        [self log:disk];
    }
    
}

#pragma mark ---camera
-(IBAction)startCamera:(id)sender
{
    UIImagePickerController *camera = [[UIImagePickerController alloc] init];
	camera.delegate = self;//UIImagePickerControllerDelegate
	camera.allowsEditing = YES;
	
	//检查摄像头是否支持摄像机模式
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
        
		camera.sourceType = UIImagePickerControllerSourceTypeCamera;
        camera.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
	}
	else
	{
		[self log:@"本机没有Camera "];
		return;
	}
    camera.videoQuality = UIImagePickerControllerQualityTypeMedium;//UIImagePickerControllerQualityTypeHigh
    //camera.videoMaximumDuration = 30.0f; //秒,不可用于ImagePicker
    [self presentViewController:camera animated:YES completion:^{
        
    }];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info//UIImagePickerControllerDelegate
{
	[picker dismissModalViewControllerAnimated:YES];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
	if([mediaType isEqualToString:@"public.movie"])			//被选中的是视频
	{
		NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        //保存视频到相册
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];//AL=AssetLibrary
        [library writeVideoAtPathToSavedPhotosAlbum:url completionBlock:nil];
         
        
		//获取视频的某一帧作为预览
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];// <AVFoundation/AVFoundation.h>
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        gen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
        NSError *error = nil;
        CMTime actualTime;// <CoreMedia/CoreMedia.h>
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        UIImage *img = [[UIImage alloc] initWithCGImage:image];
        CGImageRelease(image);
        [self performSelector:@selector(saveImg:) withObject:img afterDelay:0.1];
      

	}
	else if([mediaType isEqualToString:@"public.image"])	//被选中的是图片
	{
        //获取照片实例
		UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
		
        //生成文件中
        NSDate *nowDate = [NSDate date];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"EEE-MMM-d"];
        NSString *locationString = [df stringFromDate:nowDate];
        NSString *fileName  =  [locationString stringByAppendingFormat:@".png"];
        
        NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
        [myDefault setValue:fileName forKey:@"fileName"];
        
        //保存到相册
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];//<AssetsLibrary/AssetsLibrary.h>
        [library writeImageToSavedPhotosAlbum:[image CGImage]
                                  orientation:(ALAssetOrientation)[image imageOrientation]
                              completionBlock:nil];
                
		[self performSelector:@selector(saveImg:) withObject:image afterDelay:0.0];
		 
	}
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker//UIImagePickerControllerDelegate的方法
{
	NSLog(@"Cameral 取消了");
	[picker dismissModalViewControllerAnimated:YES];
}

-(void)saveImg:(UIImage *) image
{
	NSLog(@"Review Image");
	self.cameraView.image = image;
}


#pragma mark -----compass
//指南针
#define toRad(X) (X*M_PI/180.0)
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    if (newHeading.headingAccuracy < 0)
        return;
    
    CLLocationDirection  theHeading = ((newHeading.trueHeading > 0) ?//0表示北,90表示东,180表示南,负数不能确定
                                       newHeading.trueHeading : newHeading.magneticHeading);
    [UIView     animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             CGAffineTransform headingRotation;
                             headingRotation = CGAffineTransformRotate(CGAffineTransformIdentity, (CGFloat)-toRad(theHeading));
                             arrow.transform = headingRotation;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    
    //CGFloat heading= -1.0f * M_PI * newHeading.magneticHeading / 180.0f;
    //arrow.transform=CGAffineTransformMakeRotation(heading);
}

#pragma mark ---Gesture
//自义方法
- (void)panDetected:(UIPanGestureRecognizer*)gestureRecognizer
{//移动图标
    switch ([gestureRecognizer state])
    {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint pt = [gestureRecognizer locationInView:self.view];
            NSLog(@"pt.x=%f,pt.y=%f",pt.x,pt.y);
            break;
        }
        case UIGestureRecognizerStateChanged://移动图标
        {
            CGPoint translation = [gestureRecognizer translationInView:[self.gestureView superview]];
            [self.gestureView setCenter:CGPointMake([self.gestureView center].x + translation.x, [self.gestureView center].y + translation.y)];
            [gestureRecognizer setTranslation:CGPointZero inView:[self.gestureView superview]];//清零
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            break;
        }
        default:
            break;
    }
}
-(void)scale:(id)sender {
    
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _lastScale = 1.0;
    }
    
    CGFloat scale = 1.0 - (_lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    
    CGAffineTransform currentTransform = self.gestureView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
    [self.gestureView setTransform:newTransform];
    
    _lastScale = [(UIPinchGestureRecognizer*)sender scale];
    
}
-(void)rotate:(id)sender {
    if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        _lastRotation = 0.0;
        return;
    }

    CGFloat rotation = 0.0 - (_lastRotation - [(UIRotationGestureRecognizer*)sender rotation]);
    
    CGAffineTransform currentTransform = self.gestureView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    
    [self.gestureView setTransform:newTransform];
    
    _lastRotation = [(UIRotationGestureRecognizer*)sender rotation];
    
}


#pragma mark --motion

-(BOOL)canBecomeFirstResponder//UIResponder的方法,发现一个运动事件,传给第一个响应者
{
    return YES;
}
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event//UIResponder的方法
{
    if(motion == UIEventSubtypeMotionShake)
    {
        [self log:@"晃动开始"];
    }
}
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event//UIResponder的方法
{
    if(motion == UIEventSubtypeMotionShake)
    {
        [self log:@"晃动结束"];
    }
}


#pragma mark --map


- (IBAction)continueUserLocation:(id)sender {

    //---手工启动定位,相当于MKMap 组件选中Shows User Location ,协议CLLocationManagerDelegate
    //模拟器中设所在位置 Debug->Location->custom location...  
    //纬度（正：北纬　负：南纬）latitude
    //经度（正：东经　负：西经）longitude
    
    //---MapKit 要加库 和 #import <MapKit/MapKit.h>
    //MKMapView *map=[MKMapView alloc]initWithFrame:(CGRect);
    
 
    
    BOOL ok = [CLLocationManager locationServicesEnabled];//要增加 CoreLocation.framework
    if (!ok) {
        [self log:@"CLLocationManager 启用失败"];
        return;
    }
    CLLocationManager* lm = [[CLLocationManager alloc] init];
    lm.desiredAccuracy=kCLLocationAccuracyBest;
    lm.distanceFilter=5.0f;//米
    lm.delegate=self;//CLLocationManagerDelegate
    
    //-------------
    [lm startUpdatingLocation];//做一次更新
    
//    CLLocationCoordinate2D center;
//    center.latitude = 31.23;//上海人民广场位于北纬31度23分,东经121度47分。
//    center.longitude=121.47;
    
    MKCoordinateSpan span;
    span.latitudeDelta=0.02;//精度
    span.longitudeDelta=0.02;
    MKCoordinateRegion region={lm.location.coordinate,span};
    mapView.delegate=self;
    [mapView setRegion:region];
    //地图标记,要实现协议 MKAnnotation
    MyMapAnnotation *anno=[[MyMapAnnotation alloc]initWithLocation:lm.location.coordinate];
    [mapView addAnnotation:anno];
    
    NSString *location=[NSString stringWithFormat:@"startUpdatingLocation latitude=%f , longitude=%f,speed=%f", lm.location.coordinate.latitude, lm.location.coordinate.longitude,lm.location.speed];
    [self log:location];
    [lm stopUpdatingLocation];
    //--------
    
    if ([CLLocationManager significantLocationChangeMonitoringAvailable])
    {
        [lm startMonitoringSignificantLocationChanges]; //连续得到用户移动方向,速度???
        //[lm startMonitoringForRegion:(CLRegion *)];//当用户进入指定区域,发出通知
    }
    else
    {
        NSLog(@"significantLocationChangeMonitoringAvailable not available.");
    }
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations//CLLocationManagerDelegate的方法
{
    NSString *location=[NSString stringWithFormat:@"in locationManager latitude=%f , longitude=%f", manager.location.coordinate.latitude, manager.location.coordinate.longitude];
    [self log:location];
 
    MKCoordinateSpan span;
    span.latitudeDelta=0.02;//精度
    span.longitudeDelta=0.02;
    MKCoordinateRegion region={ manager.location.coordinate,span};
    mapView.delegate=self;
   [mapView setRegion:region];
}
//-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation//CLLocationManagerDelegate的方法
//{
//    NSString *err=[NSString stringWithFormat:@"新位置信息:%@,速度=%@", [newLocation description],newLocation.speed];//description是NSString的,有altitude海拔,coordinate,
//    //course如0表示北,90东,180南,270西(使用CLHeading)
//    [self log:err];
//}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error//CLLocationManagerDelegate的方法
{
    NSString *err=[NSString stringWithFormat:@"定位服务失败,原因:%@", [error description]];
    [self log:err];
}
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation//MKMapViewDelegate的方法
{
    //MKMap 组件选中Shows User Location,调用此方法,会弹出话框问是否允许仿问位置,如不能连网的错误处理???
    NSString *location=[NSString stringWithFormat:@"in didUpdateUserLocation latitude=%f , longitude=%f",  userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude];
    [self log:location];
    CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
    MKCoordinateRegion reg =MKCoordinateRegionMakeWithDistance(coordinate, 600, 600);//加MapKit.framework和#import <MapKit/MapKit.h>
    mapView.region = reg;
}

//自义方法,用于距离
-(void)sensorStateChange:(NSNotificationCenter *)notification;
{
    if ([[UIDevice currentDevice] proximityState] == YES) {
        [self log:@"设备和用户的距离很近"];
        //在此写接近时，要做的操作逻辑代码
    }else{
         [self log:@"设备和用户的距离很远"];
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
