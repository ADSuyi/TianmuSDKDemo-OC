//
//  ADSuyiProcessView.h
//  ADSuyiSDKDemo
//
//  Created by 技术 on 2020/11/3.
//  Copyright © 2020 陈坤. All rights reserved.
// 自定义跳过按钮  圆形进度条

#import <UIKit/UIKit.h>
#import <TianmuSDK/TianmuSplashSkipViewProtocol.h>
NS_ASSUME_NONNULL_BEGIN

@interface TianmuRingProgressView : UIView<TianmuSplashSkipViewProtocol>

@property (nonatomic, assign) NSInteger progress;

@end

NS_ASSUME_NONNULL_END
