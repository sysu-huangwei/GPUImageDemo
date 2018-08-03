//
//  ViewController.m
//  GPUImageDemo
//
//  Created by HW on 2018/8/3.
//  Copyright © 2018年 meitu. All rights reserved.
//

#import "ViewController.h"
#import <GPUImageView.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *mUIView;
@property (strong, nonatomic) GPUImageView *mGPUImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mGPUImageView = [[GPUImageView alloc] initWithFrame:_mUIView.frame];
    
}




- (IBAction)takePhoto:(id)sender {
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
