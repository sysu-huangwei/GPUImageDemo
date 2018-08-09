//
//  GPUFilter.m
//  GPUFilter
//
//  Created by HW on 2018/8/3.
//  Copyright © 2018年 meitu. All rights reserved.
//

#import "GPUFilter.h"

NSString *const kGPUImagethroughFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 
 void main()
{
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    lowp vec4 outputColor;
    outputColor.r = (textureColor.r * 0.393) + (textureColor.g * 0.769) + (textureColor.b * 0.189);
    outputColor.g = (textureColor.r * 0.349) + (textureColor.g * 0.686) + (textureColor.b * 0.168);
    outputColor.b = (textureColor.r * 0.872) + (textureColor.g * 0.534) + (textureColor.b * 0.131);
    outputColor.a = 1.0;
    
    gl_FragColor = outputColor;
}
);

@implementation GPUFilter

- (instancetype) init {
    return [super initWithFragmentShaderFromString:kGPUImagethroughFragmentShaderString];
}

@end
