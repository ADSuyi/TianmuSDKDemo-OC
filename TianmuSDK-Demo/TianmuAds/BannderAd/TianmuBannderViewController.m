//
//  TianmuBannderViewController.m
//  TianmuSDK-Demo
//
//  Created by 陈则富 on 2021/9/13.
//

#import "TianmuBannderViewController.h"
#import <ADSuyiKit/ADSuyiKitMacros.h>
#import <TianmuSDK/TianmuBannerAdView.h>

@interface TianmuBannderViewController()<TianmuBannerAdViewDelegate>

@property (nonatomic ,strong) TianmuBannerAdView  *bannerAd;

@end

@implementation TianmuBannderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bannerAd = [[TianmuBannerAdView alloc] initWithFrame:CGRectMake(0, 250, kADSYScreenWidth, kADSYScreenWidth / (640/100.0)) posId:@"6c8a713efb95"];
    self.bannerAd.delegate = self;
    self.bannerAd.viewController = self;
    [self.view addSubview:self.bannerAd];
    [self.bannerAd loadRequest];
}

#pragma mark === TianmuBannerAdViewDelegate

/**
 *  请求广告条数据成功后调用
 *  当接收服务器返回的广告数据成功后调用该函数
 */
- (void)tianmuBannerSuccessLoad:(TianmuBannerAdView *)tianmuBannerView {
    
}

/**
 *  请求广告数据失败后调用
 *  当接收服务器返回的广告数据失败后调用该函数
 */
- (void)tianmuBannerViewFailedToLoadWithError:(NSError *)error {
    NSLog(@"banner广告加载失败%@",error);
    [self.bannerAd removeFromSuperview];
    self.bannerAd = nil;
}

/**
 *  曝光回调
 */
- (void)tianmuBannerViewWillExpose:(TianmuBannerAdView *)tianmuBannerView {
    
}

/**
 *  点击回调
 */
- (void)tianmuBannerViewClicked:(TianmuBannerAdView *)tianmuBannerView {
    
}

/**
 *  被用户关闭时调用
 */
- (void)tianmuBannerViewWillClose:(TianmuBannerAdView *)tianmuBannerView {
    [self.bannerAd removeFromSuperview];
    self.bannerAd = nil;
}

@end
