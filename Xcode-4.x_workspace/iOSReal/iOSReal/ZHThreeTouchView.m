//
//  ZHThreeTouchView.m
//  iOSReal
//
//  Created by LiZhaoJin on 13-4-25.
//  Copyright (c) 2013年 LiZhaoJin. All rights reserved.
//

#import "ZHThreeTouchView.h"

@implementation ZHThreeTouchView
@synthesize beginPoint = _beginPoint;
@synthesize endPoint = _endPoint;
@synthesize centerPoint = _centerPoint;
@synthesize array_points_1 = _array_points_1;
@synthesize array_points_2 = _array_points_2;
@synthesize array_points_3 = _array_points_3;

- (id)initWithFrame:(CGRect)frame
{
     _array_points_1 = [NSMutableArray arrayWithCapacity:10];
     _array_points_2 = [NSMutableArray arrayWithCapacity:10];
     _array_points_3 = [NSMutableArray arrayWithCapacity:10];
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)drawRect:(CGRect)rect //继承自UIView,setNeedsDisplay后调用
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if([_draw isEqualToString:@"line"])
    {
        [self drawLine:context];//单指触模
    } else if ([_draw isEqualToString:@"rectangle"])
    {
        [self drawRectangle:context];//两指触模
    } else if ([_draw isEqualToString:@"curve"])
    {
        [self drawCurve:context];//三指触模
    }else if( [_draw isEqualToString:@"circle"])
    {
        [self drawCircle:context];
    }
}
//启用多点触摸
-(BOOL)isMultipleTouchEnabled
{
    return  YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch=[touches anyObject];
    if([touch tapCount]==2)
    {
        _draw=@"circle";
        self.centerPoint=[touch locationInView:self];
        [self setNeedsDisplay];//调用drawRect
        return ;
    }
    
    if([touches count]==1)
    {
        _draw=@"line";
        self.beginPoint = [touch locationInView:self];
    }else if([touches count]==2)
    {
        _draw=@"rectangle";
        NSArray *fingers=[touches allObjects];
        UITouch *first=[fingers objectAtIndex:0];
        UITouch *second=[fingers objectAtIndex:1];
        
        self.beginPoint=[first locationInView:self];
        self.endPoint=[second locationInView:self];
    }else if([touches count]==3)
    {
        _draw=@"curve";
        NSArray *fingers=[touches allObjects];
        
        UITouch *first=[fingers objectAtIndex:0];
        UITouch *second=[fingers objectAtIndex:1];
        UITouch *third=[fingers objectAtIndex:2];
        
        CGPoint p_first=[first locationInView:self];
        CGPoint p_second=[second locationInView:self];
        CGPoint p_third=[third locationInView:self];
        [_array_points_1 addObject:[NSValue valueWithCGPoint:p_first]];
        [_array_points_2 addObject:[NSValue valueWithCGPoint:p_second]];
        [_array_points_3 addObject:[NSValue valueWithCGPoint:p_third]];
        
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([touches count]==1)
    {
        UITouch *touch = [touches anyObject];
        self.endPoint = [touch locationInView:self];
    }else if([touches count]==2)
    {
        NSArray *fingers=[touches allObjects];
        UITouch *first=[fingers objectAtIndex:0];
        UITouch *second=[fingers objectAtIndex:1];
        
        self.beginPoint=[first locationInView:self];
        self.endPoint=[second locationInView:self];
    }else if([touches count]==3)
    {
        
        NSArray *fingers=[touches allObjects];
        
        UITouch *first=[fingers objectAtIndex:0];
        UITouch *second=[fingers objectAtIndex:1];
        UITouch *third=[fingers objectAtIndex:2];
        
        CGPoint p_first=[first locationInView:self];
        CGPoint p_second=[second locationInView:self];
        CGPoint p_third=[third locationInView:self];
        [_array_points_1 addObject:[NSValue valueWithCGPoint:p_first]];
        [_array_points_2 addObject:[NSValue valueWithCGPoint:p_second]];
        [_array_points_3 addObject:[NSValue valueWithCGPoint:p_third]];
        
    }
    
    [self setNeedsDisplay];//调用drawRect
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_array_points_1 removeAllObjects];
    [_array_points_2 removeAllObjects];
    [_array_points_3 removeAllObjects];
}

//自定义方法
- (void)drawLine:(CGContextRef)_context  //OK
{
    CGContextMoveToPoint(_context, _beginPoint.x, _beginPoint.y);
    CGContextAddLineToPoint(_context, _endPoint.x, _endPoint.y);
    CGContextSetLineWidth(_context, 5);
    CGContextSetRGBFillColor(_context, 0, 0, 0, 1);
    CGContextStrokePath(_context);
}

- (void)drawRectangle:(CGContextRef)_context
{
    CGRect rect = CGRectMake(_beginPoint.x, _beginPoint.y, _endPoint.x - _beginPoint.x, _endPoint.y - _beginPoint.y);
    CGContextSetLineWidth(_context, 5);
    CGContextSetRGBFillColor(_context, 0.5, 0.2, 0, 1);
    CGContextFillRect(_context, rect);
    CGContextStrokePath(_context);
    
    CGContextAddRect(_context,rect);
    CGContextSetLineWidth(_context, 3);
    CGContextSetRGBStrokeColor(_context, 0, 0, 0, 1);
    CGContextStrokePath(_context);
}

- (void)drawCurve:(CGContextRef)_context
{
    CGContextSetLineWidth(_context, 2);
    //----
    //1
    CGPoint addPoint[[_array_points_1 count]];
    NSLog(@"%d",[_array_points_1 count]);

    for(int i = 0;i<[_array_points_1 count];i++)
    {
        addPoint[i] = [[_array_points_1 objectAtIndex:i] CGPointValue];
    }
    CGContextAddLines(_context, addPoint, sizeof(addPoint)/sizeof(addPoint[0]));//count
 
    //2
    CGPoint addPoint_2[[_array_points_2 count]];
    for(int i = 0;i<[_array_points_2 count];i++)
    {
        addPoint_2[i] = [[_array_points_2 objectAtIndex:i] CGPointValue];
    }
    CGContextAddLines(_context, addPoint_2, sizeof(addPoint_2)/sizeof(addPoint_2[0]));
        
    //3
    CGPoint addPoint_3[[_array_points_3 count]];
    for(int i = 0;i<[_array_points_3 count];i++)
    {
        addPoint_3[i] = [[_array_points_3 objectAtIndex:i] CGPointValue];
    }
    CGContextAddLines(_context, addPoint_3, sizeof(addPoint_3)/sizeof(addPoint_3[0]));
  
    //--
    CGContextStrokePath(_context);  
    
}
- (void)drawCircle:(CGContextRef)_context
{
    NSLog(@"in drawCircle");
    CGContextSetLineWidth(_context, 5);
    CGContextSetRGBStrokeColor(_context, 0, 1, 0, 1);
    CGContextAddArc(_context, self.centerPoint.x, self.centerPoint.y, 20.0, 0, 360, 0);
    CGContextStrokePath(_context);
}


@end
