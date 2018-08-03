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

#import "GPUFilter.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *mUIView;
@property (strong, nonatomic) GPUImageStillCamera *mCamera;
@property (strong, nonatomic) GPUImageView *mGPUImageView;

@property (strong, nonatomic) GPUFilter *filter;
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
    
    //初始化滤镜
    _filter = [[GPUFilter alloc] init];

    
    //把相机数据输出到滤镜上
    [_mCamera addTarget:_filter];
    //把滤镜数据输出到GPUImageView上
    [_filter addTarget:_mGPUImageView];
    
    
    
    //启动相机
    [_mCamera startCameraCapture];
    
}



//拍照
- (IBAction)takePhoto:(id)sender {
    [_mCamera capturePhotoAsPNGProcessedUpToFilter:_filter withCompletionHandler:^(NSData *processedPNG, NSError *error) {
        
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
