//
//  GPUImageDarkenFilter.m
//  GPUFilter
//
//  Created by HW on 2018/8/29.
//  Copyright © 2018年 meitu. All rights reserved.
//

#import "GPUImageDarkenFilter.h"

@implementation GPUImageDarkenFilter

//片源着色器
NSString *const kGPUImagethroughFragmentShaderStringBrighten = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 
 void main()
{
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    lowp vec4 outputColor;
    outputColor.r = textureColor.r / 2.0;
    outputColor.g = textureColor.g / 2.0;
    outputColor.b = textureColor.b / 2.0;
    outputColor.a = 1.0;
    
    gl_FragColor = outputColor;
}
 );


- (instancetype) init {
    //使用片元着色器
    return [super initWithFragmentShaderFromString:kGPUImagethroughFragmentShaderStringBrighten];
}

@end
