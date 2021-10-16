//
//  ZHThreeTouchView.h
//  iOSReal
//
//  Created by LiZhaoJin on 13-4-25.
//  Copyright (c) 2013年 LiZhaoJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHThreeTouchView : UIView
{
    NSString *_draw;
}
@property (nonatomic) CGPoint centerPoint;
@property (nonatomic) CGPoint beginPoint;
@property (nonatomic) CGPoint endPoint;


@property (strong, nonatomic) NSMutableArray *array_points_1;
@property (strong, nonatomic) NSMutableArray *array_points_2;
@property (strong, nonatomic) NSMutableArray *array_points_3;

@end
