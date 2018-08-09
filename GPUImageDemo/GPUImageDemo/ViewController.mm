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
#import <GPUImagePicture.h>

#import "GPUFilter.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *captureButton;//拍照按钮
@property (strong, nonatomic) IBOutlet UIView *mUIView;//装GPUImageView的容器
@property (strong, nonatomic) GPUImageStillCamera *mCamera; //相机
@property (strong, nonatomic) GPUImageView *mGPUImageView; //GPUImageView

@property (strong, nonatomic) GPUFilter *filter; //滤镜

@property BOOL isRealTime; //当前是否在实时预览 YES:实时预览  NO:拍后

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化相机
    _mCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionBack];
    _mCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    _isRealTime = YES;
    
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
    if (_isRealTime) {
        __weak typeof(self) weakSelf = self;
        [_mCamera capturePhotoAsPNGProcessedUpToFilter:_filter withCompletionHandler:^(NSData *processedPNG, NSError *error) {
            UIImage* image = [[UIImage alloc] initWithData:processedPNG];
            if(image != nil){
                [weakSelf.mCamera stopCameraCapture];
                weakSelf.isRealTime = NO;
                weakSelf.captureButton.titleLabel.text = @"返回";
                GPUImagePicture* picture = [[GPUImagePicture alloc] initWithImage:image];
                [picture addTarget:weakSelf.filter];
                [picture useNextFrameForImageCapture];
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            }
        }];
    }
    else {
        [_mCamera startCameraCapture];
        _isRealTime = YES;
        _captureButton.titleLabel.text = @"拍照";
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
