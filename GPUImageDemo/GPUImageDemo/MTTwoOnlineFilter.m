//
//  MTTwoOnlineFilter.m
//  MTMTV
//
//  Created by zeng on 24/02/2018.
//  Copyright © 2018 Meitu,inc. All rights reserved.
//

#import "MTTwoOnlineFilter.h"

@implementation MTTwoOnlineFilter
{
    GPUImageFilter *_firstFilter;
    GPUImageFilter *_secondFilter;
    //    MTPanTwoInputFilter *_resultFilter;
    
    GLfloat _firstImageVertices[8];
    GLfloat _firstImageTexcoords[8];
    GLfloat _secondImageVertices[8];
    GLfloat _secondImageTexcoords[8];
    
}
NSString *const kMTPanTwoInputFilterVertexShaderString = SHADER_STRING
(
 attribute vec4 position;
 attribute vec4 inputTextureCoordinate;
 
 varying vec2 textureCoordinate;
 
 void main()
 {
     gl_Position = position;
     textureCoordinate = inputTextureCoordinate.xy;
 }
 );


NSString *const kMTPanTwoInputFilterFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 
 void main()
 {
     gl_FragColor = texture2D(inputImageTexture, textureCoordinate);
 }
 );

- (instancetype)initWithReplaceFilter:(GPUImageFilter *)replaceFilter
                        CurrentFilter:(GPUImageFilter *)currentFilter
{
    self = [super initWithVertexShaderFromString:kMTPanTwoInputFilterVertexShaderString
                        fragmentShaderFromString:kMTPanTwoInputFilterFragmentShaderString];
    if (self) {
        _firstFilter = currentFilter;
        _secondFilter = replaceFilter;
        _leftRightChange = true;
    }
    return self;
}

- (void)setDisFactor:(CGFloat)disFactor
{
    if (_disFactor != disFactor) {
        _disFactor = disFactor;
    }
}
- (void)caculationCoords
{
    if (_leftRightChange) {
        if (_disFactor > 0) {
            _firstImageVertices[0] = _disFactor * 2.0 - 1.0;
            _firstImageVertices[1] = -1.0;
            _firstImageVertices[2] = 1.0;
            _firstImageVertices[3] = -1.0;
            _firstImageVertices[4] = _disFactor * 2.0 - 1.0;
            _firstImageVertices[5] = 1.0;
            _firstImageVertices[6] = 1.0;
            _firstImageVertices[7] = 1.0;
            
            _firstImageTexcoords[0] = _disFactor;
            _firstImageTexcoords[1] = 0.0;
            _firstImageTexcoords[2] = 1.0;
            _firstImageTexcoords[3] = 0.0;
            _firstImageTexcoords[4] = _disFactor;
            _firstImageTexcoords[5] = 1.0;
            _firstImageTexcoords[6] = 1.0;
            _firstImageTexcoords[7] = 1.0;
            
            _secondImageVertices[0] = -1.0;
            _secondImageVertices[1] = -1.0;
            _secondImageVertices[2] = _disFactor * 2.0 - 1.0;
            _secondImageVertices[3] = -1.0;
            _secondImageVertices[4] = -1.0;
            _secondImageVertices[5] = 1.0;
            _secondImageVertices[6] = _disFactor * 2.0 - 1.0;
            _secondImageVertices[7] = 1.0;
            
            _secondImageTexcoords[0] = 0.0;
            _secondImageTexcoords[1] = 0.0;
            _secondImageTexcoords[2] = _disFactor;
            _secondImageTexcoords[3] = 0.0;
            _secondImageTexcoords[4] = 0.0;
            _secondImageTexcoords[5] = 1.0;
            _secondImageTexcoords[6] = _disFactor;
            _secondImageTexcoords[7] = 1.0;
        } else {
            _firstImageVertices[0] = -1.0;
            _firstImageVertices[1] = -1.0;
            _firstImageVertices[2] = (1.0 + 2 * _disFactor);
            _firstImageVertices[3] = -1.0;
            _firstImageVertices[4] = -1.0;
            _firstImageVertices[5] = 1.0;
            _firstImageVertices[6] = (1.0 + 2 * _disFactor);
            _firstImageVertices[7] = 1.0;
            
            _firstImageTexcoords[0] = 0.0;
            _firstImageTexcoords[1] = 0.0;
            _firstImageTexcoords[2] = 1.0 + _disFactor;
            _firstImageTexcoords[3] = 0.0;
            _firstImageTexcoords[4] = 0.0;
            _firstImageTexcoords[5] = 1.0;
            _firstImageTexcoords[6] = 1.0 + _disFactor;
            _firstImageTexcoords[7] = 1.0;
            
            _secondImageVertices[0] = (1.0 + 2 * _disFactor);
            _secondImageVertices[1] = -1.0;
            _secondImageVertices[2] = 1.0;
            _secondImageVertices[3] = -1.0;
            _secondImageVertices[4] = (1.0 + 2 *_disFactor);
            _secondImageVertices[5] = 1.0;
            _secondImageVertices[6] = 1.0;
            _secondImageVertices[7] = 1.0;
            
            _secondImageTexcoords[0] = 1.0 + _disFactor;
            _secondImageTexcoords[1] = 0.0;
            _secondImageTexcoords[2] = 1.0;
            _secondImageTexcoords[3] = 0.0;
            _secondImageTexcoords[4] = 1.0 + _disFactor;
            _secondImageTexcoords[5] = 1.0;
            _secondImageTexcoords[6] = 1.0;
            _secondImageTexcoords[7] = 1.0;
        }
    } else {
        if (_disFactor > 0) {
            _firstImageVertices[0] = -1.0;
            _firstImageVertices[1] = _disFactor * 2.0 -1.0;
            _firstImageVertices[2] = 1.0;
            _firstImageVertices[3] = _disFactor * 2.0 -1.0;
            _firstImageVertices[4] = -1.0;
            _firstImageVertices[5] = 1.0;
            _firstImageVertices[6] = 1.0;
            _firstImageVertices[7] = 1.0;
            
            _firstImageTexcoords[0] = 0.0;
            _firstImageTexcoords[1] = _disFactor;
            _firstImageTexcoords[2] = 1.0;
            _firstImageTexcoords[3] = _disFactor;
            _firstImageTexcoords[4] = 0.0;
            _firstImageTexcoords[5] = 1.0;
            _firstImageTexcoords[6] = 1.0;
            _firstImageTexcoords[7] = 1.0;
            
            _secondImageVertices[0] = -1.0;
            _secondImageVertices[1] = -1.0;
            _secondImageVertices[2] = 1.0;
            _secondImageVertices[3] = -1.0;
            _secondImageVertices[4] = -1.0;
            _secondImageVertices[5] = _disFactor * 2.0-1.0;
            _secondImageVertices[6] = 1.0;
            _secondImageVertices[7] = _disFactor * 2.0-1.0;
            
            _secondImageTexcoords[0] = 0.0;
            _secondImageTexcoords[1] = 0.0;
            _secondImageTexcoords[2] = 1.0;
            _secondImageTexcoords[3] = 0.0;
            _secondImageTexcoords[4] = 0.0;
            _secondImageTexcoords[5] = _disFactor+0.0;
            _secondImageTexcoords[6] = 1.0;
            _secondImageTexcoords[7] = _disFactor+0.0;
        }else {
            _firstImageVertices[0] = -1.0;
            _firstImageVertices[1] = -1.0;
            _firstImageVertices[2] = 1.0;
            _firstImageVertices[3] = -1.0;
            _firstImageVertices[4] = -1.0;
            _firstImageVertices[5] = 1.0+2 *_disFactor;
            _firstImageVertices[6] = 1.0;
            _firstImageVertices[7] = 1.0+2 *_disFactor;
            
            _firstImageTexcoords[0] = 0.0;
            _firstImageTexcoords[1] = 0.0;
            _firstImageTexcoords[2] = 1.0;
            _firstImageTexcoords[3] = 0.0;
            _firstImageTexcoords[4] = 0.0;
            _firstImageTexcoords[5] = 1.0+_disFactor;
            _firstImageTexcoords[6] = 1.0;
            _firstImageTexcoords[7] = 1.0+_disFactor;
            
            _secondImageVertices[0] = -1.0;
            _secondImageVertices[1] = 1.0+2 *_disFactor;
            _secondImageVertices[2] = 1.0;
            _secondImageVertices[3] = 1.0+2 *_disFactor;
            _secondImageVertices[4] = -1.0;
            _secondImageVertices[5] = 1.0;
            _secondImageVertices[6] = 1.0;
            _secondImageVertices[7] = 1.0;
            
            _secondImageTexcoords[0] = 0.0;
            _secondImageTexcoords[1] = 1.0+_disFactor;
            _secondImageTexcoords[2] = 1.0;
            _secondImageTexcoords[3] = 1.0+_disFactor;
            _secondImageTexcoords[4] = 0.0;
            _secondImageTexcoords[5] = 1.0;
            _secondImageTexcoords[6] = 1.0;
            _secondImageTexcoords[7] = 1.0;
        }
    }
}

- (void)setInputFramebuffer:(GPUImageFramebuffer *)newInputFramebuffer atIndex:(NSInteger)textureIndex
{
    [_firstFilter setInputFramebuffer:newInputFramebuffer atIndex:textureIndex];
    [_secondFilter setInputFramebuffer:newInputFramebuffer atIndex:textureIndex];
}

- (void)setInputSize:(CGSize)newSize atIndex:(NSInteger)textureIndex
{
    [super setInputSize:newSize atIndex:textureIndex];
    [_firstFilter setInputSize:newSize atIndex:textureIndex];
    [_secondFilter setInputSize:newSize atIndex:textureIndex];
}

- (void)newFrameReadyAtTime:(CMTime)frameTime atIndex:(NSInteger)textureIndex
{
    //建立双输入
    [_firstFilter useNextFrameForImageCapture];
    [_firstFilter newFrameReadyAtTime:frameTime atIndex:textureIndex];
    GPUImageFramebuffer *curFirstFramebuffer = [_firstFilter framebufferForOutput];
    [_firstFilter removeOutputFramebuffer];
    
    [_secondFilter useNextFrameForImageCapture];
    [_secondFilter newFrameReadyAtTime:frameTime atIndex:textureIndex];
    GPUImageFramebuffer *curSecondeFramebuffer = [_secondFilter framebufferForOutput];
    [_secondFilter removeOutputFramebuffer];
    
    if (self.preventRendering)
    {
        [curFirstFramebuffer unlock];
        [curSecondeFramebuffer unlock];
        return;
    }
    
    [self caculationCoords];
    
    [GPUImageContext setActiveShaderProgram:filterProgram];
    outputFramebuffer = [[GPUImageContext sharedFramebufferCache] fetchFramebufferForSize:[self sizeOfFBO] textureOptions:self.outputTextureOptions onlyTexture:NO];
    [outputFramebuffer activateFramebuffer];
    if (usingNextFrameForImageCapture)
    {
        [outputFramebuffer lock];
    }
    
    [self setUniformsForProgramAtIndex:0];
    
    glClearColor(backgroundColorRed, backgroundColorGreen, backgroundColorBlue, backgroundColorAlpha);
    glClear(GL_COLOR_BUFFER_BIT);
    
    glActiveTexture(GL_TEXTURE2);
    glBindTexture(GL_TEXTURE_2D, [curFirstFramebuffer texture]);
    glUniform1i(filterInputTextureUniform, 2);
    
    glVertexAttribPointer(filterPositionAttribute, 2, GL_FLOAT, 0, 0, _firstImageVertices);
    glVertexAttribPointer(filterTextureCoordinateAttribute, 2, GL_FLOAT, 0, 0, _firstImageTexcoords);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
    glActiveTexture(GL_TEXTURE3);
    glBindTexture(GL_TEXTURE_2D, [curSecondeFramebuffer texture]);
    glUniform1i(filterInputTextureUniform, 3);
    
    
    glVertexAttribPointer(filterPositionAttribute, 2, GL_FLOAT, 0, 0, _secondImageVertices);
    glVertexAttribPointer(filterTextureCoordinateAttribute, 2, GL_FLOAT, 0, 0, _secondImageTexcoords);
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
    [curFirstFramebuffer unlock];
    [curSecondeFramebuffer unlock];
    if (usingNextFrameForImageCapture)
    {
        dispatch_semaphore_signal(imageCaptureSemaphore);
    }
    
    [self informTargetsAboutNewFrameAtTime:frameTime];
    
}

@end
