//
//  ViewController.m
//  GPUImageDemo
//
//  Created by HW on 2018/8/3.
//  Copyright © 2018年 meitu. All rights reserved.
//

#import "ViewController.h"
#import <GPUImageView.h>
#import <GPUImageVideoCamera.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *mUIView;
@property (strong, nonatomic) GPUImageVideoCamera *mCamera;
@property (strong, nonatomic) GPUImageView *mGPUImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionBack];
    _mCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    _mGPUImageView = [[GPUImageView alloc] initWithFrame:_mUIView.frame];
    [_mUIView addSubview:_mGPUImageView];
    
    [_mCamera addTarget:_mGPUImageView];
    
}




- (IBAction)takePhoto:(id)sender {
    [_mCamera startCameraCapture];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
