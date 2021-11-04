//
//  TianmuSplashViewController.m
//  TianmuSDK-Demo
//
//  Created by 陈则富 on 2021/9/13.
//

#import "TianmuSplashViewController.h"
#import "TianmuCustomSplashSkipView.h"
#import "TianmuRingProgressView.h"
#import <TianmuSDK/TianmuSplashAd.h>
#import <ADSuyiKit/ADSuyiKitMacros.h>
#import <ADSuyiKit/UIColor+ADSuyiKit.h>

@interface TianmuSplashViewController ()<TianmuSplashAdDelegate>

@property (nonatomic ,strong) TianmuSplashAd  *splashAd;

@property (nonatomic ,strong) TianmuCustomSplashSkipView  *skipNormalView;

@property (nonatomic ,strong) TianmuRingProgressView  *skipView;

@end

@implementation TianmuSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat bottomViewHeight;
    if (kADSYCurveScreen) {
        bottomViewHeight = [UIScreen mainScreen].bounds.size.height * 0.15;
    } else {
        bottomViewHeight = [UIScreen mainScreen].bounds.size.height - [UIScreen mainScreen].bounds.size.width * (960 / 640.0);
    }
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, bottomViewHeight);
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Tianmu_Logo.png"]];
    logoImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-135)/2, (bottomViewHeight-46)/2, 135, 46);
    [bottomView addSubview:logoImageView];
    
    _skipNormalView = [TianmuCustomSplashSkipView new];
    _skipView       = [[TianmuRingProgressView alloc]init];
    
    // 初始化开屏广告加载实例
    _splashAd = [[TianmuSplashAd alloc]init];
    // 开屏广告posid
    _splashAd.posId = @"9106b5a8d273";
    // 开屏广告委托对象
    _splashAd.delegate = self;
//    _splashAd.hiddenSkipView = YES;
//    _splashAd.skipView = _skipView;
    // 设置默认启动图(一般设置启动图的平铺颜色为背景颜色，使得视觉效果更加平滑)
    _splashAd.backgroundColor = [UIColor adsy_getColorWithImage:[UIImage imageNamed:@"750x1334.png"] withNewSize:[UIScreen mainScreen].bounds.size];
    // 开屏广告加载并展示
    [_splashAd loadAndShowInWindow:[UIApplication sharedApplication].keyWindow withBottomView:self.fullBool ? nil : bottomView];

}
// 开屏广告回调方法
#pragma mark - TianmuSplashAdDelegate

/**
 *  开屏广告请求成功
 */
- (void)tianmuSplashAdSuccessLoad:(TianmuSplashAd *)splashAd {
    
}

/**
 *  开屏广告素材加载成功
 */
- (void)tianmuSplashAdDidLoad:(TianmuSplashAd *)splashAd {
    
}

/**
 *  开屏广告请求失败
 */
- (void)tianmuSplashAdFailLoad:(TianmuSplashAd *)splashAd withError:(NSError *)error {
    NSLog(@"splash开屏广告加载失败%@",error);
    _splashAd = nil;
}
/**
 *  开屏广告展示失败
 */
- (void)tianmuSplashAdRenderFaild:(TianmuSplashAd *)splashAd withError:(NSError *)error {
    
}

/**
 *  开屏广告曝光回调
 */
- (void)tianmuSplashAdExposured:(TianmuSplashAd *)splashAd {
    
}

/**
 *  开屏广告点击回调
 */
- (void)tianmuSplashAdClicked:(TianmuSplashAd *)splashAd {
    _splashAd = nil;
}

/**
 *  开屏广告关闭回调
 */
- (void)tianmuSplashAdClosed:(TianmuSplashAd *)splashAd {
    _splashAd = nil;
}





@end
