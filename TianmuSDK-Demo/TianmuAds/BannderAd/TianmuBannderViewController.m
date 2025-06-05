//
//  ADTianmuBannderViewController.m
//  TianmuSDK-Demo
//
//  Created by 陈则富 on 2021/9/13.
//

#import "TianmuBannderViewController.h"
#import <ADSuyiKit/ADSuyiKitMacros.h>
#import <TianmuSDK/TianmuBannerAdView.h>
#import "UIView+Toast.h"

@interface AdSuyiBannerItem : NSObject

@property (nonatomic, assign) CGFloat rate;

@property (nonatomic, copy) NSString *posId;

@property (nonatomic, copy) NSString *title;

+ (instancetype)itemWithRate:(CGFloat)rate posId:(NSString *)posId title:(NSString *)title;

@end


@interface TianmuBannderViewController()<TianmuBannerAdViewDelegate> {
    BOOL _isHeadBidding;
    BOOL _isSucceed;
}

@property (nonatomic, copy) NSArray<AdSuyiBannerItem *> *array;

@property (nonatomic, strong) NSMutableArray<UIButton *> *btns;

@property (nonatomic ,strong) TianmuBannerAdView  *bannerAd;

@end

@implementation TianmuBannderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat margin = self.view.bounds.size.width/5 - 320/5;
    
    UIButton *loadAndShowBtn = [UIButton new];
    [loadAndShowBtn setTitle:@"普通请求" forState:(UIControlStateNormal)];
    [loadAndShowBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    loadAndShowBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    loadAndShowBtn.backgroundColor = UIColor.lightGrayColor;
    loadAndShowBtn.clipsToBounds = YES;
    loadAndShowBtn.layer.cornerRadius = 3;
    [loadAndShowBtn addTarget:self action:@selector(loadNomarlAd) forControlEvents:(UIControlEventTouchUpInside)];
    loadAndShowBtn.frame = CGRectMake(margin, self.view.bounds.size.height - 60, 80, 30);
    [self.view addSubview:loadAndShowBtn];
    [self.view bringSubviewToFront:loadAndShowBtn];
    
    UIButton *loadBtn = [UIButton new];
    [loadBtn setTitle:@"竞价请求" forState:(UIControlStateNormal)];
    [loadBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    loadBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    loadBtn.backgroundColor = UIColor.lightGrayColor;
    loadBtn.clipsToBounds = YES;
    loadBtn.layer.cornerRadius = 3;
    [loadBtn addTarget:self action:@selector(loadBidAd) forControlEvents:(UIControlEventTouchUpInside)];
    loadBtn.frame = CGRectMake(margin*2 + 80, self.view.bounds.size.height - 60, 80, 30);
    [self.view addSubview:loadBtn];
    [self.view bringSubviewToFront:loadBtn];
    
    UIButton *bidWinBtn = [UIButton new];
    [bidWinBtn setTitle:@"竞价成功" forState:(UIControlStateNormal)];
    [bidWinBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    bidWinBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    bidWinBtn.backgroundColor = UIColor.lightGrayColor;
    bidWinBtn.clipsToBounds = YES;
    bidWinBtn.layer.cornerRadius = 3;
    [bidWinBtn addTarget:self action:@selector(bidWin) forControlEvents:(UIControlEventTouchUpInside)];
    bidWinBtn.frame = CGRectMake(160 + margin*3, self.view.bounds.size.height - 60, 80, 30);
    [self.view addSubview:bidWinBtn];
    [self.view bringSubviewToFront:bidWinBtn];
    
    UIButton *bidFailBtn = [UIButton new];
    [bidFailBtn setTitle:@"竞价失败" forState:(UIControlStateNormal)];
    [bidFailBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    bidFailBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    bidFailBtn.backgroundColor = UIColor.lightGrayColor;
    bidFailBtn.clipsToBounds = YES;
    bidFailBtn.layer.cornerRadius = 3;
    [bidFailBtn addTarget:self action:@selector(bidFail) forControlEvents:(UIControlEventTouchUpInside)];
    bidFailBtn.frame = CGRectMake(margin*4 + 240, self.view.bounds.size.height - 60, 80, 30);
    [self.view addSubview:bidFailBtn];
    [self.view bringSubviewToFront:bidFailBtn];
}
- (void)loadNomarlAd{
    _isHeadBidding = NO;
    _isSucceed = NO;
    AdSuyiBannerItem *item = self.array[0];
    [self loadBannerWithRate:item.rate posId:item.posId];
}

- (void)loadBidAd{
    _isHeadBidding = YES;
    _isSucceed = NO;
    AdSuyiBannerItem *item = self.array[0];
    [self loadBannerWithRate:item.rate posId:@"9012784e6c3b"];

}

- (void)bidWin{
    if (!_isHeadBidding) {
        [self.view makeToast:@"当前广告不是竞价广告"];
        return;
    }
    if (!_isSucceed || !_bannerAd) {
        [self.view makeToast:[NSString stringWithFormat:@"横幅广告未加载成功"]];
        return;
    }
    // 发送竞价成功通知
    // 如天目从竞价队列中胜出，则传入广告返回的出价，如：[adView bidPrice]（单位：分）
    [self.bannerAd sendWinNotificationWithPrice:[self.bannerAd bidPrice]];
}

- (void)bidFail{
    if (!_isHeadBidding) {
        [self.view makeToast:@"当前广告不是竞价广告"];
        return;
    }
    if (!_isSucceed || !_bannerAd) {
        [self.view makeToast:[NSString stringWithFormat:@"横幅广告未加载成功"]];
        return;
    }
    [self.bannerAd sendWinFailNotificationReason:TianmuAdBiddingLossReasonOther winnerPirce:100];
    
}
#pragma mark - Touch event

- (void)clickLoadBannerButton:(UIButton *)btn {
    btn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.enabled = YES;
    });
    for (UIButton *lbtn in self.btns) {
        lbtn.backgroundColor = (lbtn == btn) ? [UIColor colorWithRed:222/255.0 green:236/255.0 blue:251/255.0 alpha:1.0] : [UIColor whiteColor];
    }
    AdSuyiBannerItem *item = self.array[btn.tag];
    [self loadBannerWithRate:item.rate posId:item.posId];
}


- (void)loadBannerWithRate:(CGFloat)rate posId:(NSString *)posId {
    [self.bannerAd removeFromSuperview];
    // 1、初始化banner视图，并给定frame值，rate取值根据banner的尺寸
    self.bannerAd = [[TianmuBannerAdView alloc] initWithFrame:CGRectMake(0, 250, kADSYScreenWidth, kADSYScreenWidth / rate) posId:posId];
    self.bannerAd.delegate = self;
    self.bannerAd.viewController = self;
    [self.view addSubview:self.bannerAd];
    [self.bannerAd loadRequest];
   
    
}

#pragma mark - Helper - UI

- (void)createButtonWithItem:(AdSuyiBannerItem *)item index:(NSInteger)index {
    UIButton *btn = [UIButton new];
    [self.view addSubview:btn];

    static NSInteger btn_num_per_line = 4;
    static CGFloat btn_height = 32;
    static CGFloat btn_margin_top = 10;
    static CGFloat btn_margin_left = 10;
    static CGFloat margin_top = 16;
    static CGFloat margin_left = 17;
    
    CGFloat btn_width = ((self.view.frame.size.width - margin_left * 2) - ((btn_num_per_line - 1) * btn_margin_left)) / btn_num_per_line;
    CGFloat x = ((index % btn_num_per_line) * (btn_margin_left + btn_width)) + margin_left;
    CGFloat y = (index / btn_num_per_line) * (btn_margin_top + btn_height) + margin_top + 100;
    
    btn.frame = CGRectMake(x, y, btn_width, btn_height);
    
    btn.tag = index;
    
    [btn addTarget:self action:@selector(clickLoadBannerButton:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:item.title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0 green:122/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:204/255.0 alpha:1.0].CGColor;
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btns addObject:btn];
    
    [self.view addSubview:btn];
}

/**
 *  请求广告条数据成功后调用
 *  当接收服务器返回的广告数据成功后调用该函数
 */
- (void)tianmuBannerSuccessLoad:(TianmuBannerAdView *)tianmuBannerView {
    // 重要‼️ 如果是竞价广告位，且支持自刷新，需要处理自刷新的竟赢上报
    _isSucceed = YES;
    if (_isHeadBidding) {
        [self.view makeToast:[NSString stringWithFormat:@"询价成功：%ld",[tianmuBannerView bidPrice]]];
    }
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

/**
 *  关闭落地页
 */
- (void)tianmuBannerViewCloseLandingPage:(TianmuBannerAdView *)tianmuBannerView {
    
}

#pragma mark - Lazy load

- (NSArray<AdSuyiBannerItem *> *)array {
    if(!_array) {
        NSMutableArray *array = [NSMutableArray new];
        
        [array addObject:[AdSuyiBannerItem itemWithRate:640/100.0 posId:@"e592f0da3b71" title:@"640*100"]];
        
        _array = [array copy];
    }
    return _array;
}

- (NSMutableArray<UIButton *> *)btns {
    if(!_btns) {
        _btns = [NSMutableArray new];
    }
    return _btns;;
}

@end

@implementation AdSuyiBannerItem

+ (instancetype)itemWithRate:(CGFloat)rate posId:(NSString *)posId title:(NSString *)title {
    AdSuyiBannerItem *item = [super new];
    if(self) {
        item.rate = rate;
        item.posId = posId;
        item.title = title;
    }
    return item;
}

@end
