//
//  TianmuRewardVodAdViewController.m
//  TianmuSDK-Demo
//
//  Created by Erik on 2021/12/10.
//

#import "ADTianmuRewardVodAdViewController.h"
#import <TianmuSDK/TianmuRewardVodAd.h>
#import "UIView+Toast.h"
@interface ADTianmuRewardVodAdViewController ()<TianmuRewardVodAdDelegate>
{
    BOOL _isNormalAd;
    BOOL _isReady;
}

@property (nonatomic, strong) TianmuRewardVodAd *rewardVodAd;

@end

@implementation ADTianmuRewardVodAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isNormalAd = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIButton *loadBtn = [UIButton new];
    loadBtn.layer.cornerRadius = 3;
    loadBtn.clipsToBounds = YES;
    loadBtn.backgroundColor = UIColor.whiteColor;
    [loadBtn setTitle:@"加载普通激励视频" forState:(UIControlStateNormal)];
    [loadBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:loadBtn];
    loadBtn.frame = CGRectMake(30, 100, UIScreen.mainScreen.bounds.size.width-60, 40);
    [loadBtn addTarget:self action:@selector(loadRewardVodAd) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *showBtn = [UIButton new];
    showBtn.layer.cornerRadius = 3;
    showBtn.clipsToBounds = YES;
    showBtn.backgroundColor = UIColor.whiteColor;
    [showBtn setTitle:@"展示普通激励视频" forState:(UIControlStateNormal)];
    [showBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:showBtn];
    [showBtn addTarget:self action:@selector(showRewardVodAd) forControlEvents:(UIControlEventTouchUpInside)];
    showBtn.frame = CGRectMake(30, 160, UIScreen.mainScreen.bounds.size.width-60, 40);
    
    
    UIButton *loadBidBtn = [UIButton new];
    loadBidBtn.layer.cornerRadius = 3;
    loadBidBtn.clipsToBounds = YES;
    loadBidBtn.backgroundColor = UIColor.whiteColor;
    [loadBidBtn setTitle:@"加载竞价激励视频" forState:(UIControlStateNormal)];
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

- (void)loadRewardVodAd {
    _isNormalAd = YES;
    _isReady = NO;
    self.rewardVodAd = [[TianmuRewardVodAd alloc] init];
    self.rewardVodAd.delegate = self;
    self.rewardVodAd.controller = self;
    self.rewardVodAd.posId = @"31dab847fc60";
    [self.rewardVodAd loadAdData];
}

- (void)showRewardVodAd {
    if (!_isReady) {
        [self.view makeToast:@"广告未准备好"];
        return;
    }
    [self.rewardVodAd showFromRootViewController:self];
}

- (void)loadBidAd {
    _isNormalAd = NO;
    _isReady = NO;
    self.rewardVodAd = [[TianmuRewardVodAd alloc] init];
    self.rewardVodAd.delegate = self;
    self.rewardVodAd.controller = self;
    self.rewardVodAd.posId = @"bd470c31f968";
    [self.rewardVodAd loadAdData];
}

- (void)bidWin {
    if (_isNormalAd) {
        [self.view makeToast:@"当前广告不是竞价广告"];
        return;
    }
    if (_isReady && self.rewardVodAd) {
        // 发送竞价成功通知
        // 如天目从竞价队列中胜出，则传入广告返回的出价，如：[adView bidPrice]（单位：分）
        [self.rewardVodAd sendWinNotificationWithPrice:[self.rewardVodAd bidPrice]];
        [self.rewardVodAd showFromRootViewController:self];
        return;
    }
    [self.view makeToast:@"广告未准备好"];
}

- (void)bidFail {
    if (_isNormalAd) {
        [self.view makeToast:@"当前广告不是竞价广告"];
        return;
    }
    if (_isReady && self.rewardVodAd) {
        [self.rewardVodAd sendWinFailNotificationReason:(TianmuAdBiddingLossReasonLowPrice) winnerPirce:1000];
        [self.rewardVodAd showFromRootViewController:self];
        return;
    }
    [self.view makeToast:@"广告未准备好"];
}


#pragma mark - TianmuRewardVodAdDelegate

/**
 *  激励视频广告数据请求成功
 */
- (void)tianmuRewardVodAdSuccessToLoadAd:(TianmuRewardVodAd *)rewardVodAd {
    if (!_isNormalAd)
        [self.view makeToast:[NSString stringWithFormat:@"当前广告价格：%ld",rewardVodAd.bidPrice]];
}

/**
 *  激励视频广告数据请求失败
 */
- (void)tianmuRewardVodAdFailToLoadAd:(TianmuRewardVodAd *)rewardVodAd error:(NSError *)error {
    NSLog(@"激励视频请求失败===%@",error);
}

/**
 *  激励视频广告缓存成功
 
 */
- (void)tianmuRewardVodAdVideoCacheFinish:(TianmuRewardVodAd *)rewardVodAd {
    NSLog(@"激励视频缓存成功");
}

/**
 *  激励视频广告渲染成功
 *  建议在此回调后展示广告
 */
- (void)tianmuRewardVodAdVideoReadyToPlay:(TianmuRewardVodAd *)rewardVodAd {
    _isReady = YES;
    [self.view makeToast:@"广告准备好"];
}

/**
 *  激励视频广告播放失败
 *
 */
- (void)tianmuRewardVodAdVideoPlayFail:(TianmuRewardVodAd *)rewardVodAd error:(NSError *)error {
    NSLog(@"激励视频播放失败%@",error);
}

/**
 *  激励视频视图展示成功回调
 *  激励视频展示成功回调该函数
 */
- (void)tianmuRewardVodAdDidPresentScreen:(TianmuRewardVodAd *)rewardVodAd {
    
}

/**
 *  激励视频广告视图展示失败回调
 *  激励视频广告展示失败回调该函数
 */
- (void)tianmuRewardVodAdFailToPresent:(TianmuRewardVodAd *)rewardVodAd error:(NSError *)error {
    [self.view makeToast:[NSString stringWithFormat:@"当前广告展示失败%@",error]];
}

/**
 *  激励视频广告曝光回调
 */
- (void)tianmuRewardVodAdWillExposure:(TianmuRewardVodAd *)rewardVodAd {
    NSLog(@"激励视频曝光");
}

/**
 *  激励视频广告点击回调
 */
- (void)tianmuRewardVodAdClicked:(TianmuRewardVodAd *)rewardVodAd {
    NSLog(@"激励视频点击");
}

/**
 *  激励视频广告页关闭
 */
- (void)tianmuRewardVodAdAdDidDismissClose:(TianmuRewardVodAd *)rewardVodAd {
    _rewardVodAd = nil;
}

/**
 *  激励视频广告达到激励条件
 */
- (void)tianmuRewardVodAdAdDidEffective:(TianmuRewardVodAd *)rewardVodAd {
    NSLog(@"激励视频达到激励条件");
}

- (void)tianmuRewardVodAdAdVideoPlayFinish:(TianmuRewardVodAd *)rewardVodAd {
    NSLog(@"激励视频播放完成");
}

- (void)tianmuRewardVodAdCloseLandingPage:(TianmuRewardVodAd *)rewardVodAd {
    
}

@end
