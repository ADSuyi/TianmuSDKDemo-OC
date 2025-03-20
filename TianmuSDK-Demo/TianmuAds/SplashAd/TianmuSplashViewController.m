//
//  TianmuSplashViewController.m
//  TianmuSDK-Demo
//
//  Created by 陈则富 on 2021/9/13.
//

#import "TianmuSplashViewController.h"
#import <TianmuSDK/TianmuSplashAd.h>
#import <ADSuyiKit/ADSuyiKitMacros.h>
#import <ADSuyiKit/UIColor+ADSuyiKit.h>
#import "UIView+Toast.h"

@interface TianmuSplashViewController ()<TianmuSplashAdDelegate>
{
    BOOL _isHeadBidding;
    BOOL _isSucceed;
}

@property (nonatomic ,strong) TianmuSplashAd  *splashAd;

@end

@implementation TianmuSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    
    UIButton *loadBtn = [UIButton new];
    loadBtn.layer.cornerRadius = 3;
    loadBtn.clipsToBounds = YES;
    loadBtn.backgroundColor = UIColor.whiteColor;
    [loadBtn setTitle:@"开始询价" forState:(UIControlStateNormal)];
    [loadBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:loadBtn];
    loadBtn.frame = CGRectMake(30, UIScreen.mainScreen.bounds.size.height/2-60, UIScreen.mainScreen.bounds.size.width-60, 40);
    [loadBtn addTarget:self action:@selector(loadBidAd) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *bidWinBtn = [UIButton new];
    bidWinBtn.layer.cornerRadius = 3;
    bidWinBtn.clipsToBounds = YES;
    bidWinBtn.backgroundColor = UIColor.whiteColor;
    [bidWinBtn setTitle:@"竞价成功" forState:(UIControlStateNormal)];
    [bidWinBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:bidWinBtn];
    [bidWinBtn addTarget:self action:@selector(bidWin) forControlEvents:(UIControlEventTouchUpInside)];
    bidWinBtn.frame = CGRectMake(30, UIScreen.mainScreen.bounds.size.height/2, UIScreen.mainScreen.bounds.size.width-60, 40);
    
    UIButton *bidFailBtn = [UIButton new];
    bidFailBtn.layer.cornerRadius = 3;
    bidFailBtn.clipsToBounds = YES;
    bidFailBtn.backgroundColor = UIColor.whiteColor;
    [bidFailBtn setTitle:@"竞价失败" forState:(UIControlStateNormal)];
    [bidFailBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:bidFailBtn];
    [bidFailBtn addTarget:self action:@selector(bidFail) forControlEvents:(UIControlEventTouchUpInside)];
    bidFailBtn.frame = CGRectMake(30, UIScreen.mainScreen.bounds.size.height/2 + 60, UIScreen.mainScreen.bounds.size.width-60, 40);
    
    
    UIButton *loadAndShowBtn = [UIButton new];
    loadAndShowBtn.layer.cornerRadius = 3;
    loadAndShowBtn.clipsToBounds = YES;
    loadAndShowBtn.backgroundColor = UIColor.whiteColor;
    [loadAndShowBtn setTitle:@"正常加载展示" forState:(UIControlStateNormal)];
    [loadAndShowBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:loadAndShowBtn];
    [loadAndShowBtn addTarget:self action:@selector(loadAndShow) forControlEvents:(UIControlEventTouchUpInside)];
    loadAndShowBtn.frame = CGRectMake(30, UIScreen.mainScreen.bounds.size.height/2+140, UIScreen.mainScreen.bounds.size.width-60, 40);

}

- (void)loadBidAd {
    _isHeadBidding = YES;
    _isSucceed = NO;
    // 初始化开屏广告加载实例
    if (!_splashAd)
        _splashAd = [[TianmuSplashAd alloc]init];
    // 开屏广告posid
    _splashAd.posId = @"e815b3c6d02a";
    // 开屏广告委托对象
    _splashAd.delegate = self;
    // 设置默认启动图(一般设置启动图的平铺颜色为背景颜色，使得视觉效果更加平滑)
    _splashAd.backgroundColor = [UIColor adsy_getColorWithImage:[UIImage imageNamed:@"750x1334.png"] withNewSize:[UIScreen mainScreen].bounds.size];
    [_splashAd loadAdWithBottomView:self.fullBool ? nil : [self getBottomView]];
    
}

- (void)bidWin {
    if (!_isHeadBidding) {
        [self.view makeToast:@"当前广告不是竞价广告"];
        return;
    }
    if (!_isSucceed || !_splashAd) {
        [self.view makeToast:[NSString stringWithFormat:@"开屏广告未加载成功"]];
        return;
    }
    // 发送竞价成功通知
    // 如天目从竞价队列中胜出，则传入广告返回的出价，如：[adView bidPrice]（单位：分）
    [_splashAd sendWinNotificationWithPrice:[_splashAd bidPrice]];
    
    [_splashAd showInWindow:[UIApplication sharedApplication].keyWindow];
    
}
- (UIView *)getBottomView{
    CGFloat bottomViewHeight = [UIScreen mainScreen].bounds.size.height * 0.15;
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, bottomViewHeight);
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Tianmu_Logo.png"]];
    logoImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-135)/2, (bottomViewHeight-46)/2, 135, 46);
    [bottomView addSubview:logoImageView];
    return bottomView;
}
- (void)bidFail {
    if (!_isHeadBidding) {
        [self.view makeToast:@"当前广告不是竞价广告"];
        return;
    }
    if (!_isSucceed || !_splashAd) {
        [self.view makeToast:[NSString stringWithFormat:@"开屏广告未加载成功"]];
        return;
    }
//    发送竞价成功通知
    [_splashAd sendWinFailNotificationReason:(TianmuAdBiddingLossReasonLowPrice) winnerPirce:100];

    [_splashAd showInWindow:[UIApplication sharedApplication].keyWindow];
    
}

- (void)loadAndShow {
    _isHeadBidding = NO;
    _isSucceed = NO;
        // 初始化开屏广告加载实例
    if (!_splashAd)
        _splashAd = [[TianmuSplashAd alloc]init];
    // 开屏广告posid
    _splashAd.posId = @"0b815e3cda9f";
    // 开屏广告委托对象
    _splashAd.delegate = self;
    // 设置默认启动图(一般设置启动图的平铺颜色为背景颜色，使得视觉效果更加平滑)
    _splashAd.backgroundColor = [UIColor adsy_getColorWithImage:[UIImage imageNamed:@"750x1334.png"] withNewSize:[UIScreen mainScreen].bounds.size];
    // 开屏广告加载并展示
    [_splashAd loadAndShowInWindow:[UIApplication sharedApplication].keyWindow withBottomView:self.fullBool ? nil : [self getBottomView]];
}

// 开屏广告回调方法
#pragma mark - TianmuSplashAdDelegate

/**
 *  开屏广告请求成功
 */
- (void)tianmuSplashAdSuccessLoad:(TianmuSplashAd *)splashAd {
    _isSucceed = YES;
    if (_isHeadBidding) {
        [self.view makeToast:[NSString stringWithFormat:@"询价成功：%ld",[splashAd bidPrice]]];
    }
        
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
    [self.view makeToast:[NSString stringWithFormat:@"开屏广告渲染失败：%@",error]];
    _isSucceed = NO;
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
    
}

/**
 *  开屏广告关闭回调
 */
- (void)tianmuSplashAdClosed:(TianmuSplashAd *)splashAd {
    _splashAd = nil;
}

/**
 *  开屏广告倒计时结束回调
 */
- (void)tianmuSplashAdCountdownToZero:(TianmuSplashAd *)splashAd {
    
}

/**
 *  开屏广告点击跳过回调
 */
- (void)tianmuSplashAdSkiped:(TianmuSplashAd *)splashAd {
    
}

/**
 *  开屏广告关闭落地页回调
 */
- (void)tianmuSplashAdCloseLandingPage:(TianmuSplashAd *)splashAd {
    
}

/**
 *  开屏广告展示失败
 */
- (void)tianmuSplashAdFailToShow:(TianmuSplashAd *)splashAd error:(NSError *)error {
    NSLog(@"%@",error);
    [self.view makeToast:[NSString stringWithFormat:@"splash开屏广告展示失败%@",error]];
}






@end
