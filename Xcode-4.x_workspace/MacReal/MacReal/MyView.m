#import "MyView.h"


@implementation MyView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:[self bounds] xRadius:8.0 yRadius:8.0];
	[path setClip];
	
	[[NSColor whiteColor] setFill];
	[NSBezierPath fillRect:[self bounds]];
	
	[path setLineWidth:3.0];
	
	[[NSColor grayColor] setStroke];
	[path stroke];
}


- (void)magnifyWithEvent:(NSEvent *)event {
	NSSize size = [self frame].size;
	NSSize originalSize = size;
    size.height = size.height * ([event magnification] + 1.0);//放大/缩小后的大小
    size.width = size.width * ([event magnification] + 1.0);
		
    [self setFrameSize:size];
	
	CGFloat deltaX = (originalSize.width - size.width) / 2; 
	CGFloat deltaY = (originalSize.height - size.height) / 2;
	
	NSPoint origin = self.frame.origin;//开始坐标
	origin.x = origin.x + deltaX;
	origin.y = origin.y + deltaY;
	[self setFrameOrigin:origin];	
}

- (void)rotateWithEvent:(NSEvent *)event {
	CGFloat currentRotation = [self frameCenterRotation];
    [self setFrameCenterRotation:(currentRotation + [event rotation])];
}


@end
