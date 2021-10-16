//
//  MyMapAnnotation.h
//  MyiOS
//
//  Created by LiZhaoJin on 13-4-17.
//  Copyright (c) 2013年 zhaojin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyMapAnnotation : NSObject<MKAnnotation> //要实现协议MKAnnotation ,标记地图位置加信息
{
    CLLocationCoordinate2D center;
}
-(id)initWithLocation:(CLLocationCoordinate2D)_center;
@end
