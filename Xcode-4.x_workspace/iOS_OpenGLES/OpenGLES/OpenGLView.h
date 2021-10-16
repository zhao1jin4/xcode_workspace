//
//  OpenGLView.h
//  OpenGLES
//
//  Created by LiZhaoJin on 13-4-27.
//  Copyright (c) 2013年 LiZhaoJin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>
#include "GLESUtils.h"
@interface OpenGLView : UIView
{
    CAEAGLLayer* _eaglLayer;
    EAGLContext* _context;
    GLuint _colorRenderBuffer;
    GLuint _frameBuffer;
    
    GLuint _programHandle;
    GLuint _positionSlot;
}
- (void)setupProgram;
@end
