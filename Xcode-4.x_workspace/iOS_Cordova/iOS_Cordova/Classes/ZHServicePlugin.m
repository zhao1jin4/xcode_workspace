//
//  ZHServicePlugin.m
//  iOS_Cordova
//
//  Created by LiZhaoJin on 13-5-3.
//
//

#import "ZHServicePlugin.h"

@implementation ZHServicePlugin
- (void)echo:(CDVInvokedUrlCommand*)command //方法签名
{
    CDVPluginResult* pluginResult = nil;
    NSString* myarg = [command.arguments objectAtIndex:0];
    NSString* res=[NSString stringWithFormat:@"hello %@",myarg];
    if (myarg != nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:res];
        //静态方法,也可带参数messageAsXxx,String, Int, Double, Bool, Array, Dictionary, ArrayBuffer, and Multipart
        //messageAsArrayBuffer要使用NSData* 做参数,JS端也是NSData*
        //messageAsMultipart要使用NSArray* 做参数,
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Arg was null"];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    //commandDelegate 在CDVPlugin.h中,sendPluginResult方法是线程安全的
}

@end
