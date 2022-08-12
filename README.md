# TianmuSDK iOS接入文档 v1.3.1.1











[TOC]























## 修订历史

| 文档版本 | 修订日期   | 修订说明                                                     |
| -------- | ---------- | ------------------------------------------------------------ |
| v1.0.0   | 2021-11-04 | 首版发布 |
| v1.1.0   | 2022-4-25 | 支持竞价功能（支持开屏，模板&自渲染信息流，插屏，激励视频） |
| v1.2.0   | 2022-5-25 | 插屏广告支持滑一滑或摇一摇交互方式；新增个性化广告开关 |
| v1.3.0   | 2022-6-10 | 信息流、插屏广告支持多种滑动样式；开屏热区按钮调整 |
| v1.3.1   | 2022-7-13 | 摇一摇灵敏度调整；新增支持浮窗广告；修复已知问题 |
<div STYLE="page-break-after: always;"></div>


## 1.1 概述

尊敬的开发者朋友，欢迎您使用天目广告SDK。通过本文档，您可以在几分钟之内轻松完成广告的集成过程。

操作系统： iOS 9.0 及以上版本

运行设备：iPhone

- `TianmuSDK Objective-C Demo地址`[[TianmuSDK Objective-C Demo]](https://github.com/ADSuyi/TianmuSDKDemo-OC)
- `TianmuSDK Swift Demo地址`[[TianmuSDK Swift Demo]](https://github.com/ADSuyi/TianmuSDKDemo-Swift.git)



## 2.1 采用cocoapods进行SDK的导入

推荐使用pod命令导入

```ruby
pod 'TianmuSDK','~>1.3.1.1'
```

<div STYLE="page-break-after: always;"></div>



<div STYLE="page-break-after: always;"></div>

<div STYLE="page-break-after: always;"></div>


## 3.1 工程环境配置

1. 打开项目的 app target，查看 Build Settings 中的 Linking-Other Linker Flags 选项，确保含有 -ObjC 一值， 若没有则添加。

2. 在项目的 app target 中，查看 Build Settings 中的 Build options - Enable Bitcode 选项， 设置为NO。 
3. info.plist 添加支持 Http访问字段

```obj-c
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>
```

4. Info.plist 添加定位权限字段

```obj-c
NSLocationWhenInUseUsageDescription
NSLocationAlwaysAndWhenInUseUsageDeion
```

5. Info.plist推荐设置白名单，可提高广告收益

```obj-c
<key>LSApplicationQueriesSchemes</key>
    <array>
        <string>dianping</string>
        <string>imeituan</string>
        <string>com.suning.SuningEBuy</string>
        <string>openapp.jdmobile</string>
        <string>vipshop</string>
        <string>snssdk141</string>
        <string>ctrip</string>
        <string>suning</string>
        <string>qunariphone</string>
        <string>QunarAlipay</string>
        <string>qunaraphone</string>
        <string>yohobuy</string>
        <string>kaola</string>
        <string>agoda</string>
        <string>openapp.xzdz</string>
        <string>beibeiapp</string>
        <string>taobao</string>
        <string>tmall</string>
        <string>openjd</string>
        <string>jhs</string>
        <string>yhd</string>
        <string>wireless1688</string>
        <string>GomeEShop</string>
        <string>wbmain</string>
        <string>xhsdiscover</string>
        <string>douyin</string>
        <string>pinduoduo</string>
        <string>jdmobile</string>
        <string>tbopen</string>
        <string>pddopen</string>
        <string>mogujie</string>
        <string>koubei</string>
        <string>eleme</string>
        <string>youku</string>
        <string>gengmei</string>
        <string>airbnb</string>
        <string>alipays</string>
        <string>didicommon</string>
        <string>OneTravel</string>
        <string>farfetchCN</string>
        <string>farfetch</string>
        <string>snssdk1112</string>
        <string>snssdk1128</string>
        <string>miguvideo</string>
        <string>kfcapplinkurl</string>
        <string>iqiyi</string>
        <string>uclink</string>
        <string>app.soyoung</string>
    </array>
```



## 3.2 iOS14适配

由于iOS14中对于权限和隐私内容有一定程度的修改，而且和广告业务关系较大，请按照如下步骤适配，如果未适配。不会导致运行异常或者崩溃等情况，但是会一定程度上影响广告收入。敬请知悉。

1. 应用编译环境升级至 Xcode 12.0 及以上版本；
3. 设置SKAdNetwork和IDFA权限；



### 3.2.1 获取App Tracking Transparency授权（弹窗授权获取IDFA）

从 iOS 14 开始，在应用程序调用 App Tracking Transparency 向用户提跟踪授权请求之前，IDFA 将不可用。

1. 更新 Info.plist，添加 NSUserTrackingUsageDescription 字段和自定义文案描述。

   弹窗小字文案建议：

   - `获取标记权限向您提供更优质、安全的个性化服务及内容，未经同意我们不会用于其他目的；开启后，您也可以前往系统“设置-隐私 ”中随时关闭。`
   - `获取IDFA标记权限向您提供更优质、安全的个性化服务及内容；开启后，您也可以前往系统“设置-隐私 ”中随时关闭。`

```objective-c
<key>NSUserTrackingUsageDescription</key>
<string>获取标记权限向您提供更优质、安全的个性化服务及内容，未经同意我们不会用于其他目的；开启后，您也可以前往系统“设置-隐私 ”中随时关闭</string>
```

2. 向用户申请权限。

```objective-c
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
...
- (void)requestIDFA {
  [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
    // 无需对授权状态进行处理
  }];
}
// 建议启动App用户同意协议后就获取权限或者请求广告前获取
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
         // 针对iOS15中不弹窗被拒解决方案，方案1：经测试可能无效
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)),             dispatch_get_main_queue(), ^{
            // 用户同意协议后获取
                      //[self requestIDFA];
        //});
}
// 方案2：根据官方文档调整权限申请时机
// 根据官方开发文档选择在此方法中进行权限申请
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 用户同意协议后获取
      [self requestIDFA];
}
// 建议方案1与2一起使用，可正常通过审核。
```


<div STYLE="page-break-after: always;"></div>

3. iOS15中不弹授权窗问题解决方法：

```objective-c

// 针对iOS15不弹窗问题解决方法，根据官方文档可将权限申请放在becomeActive方法
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 用户同意协议后获取
      [self requestIDFA];
}
```

<div STYLE="page-break-after: alway;"></div>

## 4.1 天目SDK的初始化

`申请的appid必须与您的包名一一对应`


```obj-c
#import <TianmuSDK/TianmuSDK.h>
[TianmuSDK initWithAppId:@"1001006" completionBlock:^(NSError * _Nullable error) {
     if (error)
         NSLog(@"初始化失败%@",error);
 }];
```

获取TianmuSDK版本号

```obj-c
//获取SDK版本号
NSString *sdkVersion = [TianmuSDK getSDKVersion];
```

<div STYLE="page-break-after: always;"></div>


## 4.2 开屏广告 - TianmuSplashAd

开屏广告会在您的应用开启时加载展示，拥有固定展示时间，展示完毕后自动关闭并进入您的应用主界面。

开屏广告建议在闪屏页进行展示，开屏广告的宽度和高度取决于容器的宽高，都是会撑满广告容器；**开屏广告的高度必须大于等于屏幕高度（手机屏幕完整高度，包括状态栏之类）的75%**，否则可能会影响收益计费。

推荐在 `AppDelegate`的 `didFinishLaunchingWithOptions`方法的 `return YES`之前调用开屏。

`OC请求开屏代码示例：`[[开屏代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-OC/blob/main/TianmuSDK-Demo/AppDelegate.m)

`Swift请求开屏代码示例：`[[开屏代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-Swift/blob/main/TianmuSDK-iOS-Swift/AppDelegate.swift)

开屏广告 - TianmuSplashAd：

```obj-c
@interface TianmuSplashAd : NSObject

/**
 *  委托
 */
@property (nonatomic ,weak) id<TianmuSplashAdDelegate>  delegate;

/**
 * 跳过按钮的类型，可以通过此接口替换开屏广告的跳过按钮样式
 */
@property (nonatomic, strong, null_resettable) UIView<TianmuSplashSkipViewProtocol> *skipView;

/**
 * 广告id
 */
@property (nonatomic ,copy) NSString  *posId;

/**
 * 不使用自带跳过视图
 */
@property (nonatomic, readwrite, assign) BOOL hiddenSkipView;

/**
开屏的默认背景色,或者启动页,为nil则代表透明
*/
@property (nonatomic, copy, nullable) UIColor *backgroundColor;

/**
加载开屏广告
如果全屏广告bottomView设置为nil
@param window 开屏广告展示的window
@param bottomView 底部logo视图, 高度不能超过屏幕的25%, 建议: 开屏的广告图片默认640 / 960比例, 可以用 MIN(screenHeight - screenWidth * (960 / 640.0), screenHeight * 0.25) 得出bottomview的高度
*/
- (void)loadAndShowInWindow:(UIWindow *)window withBottomView:(nullable UIView *)bottomView;


/**
 加载开屏广告（不会自动调用展示方法，需开发者于成功回调后调用showAdInWindow:withBottomView）
 建议竞价广告询价使用
 */
- (void)loadAd;

/**
 展示开屏广告（与loadAd一同使用，于成功回调后调用）
 */
- (void)showInWindow:(UIWindow *)window withBottomView:(nullable UIView *)bottomView;


/**
 返回广告的出价，单位：分
 
 @return 成功返回一个大于等于0的值，小于等于0表示广告请求失败或获取eCPM时机不正确(请于请求广告成功后获取)
*/
- (NSInteger)bidPrice;

/**
 返回广告的底价，单位：分
 
 @return 成功返回一个大于等于0的值，小于等于0表示广告请求失败或获取底价时机不正确(请于请求广告成功后获取)
*/
- (NSInteger)bidFloor;

/**
 *  竞胜之后调用, 需要在展示广告之前调用
 *  @param price 如天目从竞价队列中胜出，则传入竞价队列第二高价（单位：分）；如仅有天目平台竞价广告，则竞赢上报的价格为当前广告对象的底价，如：[adView bidFloor]（单位：分）
 */
- (void)sendWinNotificationWithPrice:(NSInteger)price;

/**
 *  竞败之后调用,
 *  @param reason 竞价失败原因
 *  @param winnerPirce 竟赢者价格，单位：分
 */
- (void)sendWinFailNotificationReason:(TianmuAdBiddingLossReason)reason winnerPirce:(NSInteger)winnerPirce;


@end

```

<div STYLE="page-break-after: always;"></div>

开屏广告代理回调 - TianmuSplashAdDelegate

```obj-c
@protocol TianmuSplashAdDelegate <NSObject>

@optional
/**
 *  开屏广告请求成功
 */
- (void)tianmuSplashAdSuccessLoad:(TianmuSplashAd *)splashAd;

/**
 *  开屏广告素材加载成功
 */
- (void)tianmuSplashAdDidLoad:(TianmuSplashAd *)splashAd;

/**
 *  开屏广告请求失败
 */
- (void)tianmuSplashAdFailLoad:(TianmuSplashAd *)splashAd withError:(NSError *)error;
/**
 *  开屏广告展示失败
 */
- (void)tianmuSplashAdRenderFaild:(TianmuSplashAd *)splashAd withError:(NSError *)error;

/**
 *  开屏广告曝光回调
 */
- (void)tianmuSplashAdExposured:(TianmuSplashAd *)splashAd;

/**
 *  开屏广告点击回调
 */
- (void)tianmuSplashAdClicked:(TianmuSplashAd *)splashAd;

/**
 *  开屏广告倒计时结束回调
 */
- (void)tianmuSplashAdCountdownToZero:(TianmuSplashAd *)splashAd;

/**
 *  开屏广告点击跳过回调
 */
- (void)tianmuSplashAdSkiped:(TianmuSplashAd *)splashAd;

/**
 *  开屏广告关闭回调
 */
- (void)tianmuSplashAdClosed:(TianmuSplashAd *)splashAd;

/**
 *  开屏广告关闭落地页回调
 */
- (void)tianmuSplashAdCloseLandingPage:(TianmuSplashAd *)splashAd;

/**
 *  开屏广告展示失败
 */
- (void)tianmuSplashAdFailToShow:(TianmuSplashAd *)splashAd error:(NSError *)error;

@end

```

<div STYLE="page-break-after: always;"></div>

请求开屏代码示例：
```obj-c
#import <TianmuSDK/TianmuSplashAd.h>
#import <ADSuyiKit/ADSuyiKit.h>

/*
 * 推荐在AppDelegate中的最后加载开屏广告
 * 其他的接入方式会有需要特殊注意的方式，遇到过的相关问题在SDK相关问题的文档中有提到
 * 不建议在开屏展示过程中做控制器的切换（如：开屏广告关闭回调时切换当前window的根控制器或者present另外一个控制器）
 */

- (void)loadSplashAd{
      //1、 初始化开屏加载实例
    _splashAd = [[TianmuSplashAd alloc]init];
    _splashAd.posId = @"0b815e3cda9f";
    _splashAd.delegate = self;
    // 设置默认启动图(一般设置启动图的平铺颜色为背景颜色，使得视觉效果更加平滑)
    _splashAd.backgroundColor = [UIColor adsy_getColorWithImage:[UIImage imageNamed:@"750x1334.png"] withNewSize:[UIScreen mainScreen].bounds.size];
    
    [_splashAd loadAndShowInWindow:[UIApplication sharedApplication].keyWindow withBottomView:nil];
}

// 8、代理回调
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
}
/**
 *  开屏广告渲染失败
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
 *  开屏广告关闭落地页
 */

- (void)tianmuSplashAdCloseLandingPage:(TianmuSplashAd *)splashAd {
    _splashAd = nil;
}
/**
 *  开屏广告展示失败
 */
- (void)tianmuSplashAdFailToShow:(TianmuSplashAd *)splashAd error:(NSError *)error {
  
}


```

<div STYLE="page-break-after: always;"></div>


## 4.3 Banner横幅广告 - TianmuBannerAdView

Banner广告(横幅广告)位于app顶部、中部、底部任意一处，横向贯穿整个app页面；当用户与app互动时，Banner广告会停留在屏幕上，并可在一段时间后自动刷新。

`OC请求横幅代码示例：`[[横幅代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-OC/blob/main/TianmuSDK-Demo/TianmuAds/BannderAd/TianmuBannderViewController.m)

`Swift请求横幅代码示例：`[[横幅代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-Swift/blob/main/TianmuSDK-iOS-Swift/TianmuAds/TianmuBannderViewController.swift)

横幅广告 - TianmuBannerAdView：

```obj-c
@interface TianmuBannerAdView : UIView

/**
 *  委托 
 */
@property (nonatomic ,weak) id<TianmuBannerAdViewDelegate>  delegate;

/*
 详解：当前ViewController[必传]
 */
@property (nonatomic ,weak) UIViewController  *viewController;

/**
 *  构造方法
 *  详解：frame - banner 展示的位置和大小
 *       postId - 广告位 ID
 */
- (instancetype)initWithFrame:(CGRect)frame posId:(NSString *)posId;

/**
 *  开始请求广告
 */
- (void)loadRequest;


@end
```

横幅广告 - TianmuBannerAdViewDelegate

```obj-c
/**
 *  请求广告条数据成功后调用
 *  当接收服务器返回的广告数据成功后调用该函数
 */
- (void)tianmuBannerSuccessLoad:(TianmuBannerAdView *)tianmuBannerView;

/**
 *  请求广告条数据失败后调用
 *  当接收服务器返回的广告数据失败后调用该函数
 */
- (void)tianmuBannerViewFailedToLoadWithError:(NSError *)error;

/**
 *  曝光回调
 */
- (void)tianmuBannerViewWillExpose:(TianmuBannerAdView *)tianmuBannerView;

/**
 *  点击回调
 */
- (void)tianmuBannerViewClicked:(TianmuBannerAdView *)tianmuBannerView;

/**
 *  被用户关闭时调用
 */
- (void)tianmuBannerViewWillClose:(TianmuBannerAdView *)tianmuBannerView;

/**
 *  被用户关闭广告落地页调用
 */
- (void)tianmuBannerViewCloseLandingPage:(TianmuBannerAdView *)tianmuBannerView;

```


请求横幅广告请求示例：

```obj-c
#import <TianmuSDK/TianmuBannerAdView.h>

- (void)loadBannerAd {
    // 1、初始化banner视图，并给定frame值
    self.bannerAd = [[TianmuBannerAdView alloc] initWithFrame:CGRectMake(0, 250, kADSYScreenWidth, kADSYScreenWidth / rate) posId:posId];
    // 2、设置委托对象
    self.bannerAd.delegate = self;
    
    // 3、当前ViewController
    self.bannerAd.viewController = self;
    
    // 4、添加到父视图
    [self.view addSubview:self.bannerAd];
    
    // 5、请求广告
    [self.bannerAd loadRequest];
}

// 5、代理回调
#pragma mark - TianmuBannerAdViewDelegate
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

/**
 *  关闭落地页
 */
- (void)tianmuBannerViewCloseLandingPage:(TianmuBannerAdView *)tianmuBannerView {
    
}
```

<div STYLE="page-break-after: always;"></div>


## 4.4 模板信息流广告 - TianmuNativeExpressAd

模板信息流广告，具备上下图文，左右图文和纯图等样式，开发者可从天目管理后台设置广告位样式，模板信息流广告不得被遮挡。** **注意，信息流广告点击关闭时，开发者需要在- (void)tianmuExpressAdClosed:回调中将广告视图隐藏或移除**

`OC请求信息流广告代码示例：`[[信息流广告代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-OC/blob/main/TianmuSDK-Demo/TianmuAds/NativeAd/TianmuNativeAdViewController.m)

`Swift请求信息流广告代码示例：`[[信息流广告代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-Swift/blob/main/TianmuSDK-iOS-Swift/TianmuAds/TianmuNativeAdViewController.swift)

模板信息流广告 - TianmuNativeExpressAd：

```obj-c
@interface TianmuNativeExpressAd : NSObject

/**
 *  委托 [必须实现]
 */
@property (nonatomic ,weak) id<TianmuNativeExpressAdDelegate>  delegate;

/**
 广告位id
*/
@property (nonatomic, copy) NSString *posId;


/**
 请求超时时间,默认为4s,需要设置3s及以上
*/
@property (nonatomic, assign) NSInteger tolerateTimeout;

/**
 一般为当前展示广告控制器
*/
@property (nonatomic, weak) UIViewController *controller;

/**
 是否设置静音模式
*/
@property (nonatomic ,assign) BOOL playMute;
/**
  是否设置自动播放模式
 */
@property (nonatomic ,assign) BOOL autoPlay;
/**
 初始化广告加载器，需传入需要广告尺寸(一般按照16：9比例返回广告视图）
 */
- (instancetype)initWithAdSize:(CGSize)adSize NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

/**
 加载广告

 @param count 拉取几条广告,建议区间 1~4, 超过可能无法拉取到
 */
- (void)loadAdWithCount:(int)count;

/**
 *  竞胜之后调用, 需要在展示广告之前调用（必须调用否则无法展示广告）
 *
 *  @param adView 竞价成功的广告视图，该广告价格请调用[adView getBidPrice]获取，具体见TianmuExpressViewRegisterProtocol，单位：分
 *  @param price 如天目从竞价队列中胜出，则传入竞价队列第二高价（单位：分）；如仅有天目平台竞价广告，则竞赢上报的价格为当前广告对象的底价，如：[adView bidFloor]（单位：分）
 */
- (void)sendWinNotificationWithAdView:(UIView<TianmuExpressViewRegisterProtocol> *)adView price:(NSInteger)price;

/**
 *  竞败之后调用,
 *  @param reason 竞价失败原因
 *  @param winnerPirce 竟赢者价格，单位：分
 *  @param adView 竞价失败的广告视图
 */
- (void)sendWinFailNotificationReason:(TianmuAdBiddingLossReason)reason winnerPirce:(NSInteger)winnerPirce AdView:(UIView<TianmuExpressViewRegisterProtocol> *)adView;

@end


```

模板信息流广告代理回调 - TianmuNativeExpressAdDelegate

```obj-c
@protocol TianmuNativeExpressAdDelegate<NSObject>

/**
 模板信息流广告加载成功
 */
- (void)tianmuExpressAdSucceedToLoad:(TianmuNativeExpressAd *)expressAd views:(NSArray<__kindof UIView<TianmuExpressViewRegisterProtocol> *> *)views;

/**
 模板信息流广告加载失败
 */
- (void)tianmuExpressAdFailToLoad:(TianmuNativeExpressAd *)expressAd error:(NSError *)error;

/**
 模板信息流广告渲染成功
 */
- (void)tianmuExpressAdRenderSucceed:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView;

/**
 模板信息流广告渲染失败
 */
- (void)tianmuExpressAdRenderFail:(TianmuNativeExpressView *)expressAd error:(NSError *)error;

/**
 模板信息流广告关闭
 */
- (void)tianmuExpressAdClosed:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView;

/**
 模板信息流广告点击
 */
- (void)tianmuExpressAdClick:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView;

/**
 模板信息流广告展示
 */
- (void)tianmuExpressAdDidExpourse:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView;

/**
 模板信息流广告关闭落地页
 */
- (void)tianmuExpressAdDidCloseLandingPage:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView;

/**
 *以下为视频信息流相关回调
 */

/**
 模板信息流视频广告开始播放
 */
- (void)tianmuExpressAdVideoPlay:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView;

/**
 模板信息流视频广告视频播放失败
 */
- (void)tianmuExpressAdVideoPlayFail:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView error:(NSError *)error;

/**
 模板信息流视频广告视频暂停
 */
- (void)tianmuExpressAdVideoPause:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView;

/**
 模板信息流视频广告视频播放完成
 */
- (void)tianmuExpressAdVideoFinish:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView;


@end
```


请求信息流广告请求示例：

```obj-c
#import <TianmuSDK/TianmuNativeExpressAd.h>

if(!_nativeAd) {
   // 1、信息流广告初始化
    _nativeAd = [[TianmuNativeExpressAd alloc]initWithAdSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width, 10)];
    _nativeAd.delegate = self;
    _nativeAd.posId = @"bfc718eda042";
    _nativeAd.controller = self;
}

// 2、加载信息流广告
[_nativeAd loadAdWithCount:1];

// 4、代理回调
#pragma mark - TianmuNativeExpressAdDelegate

// 模板信息流广告加载成功
- (void)tianmuExpressAdSucceedToLoad:(TianmuNativeExpressAd *)expressAd views:(NSArray<__kindof UIView<TianmuExpressViewRegisterProtocol> *> *)views {
    for (TianmuNativeExpressView *adView in views) {
        [adView tianmu_registViews:@[adView]];
    }
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

// 模板信息流广告加载失败
- (void)tianmuExpressAdFailToLoad:(TianmuNativeExpressAd *)expressAd error:(NSError *)error {
    NSLog(@"信息流广告加载失败%@",error);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    });
}

// 模板信息流广告渲染成功
- (void)tianmuExpressAdRenderSucceed:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView {
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < 6; i ++) {
            [self.items addObject:[NSNull null]];
        }
        [self.items addObject:expressAdView];
        [self.tableView reloadData];
    });
}

// 模板信息流广告渲染失败
- (void)tianmuExpressAdRenderFail:(TianmuNativeExpressAd *)expressAd error:(NSError *)error {
    [self.view makeToast:[NSString stringWithFormat:@"信息流渲染失败：%@",error]];
}

// 模板信息流广告关闭
- (void)tianmuExpressAdClosed:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView {
    [self.items removeObject:expressAdView];
    [self.tableView reloadData];
}

// ，模板信息流广告点击
- (void)tianmuExpressAdClick:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView {
    
}


// 模板信息流广告展示
- (void)tianmuExpressAdDidExpourse:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView {
    
}

/**
 *以下为视频信息流相关回调
 */

/**
 模板信息流视频广告开始播放
 */
- (void)tianmuExpressAdVideoPlay:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView {
    NSLog(@"视频信息流播放");
}

/**
 模板信息流视频广告视频播放失败
 */
- (void)tianmuExpressAdVideoPlayFail:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView error:(NSError *)error {
    NSLog(@"视频信息流播放失败，%@",error);
}

/**
 模板信息流视频广告视频暂停
 */
- (void)tianmuExpressAdVideoPause:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView {
    NSLog(@"视频信息流播放暂停");
}

/**
 模板信息流视频广告视频播放完成
 */
- (void)tianmuExpressAdVideoFinish:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView {
    NSLog(@"视频信息流播放完成");
}

/**
 关闭落地页
 */
- (void)tianmuExpressAdDidCloseLandingPage:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView {
    
}

```

<div STYLE="page-break-after: always;"></div>

<div STYLE="page-break-after: always;"></div>


## 4.5 插屏广告 - TianmuInterstitialAd

插屏广告是移动广告的一种常见形式，在应用流程中弹出，当应用展示插屏广告时，用户可以选择点击广告，访问其目标网址，也可以将其关闭并返回应用。在应用执行流程的自然停顿点，适合投放这类广告。

`OC请求插屏广告代码示例：`[[插屏广告代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-OC/blob/main/TianmuSDK-Demo/TianmuAds/InterstitialAd/TianmuInterstitialAdViewController.m)

`Swift请求插屏广告代码示例：`[[插屏广告代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-Swift/blob/main/TianmuSDK-iOS-Swift/TianmuAds/TianmuInterstitialAdViewController.swift)

插屏广告 - TianmuInterstitialAd：

```obj-c
@interface TianmuInterstitialAd : NSObject

/**
 委托对象
 */
@property (nonatomic ,weak) id<TianmuInterstitialAdDelegate>  delegate;

/**
 详解：当前ViewController
 */
@property (nonatomic, weak) UIViewController *controller;

/**
 请求超时时间,默认为4s,需要设置3s及以上
 */
@property (nonatomic, assign) NSInteger tolerateTimeout;

/**
 广告位id
*/
@property (nonatomic, copy) NSString *posId;

/**
 是否设置视频静音模式
*/
@property (nonatomic ,assign) BOOL playMute;
/**
 是否支持摇一摇
*/
@property (nonatomic ,assign) BOOL isSupportShake;
/**
 支持滑一滑 滑动方向
*/
@property (nonatomic ,assign) TianmuAnimateSlipDirection slipDirection;
/**
 加载广告数据
*/
- (void)loadAdData;

/**
 展示广告
*/
- (void)showFromRootViewController:(UIViewController *)viewController;

/**
 返回广告的eCPM，单位：分
 
 @return 成功返回一个大于等于0的值，小于等于0表示广告请求失败或获取eCPM时机不正确(请于请求广告成功后获取)
*/
- (NSInteger)bidPrice;

/**
 返回广告的底价，单位：分
 
 @return 成功返回一个大于等于0的值，小于等于0表示广告请求失败或获取底价时机不正确(请于请求广告成功后获取)
*/
- (NSInteger)bidFloor;

/**
 *  竞胜之后调用, 需要在展示广告之前调用
 *  @param price 如天目从竞价队列中胜出，则传入竞价队列第二高价（单位：分）；如仅有天目平台竞价广告，则竞赢上报的价格为当前广告对象的底价，如：[adView bidFloor]（单位：分）
 */
- (void)sendWinNotificationWithPrice:(NSInteger)price;

/**
 *  竞败之后调用,
 *  @param reason 竞价失败原因
 *  @param winnerPirce 竟赢者价格，单位：分
 */
- (void)sendWinFailNotificationReason:(TianmuAdBiddingLossReason)reason winnerPirce:(NSInteger)winnerPirce;


@end
```

插屏广告代理回调 - TianmuInterstitialAdDelegate

```obj-c
@protocol TianmuInterstitialAdDelegate <NSObject>

@optional

/**
 *  插屏广告数据请求成功
 */
- (void)tianmuInterstitialSuccessToLoadAd:(TianmuInterstitialAd *)unifiedInterstitial;

/**
 *  插屏广告数据请求失败
 */
- (void)tianmuInterstitialFailToLoadAd:(TianmuInterstitialAd *)unifiedInterstitial error:(NSError *)error;

/**
 *  插屏广告渲染成功
 *  建议在此回调后展示广告
 */
- (void)tianmuInterstitialRenderSuccess:(TianmuInterstitialAd *)unifiedInterstitial;

/**
 *  插屏广告视图展示成功回调
 *  插屏广告展示成功回调该函数
 */
- (void)tianmuInterstitialDidPresentScreen:(TianmuInterstitialAd *)unifiedInterstitial;

/**
 *  插屏广告视图展示失败回调
 *  插屏广告展示失败回调该函数
 */
- (void)tianmuInterstitialFailToPresent:(TianmuInterstitialAd *)unifiedInterstitial error:(NSError *)error;

/**
 *  插屏广告曝光回调
 */
- (void)tianmuInterstitialWillExposure:(TianmuInterstitialAd *)unifiedInterstitial;

/**
 *  插屏广告点击回调
 */
- (void)tianmuInterstitialClicked:(TianmuInterstitialAd *)unifiedInterstitial;

/**
 *  插屏广告页关闭
 */
- (void)tianmuInterstitialAdDidDismissClose:(TianmuInterstitialAd *)unifiedInterstitial;

/**
 *  插屏广告落地页关闭
 */
- (void)tianmuInterstitialAdDidCloseLandingPage:(TianmuInterstitialAd *)unifiedInterstitial;


/**
 *以下为视频插屏相关回调
 */

/**
 插屏视频广告开始播放
 */
- (void)tianmuInterstitialAdVideoPlay:(TianmuInterstitialAd *)unifiedInterstitial;

/**
 插屏视频广告视频播放失败
 */
- (void)tianmuInterstitialAdVideoPlayFail:(TianmuInterstitialAd *)unifiedInterstitial error:(NSError *)error;

/**
 插屏视频广告视频暂停
 */
- (void)tianmuInterstitialAdVideoPause:(TianmuInterstitialAd *)unifiedInterstitial;

/**
 插屏视频广告视频播放完成
 */
- (void)tianmuInterstitialAdVideoFinish:(TianmuInterstitialAd *)unifiedInterstitial;


@end

```

OC请求插屏代码示例：

```obj-c
#import <TianmuSDK/TianmuInterstitialAd.h>

- (void)loadInterstitialAd{
    // 1、初始化插屏广告
    self.interstitialAd = [[TianmuInterstitialAd alloc]init];
    self.interstitialAd.controller = self;
    self.interstitialAd.posId   =   @"682f5d1cb439";
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
}

#pragma mark - TianmuInterstitialAdDelegate
**
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
/**
 关闭落地页
 */
- (void)tianmuInterstitialAdDidCloseLandingPage:(TianmuInterstitialAd *)unifiedInterstitial {
    
}


```

<div STYLE="page-break-after: always;"></div>
<div STYLE="page-break-after: always;"></div> 


## 4.6 激励视频广告 - TianmuRewardVodAd

将短视频融入到APP场景当中，用户观看短视频广告后可以给予一些应用内奖励。常出现在游戏的复活、任务等位置，或者网服类APP的一些增值服务场景。

`OC请求激励视频广告代码示例：`[[激励视频广告代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-OC/blob/main/TianmuSDK-Demo/TianmuAds/RewardVodAd/ADTianmuRewardVodAdViewController.m)

`Swift请求激励视频广告代码示例：`[[激励视频广告代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-Swift/blob/main/TianmuSDK-iOS-Swift/TianmuAds/ADTianmuRewardVodAdViewController.swift)

激励视频广告 - TianmuRewardVodAd：
```obj-c
@interface TianmuRewardVodAd : NSObject

/**
 委托对象
 */
@property (nonatomic ,weak) id<TianmuRewardVodAdDelegate>  delegate;

/**
 详解：当前ViewController
 */
@property (nonatomic, weak) UIViewController *controller;

/**
 请求超时时间,默认为4s,需要设置3s及以上
 */
@property (nonatomic, assign) NSInteger tolerateTimeout;

/**
 广告位id
*/
@property (nonatomic, copy) NSString *posId;

/**
 是否设置视频静音模式
*/
@property (nonatomic ,assign) BOOL playMute;

/**
 加载广告数据
*/
- (void)loadAdData;

/**
 展示广告
*/
- (void)showFromRootViewController:(UIViewController *)viewController;
/**
 *  竞胜之后调用, 需要在展示广告之前调用
 *  @param price 如天目从竞价队列中胜出，则传入竞价队列第二高价（单位：分）；如仅有天目平台竞价广告，则竞赢上报的价格为当前广告对象的底价，如：[adView bidFloor]（单位：分）
 */
- (void)sendWinNotificationWithPrice:(NSInteger)price;

/**
 *  竞败之后调用,
 *  @param reason 竞价失败原因
 *  @param winnerPirce 竟赢者价格，单位：分
 */
- (void)sendWinFailNotificationReason:(TianmuAdBiddingLossReason)reason winnerPirce:(NSInteger)winnerPirce;

/**
 返回广告的出价，单位：分
 
 @return 成功返回一个大于等于0的值，小于等于0表示广告请求失败或获取eCPM时机不正确(请于请求广告成功后获取)
*/
- (NSInteger)bidPrice;

/**
 返回广告的底价，单位：分
 
 @return 成功返回一个大于等于0的值，小于等于0表示广告请求失败或获取底价时机不正确(请于请求广告成功后获取)
*/
- (NSInteger)bidFloor;

@end

```

激励视频广告代理回调 - TianmuRewardVodAdDelegate
```obj-c

/**
 *  激励视频广告数据请求成功
 */
- (void)tianmuRewardVodAdSuccessToLoadAd:(TianmuRewardVodAd *)rewardVodAd;

/**
 *  激励视频广告数据请求失败
 */
- (void)tianmuRewardVodAdFailToLoadAd:(TianmuRewardVodAd *)rewardVodAd error:(NSError *)error;

/**
 *  激励视频广告视频缓存成功
 */
- (void)tianmuRewardVodAdVideoCacheFinish:(TianmuRewardVodAd *)rewardVodAd;

/**
 *  激励视频广告渲染成功
 *  建议在此回调后展示广告
 */
- (void)tianmuRewardVodAdVideoReadyToPlay:(TianmuRewardVodAd *)rewardVodAd;

/**
 *  激励视频广告播放失败
 *  
 */
- (void)tianmuRewardVodAdVideoPlayFail:(TianmuRewardVodAd *)rewardVodAd error:(NSError *)error;

/**
 *  激励视频视图展示成功回调
 *  激励视频展示成功回调该函数
 */
- (void)tianmuRewardVodAdDidPresentScreen:(TianmuRewardVodAd *)rewardVodAd;

/**
 *  激励视频广告视图展示失败回调
 *  激励视频广告展示失败回调该函数
 */
- (void)tianmuRewardVodAdFailToPresent:(TianmuRewardVodAd *)rewardVodAd error:(NSError *)error;

/**
 *  激励视频广告曝光回调
 */
- (void)tianmuRewardVodAdWillExposure:(TianmuRewardVodAd *)rewardVodAd;

/**
 *  激励视频广告点击回调
 */
- (void)tianmuRewardVodAdClicked:(TianmuRewardVodAd *)rewardVodAd;

/**
 *  激励视频广告页关闭
 */
- (void)tianmuRewardVodAdAdDidDismissClose:(TianmuRewardVodAd *)rewardVodAd;

/**
 *  激励视频广告达到激励条件
 */
- (void)tianmuRewardVodAdAdDidEffective:(TianmuRewardVodAd *)rewardVodAd;

/**
 *  激励视频广告视频播放结束
 */
- (void)tianmuRewardVodAdAdVideoPlayFinish:(TianmuRewardVodAd *)rewardVodAd;

/**
 *  激励视频广告关闭落地页
 */
- (void)tianmuRewardVodAdCloseLandingPage:(TianmuRewardVodAd *)rewardVodAd;


```

oc代码激励视频示例：

```obj-c
#import <TianmuSDK/TianmuRewardVodAd.h>

- (void)loadRewardvodAd{
    // 1、初始化激励视频广告
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


**
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
/**
 *  激励视频广告播放完成
 */
- (void)tianmuRewardVodAdAdVideoPlayFinish:(TianmuRewardVodAd *)rewardVodAd {
    NSLog(@"激励视频播放完成");
}
/**
 *  激励视频广告关闭落地页
 */
- (void)tianmuRewardVodAdCloseLandingPage:(TianmuRewardVodAd *)rewardVodAd {
    
}

```

<div STYLE="page-break-after: always;"></div>
<div STYLE="page-break-after: always;"></div> 

## 作者
suancai@admobile.top

jiangyou@admobile.top

bale@admobile.top

xianggua@admobile.top

## 商务合作

tomato@admobile.top
