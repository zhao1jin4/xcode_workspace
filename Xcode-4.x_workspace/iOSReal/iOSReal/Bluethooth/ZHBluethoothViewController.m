//
//  ZHBluethoothViewController.m
//  iOSReal
//
//  Created by LiZhaoJin on 13-6-7.
//  Copyright (c) 2013年 LiZhaoJin. All rights reserved.
//

#import "ZHBluethoothViewController.h"

@interface ZHBluethoothViewController ()

@end

@implementation ZHBluethoothViewController
@synthesize output;

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
    NSUUID *uuid=[[UIDevice currentDevice] name];//唯标识
    loginId=  [uuid description];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)log:(NSString * )text
{
    NSLog(text);
    NSString *out=[NSString stringWithFormat:@"%@\n %@",output.text,text];
    [output setText:@""];
    [output setText:out];//UITextView
}


//[self.currentSession disconnectFromAllPeers];

- (IBAction)bluetoothConnect:(id)sender {
    //只可两台设备之间连接,不可第三台,可用模拟器
    picker = [[GKPeerPickerController alloc] init];
    picker.delegate = self;//GKPeerPickerControllerDelegate
    picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
    [picker show];
}

//GKPeerPickerControllerDelegate,弹出连接窗口之前调用，确定连接类型
- (GKSession *) peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type {
     NSLog(@"bluetooth 建立连接之前 1");
    GKSession* temp=  [[GKSession alloc] initWithSessionID:@"MyBluetoothAppID" displayName:nil sessionMode:GKSessionModePeer];
    return temp;
}

-(void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString*)peerID toSession:(GKSession *)session{
    NSLog(@"bluetooth 接受了连接 2");
	session.delegate=self;//GKSessionDelegate
	[session setDataReceiveHandler:self withContext:nil];
	 currentSession=session;
    picker.delegate=nil;
	[picker dismiss];
    
	
}
//对应setDataReceiveHandler必须是
-(void)receiveData:(NSData*)data fromPeer:(NSString*)peer inSession:(GKSession*)session context:(void*)context
{
	NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self log:aStr];//接受数据
}
//GKSessionDelegate
-(void)session:(GKSession*)session peer:(NSString*)peerID didChangeState:(GKPeerConnectionState)state
{
	switch (state) {
		case GKPeerStateConnected:
			[currentSession setDataReceiveHandler :self withContext:nil];
            //setDataReceiveHandler必须是 - (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context;
            [self log:@"bluetooth 连接了 3"];
			break;
		case GKPeerStateDisconnected:
			  [self log:@"bluetooth 连接断开 3"];
              currentSession=nil;
			break;
            
	}
}

//GKPeerPickerControllerDelegate
- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker {
    printf("bluetooth 连接尝试被取消 \n");
}
- (IBAction)bluetoothSend:(id)sender {
    NSString *strSend=[NSString stringWithFormat:@"%@ say: %@",loginId,txtLine.text];
    NSData* data=[strSend dataUsingEncoding:NSUTF8StringEncoding];
    txtLine.text=@"";
    if (currentSession) {
        NSError* err;
		[currentSession sendDataToAllPeers:data withDataMode:GKSendDataReliable error:&err];
        if(err)
            [self log:err.description];

	}
}


@end
