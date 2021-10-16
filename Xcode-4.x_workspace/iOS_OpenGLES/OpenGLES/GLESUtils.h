//
//  GLESUtils.h
//  OpenGLES
//
//  Created by LiZhaoJin on 13-4-27.
//  Copyright (c) 2013年 LiZhaoJin. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <OpenGLES/ES2/gl.h>
@interface GLESUtils : NSObject
// Create a shader object, load the shader source string, and compile the shader.
//
+(GLuint)loadShader:(GLenum)type withString:(NSString *)shaderString;

+(GLuint)loadShader:(GLenum)type withFilepath:(NSString *)shaderFilepath;

@end
