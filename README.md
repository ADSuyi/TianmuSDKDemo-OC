# TianmuSDK iOS接入文档 v1.0.0











[TOC]























## 修订历史

| 文档版本 | 修订日期   | 修订说明                                                     |
| -------- | ---------- | ------------------------------------------------------------ |
| v1.0.0   | 2021-11-04 | 首版发布 |


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
pod 'TianmuSDK','1.0.0'
```

<div STYLE="page-break-after: always;"></div>


## 2.2 手动导入SDK方式

[点击进入SDK下载地址]()下载SDK拖入到工程中

手动方式导入,需要添加如下依赖库:

```obj-c
libresolv.9.tbd
```

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
    // 用户同意协议后获取
      [self requestIDFA];
}

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
、、、
[TianmuSDK initWithAppId:@"1001003" completionBlock:^(NSError * _Nullable error) {
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

开屏广告 - ADSuyiSDKSplashAd：

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

```

<div STYLE="page-break-after: always;"></div>
开屏广告代理回调 - TianmuSplashAdDelegate

```obj-c
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
 *  开屏广告关闭回调
 */
- (void)tianmuSplashAdClosed:(TianmuSplashAd *)splashAd;


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
 * SUPPORT_SPLASH_ZOOMOUT，是否需要支持V+视频开屏广告取决于开发者，不选择v+开屏则可以不去适配
 */

- (void)loadSplashAd{
      //1、 初始化开屏加载实例
    _splashAd = [[TianmuSplashAd alloc]init];
    _splashAd.posId = @"60cafb2d8759";
    _splashAd.delegate = self;
        //    _splashAd.hiddenSkipView = YES;
        //    _splashAd.skipView = _skipView;
    // 设置默认启动图(一般设置启动图的平铺颜色为背景颜色，使得视觉效果更加平滑)
    _splashAd.backgroundColor = [UIColor adsy_getColorWithImage:[UIImage imageNamed:@"750x1334.png"] withNewSize:[UIScreen mainScreen].bounds.size];
    
    [_splashAd loadAndShowInWindow:[UIApplication sharedApplication].keyWindow withBottomView:self.fullBool ? nil : bottomView];
}

// 8、代理回调
#pragma mark - ADSuyiSDKSplashAdDelegate
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
 *  委托 [可选]
 */
@property (nonatomic ,weak) id<TianmuBannerAdViewDelegate>  delegate;

/*
 详解：当前ViewController
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
```


请求横幅广告请求示例：

```obj-c
#import <TianmuSDK/TianmuBannerAdView.h>

- (void)loadBannerAd {
      // 1、初始化banner视图，并给定frame值
    self.bannerAd = [[TianmuBannerAdView alloc] initWithFrame:CGRectMake(0, 250, kADSYScreenWidth, kADSYScreenWidth / rate) posId:posId];
      // 2、设置委托对象
    self.bannerAd.delegate = self;
      // 3、添加到父视图
    [self.view addSubview:self.bannerAd];
    // 4、请求广告
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

@end

```

模板信息流广告代理回调 - TianmuNativeExpressAdDelegate

```obj-c
@protocol TianmuNativeExpressAdDelegate<NSObject>

/**
 模板信息流广告加载成功
 */
- (void)tianmuExpressAdSucceedToLoad:(TianmuNativeExpressAd *)expressAd views:(NSArray<__kindof TianmuNativeExpressView *> *)views;

/**
 模板信息流广告加载失败
 */
- (void)tianmuExpressAdFailToLoad:(TianmuNativeExpressAd *)expressAd error:(NSError *)error;

/**
 模板信息流广告渲染成功
 */
- (void)tianmuExpressAdRenderSucceed:(TianmuNativeExpressAd *)expressAd adView:(TianmuNativeExpressView *)expressAdView;

/**
 模板信息流广告渲染失败
 */
- (void)tianmuExpressAdRenderFail:(TianmuNativeExpressView *)expressAd error:(NSError *)error;

/**
 模板信息流广告关闭
 */
- (void)tianmuExpressAdClosed:(TianmuNativeExpressAd *)expressAd adView:(TianmuNativeExpressView *)expressAdView;

/**
 模板信息流广告点击
 */
- (void)tianmuExpressAdClick:(TianmuNativeExpressAd *)expressAd adView:(TianmuNativeExpressView *)expressAdView;

/**
 模板信息流广告展示
 */
- (void)tianmuExpressAdDidExpourse:(TianmuNativeExpressAd *)expressAd adView:(TianmuNativeExpressView *)expressAdView;


@end
```


请求信息流广告请求示例：

```obj-c
#import <ADSuyiSDK/ADSuyiSDKNativeAd.h>

if(!_nativeAd) {
   // 1、信息流广告初始化
   _nativeAd = [[TianmuNativeExpressAd alloc]initWithAdSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width, 10)];
   _nativeAd.delegate = self;
   _nativeAd.posId = @"037dec29b815";
   _nativeAd.controller = self;
}
// 3、加载信息流广告
[_nativeAd loadAdWithCount:1];

// 4、代理回调
#pragma mark - TianmuNativeExpressAdDelegate

// 模板信息流广告加载成功
- (void)tianmuExpressAdSucceedToLoad:(TianmuNativeExpressAd *)expressAd views:(NSArray<__kindof TianmuNativeExpressView *> *)views {
    for (TianmuNativeExpressView *adView in views) {
        [adView tianmu_registViews:@[adView]];
    }
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

// 模板信息流广告加载失败
- (void)tianmuExpressAdFailToLoad:(TianmuNativeExpressAd *)expressAd error:(NSError *)error {
    NSLog(@"信息流广告加载失败%@",error);
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

// 模板信息流广告渲染成功
- (void)tianmuExpressAdRenderSucceed:(TianmuNativeExpressAd *)expressAd adView:(TianmuNativeExpressView *)expressAdView {
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
    
}

// 模板信息流广告关闭
- (void)tianmuExpressAdClosed:(TianmuNativeExpressAd *)expressAd adView:(TianmuNativeExpressView *)expressAdView {
    [self.items removeObject:expressAdView];
    [self.tableView reloadData];
}

// ，模板信息流广告点击
- (void)tianmuExpressAdClick:(TianmuNativeExpressAd *)expressAd adView:(TianmuNativeExpressView *)expressAdView {
    
}


// ，模板信息流广告展示
- (void)tianmuExpressAdDidExpourse:(TianmuNativeExpressAd *)expressAd adView:(TianmuNativeExpressView *)expressAdView {
    
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

/*
 委托对象
 */
@property (nonatomic ,weak) id<TianmuInterstitialAdDelegate>  delegate;

/*
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
 加载广告数据
*/
- (void)loadAdData;

/**
 展示广告
*/
- (void)showFromRootViewController:(UIViewController *)viewController;

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

@end

```

OC请求插屏代码示例：

```obj-c
#import <ADSuyiSDK/ADSuyiSDKIntertitialAd.h>

- (void)loadInterstitialAd{
    // 1、初始化插屏广告
    self.interstitialAd = [[TianmuInterstitialAd alloc]init];
    self.interstitialAd.controller = self;
    self.interstitialAd.posId   =    @"f9176a53842d";
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
}

#pragma mark - TianmuInterstitialAdDelegate
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

```

<div STYLE="page-break-after: always;"></div>
<div STYLE="page-break-after: always;"></div> 


## 作者

bale@admobile.top

xianggua@admobile.top

## 商务合作

tomato@admobile.top
