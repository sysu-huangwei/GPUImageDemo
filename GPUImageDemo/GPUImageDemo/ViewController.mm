//
//  ViewController.m
//  GPUImageDemo
//
//  Created by HW on 2018/8/3.
//  Copyright © 2018年 meitu. All rights reserved.
//

#import "ViewController.h"
#import <GPUImageView.h>
#import <GPUImageStillCamera.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *mUIView;
@property (strong, nonatomic) GPUImageStillCamera *mCamera;
@property (strong, nonatomic) GPUImageView *mGPUImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化相机
    _mCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionBack];
    _mCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    //初始化GPUImageView
    _mGPUImageView = [[GPUImageView alloc] initWithFrame:_mUIView.frame];
    
    //把GPUImageView显示到UIView上
    [_mUIView addSubview:_mGPUImageView];
    
    //吧相机数据输出到GPUImageView上
    [_mCamera addTarget:_mGPUImageView];
    
    //启动相机
    [_mCamera startCameraCapture];
    
}




- (IBAction)takePhoto:(id)sender {
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
