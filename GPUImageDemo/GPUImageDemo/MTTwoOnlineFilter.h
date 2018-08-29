//
//  MTTwoOnlineFilter.h
//  MTMTV
//
//  Created by zeng on 24/02/2018.
//  Copyright © 2018 Meitu,inc. All rights reserved.
//

#import <GPUImage/GPUImage.h>

@interface MTTwoOnlineFilter : GPUImageTwoInputFilter {
    
}

// replaceFilter  前一个/后一个滤镜
// currentFilter 当前滤镜
- (instancetype)initWithReplaceFilter:(GPUImageFilter *)replaceFilter
                      CurrentFilter:(GPUImageFilter *)currentFilter;

/**
 调整两边比例 -1.0-1.0
 */
@property (assign, nonatomic) CGFloat disFactor;

/**
 是否左右切换
 */
@property (assign, nonatomic) BOOL leftRightChange;

@end
