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

@property (nonatomic ,strong) TianmuInterstitialAd  *interstitialAd;

@property (nonatomic ,assign) BOOL  isReady;


@end

@implementation TianmuInterstitialAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"插屏";
    self.view.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIButton *loadBtn = [UIButton new];
    loadBtn.layer.cornerRadius = 3;
    loadBtn.clipsToBounds = YES;
    loadBtn.backgroundColor = UIColor.whiteColor;
    [loadBtn setTitle:@"加载插屏" forState:(UIControlStateNormal)];
    [loadBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:loadBtn];
    loadBtn.frame = CGRectMake(30, UIScreen.mainScreen.bounds.size.height/2-60, UIScreen.mainScreen.bounds.size.width-60, 40);
    [loadBtn addTarget:self action:@selector(loadInterstitialAd) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *showBtn = [UIButton new];
    showBtn.layer.cornerRadius = 3;
    showBtn.clipsToBounds = YES;
    showBtn.backgroundColor = UIColor.whiteColor;
    [showBtn setTitle:@"展示插屏" forState:(UIControlStateNormal)];
    [showBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:showBtn];
    [showBtn addTarget:self action:@selector(showInterstitialAd) forControlEvents:(UIControlEventTouchUpInside)];
    showBtn.frame = CGRectMake(30, UIScreen.mainScreen.bounds.size.height/2+20, UIScreen.mainScreen.bounds.size.width-60, 40);
   
}

// 217d589e286f472159 插屏测试id
- (void)loadInterstitialAd{
    // 1、初始化插屏广告
    self.interstitialAd = [[TianmuInterstitialAd alloc]init];
    self.interstitialAd.controller = self;
    self.interstitialAd.posId   =   @"418f6bdc0a3e";
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
}

- (void)showInterstitialAd{
    if (_isReady) {
        [self.interstitialAd showFromRootViewController:self];
        return;
    }
    [self.view makeToast:@"广告未准备好"];
   
}

#pragma mark === TianmuInterstitialAdDelegate
/**
 *  插屏广告数据请求成功
 */
- (void)tianmuInterstitialSuccessToLoadAd:(TianmuInterstitialAd *)unifiedInterstitial {
    [self.view makeToast:@"广告准备好"];
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
 *  建议在此回调后展示广告
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



@end
