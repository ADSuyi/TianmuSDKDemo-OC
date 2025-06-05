//
//  TianmuInterstitialAdViewController.m
//  TianmuSDK-Demo
//
//  Created by 陈则富 on 2021/9/14.
//

#import "TianmuInterstitialAdViewController.h"
#import <TianmuSDK/TianmuInterstitialAd.h>
#import "UIView+Toast.h"
@interface TianmuInterstitialAdViewController ()<TianmuInterstitialAdDelegate>
{
    BOOL _isNormalAd;
}

@property (nonatomic ,strong) TianmuInterstitialAd  *interstitialAd;

@property (nonatomic ,assign) BOOL  isReady;


@end

@implementation TianmuInterstitialAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isNormalAd = YES;
    
    self.title = @"插屏";
    self.view.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIButton *loadBtn = [UIButton new];
    loadBtn.layer.cornerRadius = 3;
    loadBtn.clipsToBounds = YES;
    loadBtn.backgroundColor = UIColor.whiteColor;
    [loadBtn setTitle:@"加载普通插屏" forState:(UIControlStateNormal)];
    [loadBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:loadBtn];
    loadBtn.frame = CGRectMake(30, 100, UIScreen.mainScreen.bounds.size.width-60, 40);
    [loadBtn addTarget:self action:@selector(loadInterstitialAd) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *showBtn = [UIButton new];
    showBtn.layer.cornerRadius = 3;
    showBtn.clipsToBounds = YES;
    showBtn.backgroundColor = UIColor.whiteColor;
    [showBtn setTitle:@"展示普通插屏" forState:(UIControlStateNormal)];
    [showBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:showBtn];
    [showBtn addTarget:self action:@selector(showInterstitialAd) forControlEvents:(UIControlEventTouchUpInside)];
    showBtn.frame = CGRectMake(30, 160, UIScreen.mainScreen.bounds.size.width-60, 40);
    
    
    UIButton *loadBidBtn = [UIButton new];
    loadBidBtn.layer.cornerRadius = 3;
    loadBidBtn.clipsToBounds = YES;
    loadBidBtn.backgroundColor = UIColor.whiteColor;
    [loadBidBtn setTitle:@"加载竞价插屏" forState:(UIControlStateNormal)];
    [loadBidBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:loadBidBtn];
    loadBidBtn.frame = CGRectMake(30, 220, UIScreen.mainScreen.bounds.size.width-60, 40);
    [loadBidBtn addTarget:self action:@selector(loadBidAd) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *bidWinBtn = [UIButton new];
    bidWinBtn.layer.cornerRadius = 3;
    bidWinBtn.clipsToBounds = YES;
    bidWinBtn.backgroundColor = UIColor.whiteColor;
    [bidWinBtn setTitle:@"竞价成功" forState:(UIControlStateNormal)];
    [bidWinBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:bidWinBtn];
    bidWinBtn.frame = CGRectMake(30, 280, UIScreen.mainScreen.bounds.size.width-60, 40);
    [bidWinBtn addTarget:self action:@selector(bidWin) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *bidFailBtn = [UIButton new];
    bidFailBtn.layer.cornerRadius = 3;
    bidFailBtn.clipsToBounds = YES;
    bidFailBtn.backgroundColor = UIColor.whiteColor;
    [bidFailBtn setTitle:@"竞价失败" forState:(UIControlStateNormal)];
    [bidFailBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:bidFailBtn];
    bidFailBtn.frame = CGRectMake(30, 340, UIScreen.mainScreen.bounds.size.width-60, 40);
    [bidFailBtn addTarget:self action:@selector(bidFail) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)loadInterstitialAd{
    _isNormalAd = YES;
    _isReady = NO;
    // 1、初始化插屏广告
    self.interstitialAd = [[TianmuInterstitialAd alloc]init];
    self.interstitialAd.controller = self;
    self.interstitialAd.posId   =   @"682f5d1cb439";
    self.interstitialAd.delegate = self;
    // 是否开启倒计时关闭
    // self.interstitialAd.isAutoClose = YES;
    // 设置倒计时关闭时长 [3~100) 区间内有效
    // self.interstitialAd.autoCloseTime = 10;
    [self.interstitialAd loadAdData];
}

- (void)showInterstitialAd{
    if (_isReady && self.interstitialAd) {
        [self.interstitialAd showFromRootViewController:self];
        return;
    }
    [self.view makeToast:@"广告未准备好"];
}

- (void)loadBidAd {
    _isNormalAd = NO;
    _isReady = NO;
    // 1、初始化插屏广告
    self.interstitialAd = [[TianmuInterstitialAd alloc]init];
    self.interstitialAd.controller = self;
    self.interstitialAd.posId   =   @"03bd2a589fe1";
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
}

- (void)bidWin {
    if (_isNormalAd) {
        [self.view makeToast:@"当前广告不是竞价广告"];
        return;
    }
    if (_isReady && self.interstitialAd) {
        // 发送竞价成功通知
        // 如天目从竞价队列中胜出，则传入广告返回的出价，如：[adView bidPrice]（单位：分）
        [self.interstitialAd sendWinNotificationWithPrice:[self.interstitialAd bidPrice]];
        [self.interstitialAd showFromRootViewController:self];
        return;
    }
    [self.view makeToast:@"广告未准备好"];
}

- (void)bidFail {
    if (_isNormalAd) {
        [self.view makeToast:@"当前广告不是竞价广告"];
        return;
    }
    if (_isReady && self.interstitialAd) {
        [self.interstitialAd sendWinFailNotificationReason:(TianmuAdBiddingLossReasonLowPrice) winnerPirce:1000];
        [self.interstitialAd showFromRootViewController:self];
        return;
    }
    [self.view makeToast:@"广告未准备好"];
}


/**
 *  插屏广告数据请求成功
 */
- (void)tianmuInterstitialSuccessToLoadAd:(TianmuInterstitialAd *)unifiedInterstitial {
    [self.view makeToast:@"广告准备好"];
    if (!_isNormalAd)
        [self.view makeToast:[NSString stringWithFormat:@"当前广告价格：%ld",unifiedInterstitial.bidPrice]];
    _isReady = YES;
}

/**
 *  插屏广告数据请求失败
 */
- (void)tianmuInterstitialFailToLoadAd:(TianmuInterstitialAd *)unifiedInterstitial error:(NSError *)error {
    [self.view makeToast:error.description];
    _interstitialAd = nil;
}
/**
 *  插屏广告渲染成功
 */
- (void)tianmuInterstitialRenderSuccess:(TianmuInterstitialAd *)unifiedInterstitial {
    
}

/**
 *  插屏广告视图展示成功回调
 *  插屏广告展示成功回调该函数
 */
- (void)tianmuInterstitialDidPresentScreen:(TianmuInterstitialAd *)unifiedInterstitial {
    
}

/**
 *  插屏广告视图展示失败回调
 *  插屏广告展示失败回调该函数
 */
- (void)tianmuInterstitialFailToPresent:(TianmuInterstitialAd *)unifiedInterstitial error:(NSError *)error {
    [self.view makeToast:[NSString stringWithFormat:@"当前广告展示失败%@",error]];
    _interstitialAd = nil;
}


/**
 *  插屏广告曝光回调
 */
- (void)tianmuInterstitialWillExposure:(TianmuInterstitialAd *)unifiedInterstitial {
    
}

/**
 *  插屏广告点击回调
 */
- (void)tianmuInterstitialClicked:(TianmuInterstitialAd *)unifiedInterstitial {
    
}


/**
 *  插屏广告页关闭
 */
- (void)tianmuInterstitialAdDidDismissClose:(TianmuInterstitialAd *)unifiedInterstitial {
    _interstitialAd = nil;
}

/**
 插屏视频广告开始播放
 */
- (void)tianmuInterstitialAdVideoPlay:(TianmuInterstitialAd *)unifiedInterstitial {
    NSLog(@"插屏视频播放");
}


/**
 插屏视频广告视频播放失败
 */
- (void)tianmuInterstitialAdVideoPlayFail:(TianmuInterstitialAd *)unifiedInterstitial error:(NSError *)error {
    NSLog(@"插屏视频播放失败");
}

/**
 插屏视频广告视频暂停
 */
- (void)tianmuInterstitialAdVideoPause:(TianmuInterstitialAd *)unifiedInterstitial {
    NSLog(@"插屏视频播放暂停");
}

/**
 插屏视频广告视频播放完成
 */
- (void)tianmuInterstitialAdVideoFinish:(TianmuInterstitialAd *)unifiedInterstitial {
    NSLog(@"插屏视频播放完成");
}

- (void)tianmuInterstitialAdDidCloseLandingPage:(TianmuInterstitialAd *)unifiedInterstitial {
    
}



@end
