//
//  ZHServicePlugin.h
//  iOS_Cordova
//
//  Created by LiZhaoJin on 13-5-3.
//
//


 #import <Cordova/CDV.h>
@interface ZHServicePlugin : CDVPlugin//也可覆盖其它方法,如 pause, resume,
- (void)echo:(CDVInvokedUrlCommand*)command;//方法签名
@end
