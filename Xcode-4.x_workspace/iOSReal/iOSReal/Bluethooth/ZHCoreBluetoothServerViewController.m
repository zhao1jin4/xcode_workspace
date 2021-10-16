//
//  ZHCoreBluetoothServerViewController.m
//  iOSReal
//
//  Created by LiZhaoJin on 13-6-20.
//  Copyright (c) 2013年 LiZhaoJin. All rights reserved.
//

#import "ZHCoreBluetoothServerViewController.h"
#import "TransferService.h"
@interface ZHCoreBluetoothServerViewController ()<CBPeripheralManagerDelegate, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView       *textView;
@property (strong, nonatomic) IBOutlet UISwitch         *advertisingSwitch;
@property (strong, nonatomic) CBPeripheralManager       *peripheralManager;
@property (strong, nonatomic) CBMutableCharacteristic   *transferCharacteristic;
@property (strong, nonatomic) NSData                    *dataToSend;
@property (nonatomic, readwrite) NSInteger              sendDataIndex;
@end

#define NOTIFY_MTU      20
@implementation ZHCoreBluetoothServerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSLog(@"-------1  [CBPeripheralManager alloc]");
    //self.textView.delegate=self;
    _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.peripheralManager stopAdvertising];
    [super viewWillDisappear:animated];
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil]; //modal方式返回
    //[self performSegueWithIdentifier:@"goSecond" sender:self];//storyboard 方式
    
    //可以拖一个ViewController中的按钮到另一个ViewController -> push,要求前面是一个NavigationController 以Relationship Segue拖入
    //push方式多一个工具栏自带返回按钮
    
}

/** Required protocol method.  A full app should take care of all the possible states,
 *  but we're just waiting for  to know when the CBPeripheralManager is ready
 */
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    // Opt out from any other state
    if (peripheral.state != CBPeripheralManagerStatePoweredOn) {
        return;
    }
    
    // We're in CBPeripheralManagerStatePoweredOn state...
    NSLog(@"-------2  peripheralManagerDidUpdateState ");
    NSLog(@"self.peripheralManager powered on.");
    
    // ... so build our service.
    
    // Start with the CBMutableCharacteristic
    self.transferCharacteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]
                                                                     properties:CBCharacteristicPropertyNotify
                                                                          value:nil
                                                                    permissions:CBAttributePermissionsReadable];
    
    // Then the service
    CBMutableService *transferService = [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]
                                                                       primary:YES];
    
    // Add the characteristic to the service
    transferService.characteristics = @[self.transferCharacteristic];
    
    // And add it to the peripheral manager
    [self.peripheralManager addService:transferService];
}


/** Catch when someone subscribes to our characteristic, then start sending them data
 */

- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"-------4  didSubscribeToCharacteristic ");
    NSLog(@"Central subscribed to characteristic");
    
    // Get the data
    self.dataToSend = [self.textView.text dataUsingEncoding:NSUTF8StringEncoding];
    
    // Reset the index
    self.sendDataIndex = 0;
    
    // Start sending
    [self sendData];
}


/** Recognise when the central unsubscribes
 */
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"-------5   didUnsubscribeFromCharacteristic ");
    NSLog(@" Central unsubscribed from characteristic");
}


/** Sends the next amount of data to the connected central
 */
- (void)sendData
{
    // First up, check if we're meant to be sending an EOM
    static BOOL sendingEOM = NO;
//    
//    if (sendingEOM) {
//        
//        // send it
//        BOOL didSend = [self.peripheralManager updateValue:[@"EOM" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
//        
//        // Did it send?
//        if (didSend) {
//            
//            // It did, so mark it as sent
//            sendingEOM = NO;
//            
//            NSLog(@"Sent: EOM");
//        }
//        
//        // It didn't send, so we'll exit and wait for peripheralManagerIsReadyToUpdateSubscribers to call sendData again
//        return;
//    }
//    
    // We're not sending an EOM, so we're sending data
    
    // Is there any left to send?
    
    if (self.sendDataIndex >= self.dataToSend.length) {
        
        // No data left.  Do nothing
        return;
    }
    
    // There's data left, so send until the callback fails, or we're done.
    
    BOOL didSend = YES;
    
    while (didSend) {
        
        // Make the next chunk
        
        // Work out how big it should be
        NSInteger amountToSend = self.dataToSend.length - self.sendDataIndex;
        
        // Can't be longer than 20 bytes
        if (amountToSend > NOTIFY_MTU) amountToSend = NOTIFY_MTU;
        
        // Copy out the data we want
        NSData *chunk = [NSData dataWithBytes:self.dataToSend.bytes+self.sendDataIndex length:amountToSend];
        
        // Send it
        didSend = [self.peripheralManager updateValue:chunk forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
        //中间数据有时不能发成功,返回NO,刚刚好第一次YES,第二NO,都是隔一次成功一次
        NSLog(@"--------4   1 x in sendData   didSend=: %d", didSend);
        // If it didn't work, drop out and wait for the callback
        if (!didSend) {
            return;
        }
        
        NSString *stringFromData = [[NSString alloc] initWithData:chunk encoding:NSUTF8StringEncoding];
        NSLog(@"Sent: %@", stringFromData);
        
        // It did send, so update our index
        self.sendDataIndex += amountToSend;
        
        // Was it the last one?
        if (self.sendDataIndex >= self.dataToSend.length) {
            
            // It was - send an EOM
            
            // Set this so if the send fails, we'll send it next time
            sendingEOM = YES;
            
            // Send it
            BOOL eomSent = [self.peripheralManager updateValue:[@"EOM" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
            
            if (eomSent) {
                // It sent, we're all done
                sendingEOM = NO;
                
                NSLog(@"Sent: EOM");
            }
            
            return;
        }
    }
}


/** This callback comes in when the PeripheralManager is ready to send the next chunk of data.
 *  This is to ensure that packets will arrive in the order they are sent
 */

- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral
{
    NSLog(@"-------4   2  x failed send again , peripheralManagerIsReadyToUpdateSubscribers ");
    NSLog(@"peripheralManagerIsReadyToUpdateSubscribers");
    
    // Start sending again
    [self sendData];
}



#pragma mark - TextView Methods
/*
- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"------111---textViewDidChange");
    // If we're already advertising, stop
    if (self.advertisingSwitch.on) {
        [self.advertisingSwitch setOn:NO];
        [self.peripheralManager stopAdvertising];
    }
}
 
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    NSLog(@"------111---textViewDidBeginEditing");
 
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard)];
    self.navigationItem.rightBarButtonItem = rightButton;
}
 
- (void)dismissKeyboard
{
    NSLog(@"------111---dismissKeyboard");
    [self.textView resignFirstResponder];
    self.navigationItem.rightBarButtonItem = nil;
}
 */



#pragma mark - Switch Methods
- (IBAction)switchChanged:(id)sender
{ 
    if (self.advertisingSwitch.on) {
        // All we advertise is our service's UUID
        [self.peripheralManager startAdvertising:@{ CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]] }];
        
        NSLog(@"-------3  startAdvertising");
    }
    
    else {
        [self.peripheralManager stopAdvertising];
    }
}



@end
