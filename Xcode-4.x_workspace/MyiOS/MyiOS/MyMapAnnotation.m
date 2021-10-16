//
//  MyMapAnnotation.m
//  MyiOS
//
//  Created by LiZhaoJin on 13-4-17.
//  Copyright (c) 2013年 zhaojin . All rights reserved.
//

#import "MyMapAnnotation.h"

@implementation MyMapAnnotation  //要实现协议MKAnnotation ,标记地图位置加信息
-(id)initWithLocation:(CLLocationCoordinate2D)_center
{
    center=_center;
    return [self init];
}
-(CLLocationCoordinate2D)coordinate
{
    return center;
}
-(NSString *)title
{
    return @"上海标题";
}
-(NSString *)subtitle
{
    return @"上海子标题";
}
@end
