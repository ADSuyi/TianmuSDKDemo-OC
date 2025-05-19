#  天目Ads SDK iOS接入文档 v3.0.0.1

```
SDK名称: 天目Ads SDK
开发者: 杭州艾狄墨搏信息服务有限公司
更新日期: 2025-05-19
功能介绍: 天目Ads SDK是一款全面的 APP 广告变现解决方案，支持多种广告格式，包括横幅、插屏和视频广告。它具有精准和详细的数据分析功能，帮助开发者优化广告投放和提升收益。
```
[SDK下载地址](https://doc.admobile.top/iOSSDK/Tianmu_iOS_3001_80517bf306030be255043a1f48d9bfbf.zip)

[查看更新日志](https://doc.admobile.top/ssp/pages/tmsdkchios/)

[查看接入文档](https://doc.admobile.top/ssp/pages/tmsdkios/)

[隐私政策](https://www.admobile.top/privacyPolicy.html)

[合规指引](https://doc.admobile.top/ssp/1Start/7_compliance_guide.html)

[用户协议](https://doc.admobile.top/ssp/pages/contract/)


# 1. 概述


## 1.1 概述

尊敬的开发者朋友，欢迎您使用天目Ads SDK。通过本文档及SDK对外Demo，您可以在几分钟之内轻松完成广告的集成过程。
- [Github: 天目Ads SDK Objective-C 对外Demo](https://github.com/ADSuyi/TianmuSDKDemo-OC)
- [Gitee:  天目Ads SDK Objective-C 对外Demo](https://gitee.com/admobile/tianmu-advertising-sdk-ios)
- [Github:  天目Ads SDK Swift 对外Demo](https://github.com/ADSuyi/TianmuSDKDemo-Swift.git)
- [Gitee:  天目Ads SDK Swift 对外Demo](https://gitee.com/admobile/tianmu-advertising-sdk-ios-swift)

## 1.2 运行环境

- 开发工具：Xcode 12.0 及以上版本
- 操作系统：iOS 9.0 及以上版本
- 运行设备：iPhone

## 1.3 将天目接入到聚合平台案例 

- [天目聚合到Topon](https://gitee.com/admobile/toponadaptertianmudemo-ios)
- [天目聚合到Gromore](https://gitee.com/admobile/gromoreadapter-tianmu-ios)



# 2. 接入流程

## 2.1 采用cocoapods进行SDK的导入

```ruby
pod 'TianmuSDK','~>3.0.0.1'
```

<div STYLE="page-break-after: always;"></div>


## 2.2 工程环境配置

1. 打开项目的 app target，查看 Build Settings 中的 Linking-Other Linker Flags 选项，确保含有 -ObjC 一值， 若没有则添加。

2. 在项目的 app target 中，查看 Build Settings 中的 Build options - Enable Bitcode 选项， 设置为NO。 

4. info.plist 添加支持 Http访问字段
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
5. Info.plist 添加获取本地网络权限字段
    ```obj-c
    <key>Privacy - Local Network Usage Description</key>
    <string>广告投放及广告监测归因、反作弊</string>
    <key>Bonjour services</key>
    <array>
        <string>_apple-mobdev2._tcp.local</string>
   </array>
    ```
6. Info.plist推荐设置白名单，可提高广告收益
    ```obj-c
    <key>LSApplicationQueriesSchemes</key>
        <array>
            <string>tbopen</string>
            <string>pinduoduo</string>
            <string>openapp.jdmobile</string>
            <string>tmall</string>
            <string>imeituan</string>
            <string>meituanwaimai</string>
            <string>fleamarket</string>
            <string>kwai</string>
            <string>taobaolive</string>
            <string>snssdk1128</string>
            <string>taobaolite</string>
            <string>alipay</string>
            <string>eleme</string>
            <string>vipshop</string>
            <string>iosamap</string>
            <string>quark</string>
            <string>iyouxuan</string>
            <string>ksnebula</string>
            <string>snssdk2329</string>
            <string>dypay8663</string>
            <string>wireless1688</string>
            <string>taobaotravel</string>
            <string>diditaxi</string>
            <string>shuqireader</string>
            <string>ucbrowser</string>
            <string>xhsdiscover</string>
            <string>qiyi-iphone</string>
            <string>sinaweibo</string>
            <string>wbmain</string>
            <string>dingdongneighborhood</string>
            <string>dianping</string>
            <string>wdkhema</string>
            <string>youku</string>
            <string>kaola</string>
            <string>QunariPhone</string>
            <string>ctrip</string>
            <string>lianjia</string>
            <string>tbmovie</string>
            <string>dingtalk</string>
            <string>cainiao</string>
            <string>bilibili</string>
            <string>zhihu</string>
            <string>yanxuan</string>
            <string>soul</string>
            <string>app.soyoung</string>
            <string>yidui</string>
            <string>momochat</string>
            <string>tantanapp</string>
            <string>dragon1967</string>
            <string>sohunews</string>
        </array>
    ```



## 2.3 iOS14 适配

> 由于iOS14中对于权限和隐私内容有一定程度的修改，而且和广告业务关系较大，请按照如下步骤适配，如果未适配。不会导致运行异常或者崩溃等情况，但是会一定程度上影响广告收入。敬请知悉。

1. 应用编译环境升级至 Xcode 12.0 及以上版本；
2. 设置IDFA权限；



### 2.3.1 获取App Tracking Transparency授权（弹窗授权获取IDFA）

从 iOS 14.5 开始，在应用程序调用 App Tracking Transparency 向用户提跟踪授权请求之前，IDFA 将不可用。

1. 在 Info.plist 文件里添加 NSUserTrackingUsageDescription 字段和自定义文案描述

    ```obj-c
    <key>NSUserTrackingUsageDescription</key>
    <string>获取标记权限向您提供更优质、安全的个性化服务及内容，未经同意我们不会用于其他目的；开启后，您也可以前往系统“设置-隐私 ”中随时关闭</string>
    ```
   
   文案建议：
   - `获取标记权限向您提供更优质、安全的个性化服务及内容，未经同意我们不会用于其他目的；开启后，您也可以前往系统“设置-隐私 ”中随时关闭。`
   - `获取IDFA标记权限向您提供更优质、安全的个性化服务及内容；开启后，您也可以前往系统“设置-隐私 ”中随时关闭。`



2. 向用户申请权限

    ```obj-c
    #import <AppTrackingTransparency/AppTrackingTransparency.h>
    #import <AdSupport/AdSupport.h>
    ...
    
    - (void)requestIDFA {
      [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
        // 无需对授权状态进行处理
      }];
    }
    ```


<div STYLE="page-break-after: always;"></div>

3. 针对iOS15系统不弹出授权窗问题解决方法：

    ```obj-c
    // 针对iOS15不弹窗问题解决方法，根据官方文档可将权限申请放在becomeActive方法
    - (void)applicationDidBecomeActive:(UIApplication *)application {
        // 用户同意协议后获取
        [self requestIDFA];
    }
    ```
    
    参考：https://developer.apple.com/forums/thread/690607

<div STYLE="page-break-after: alway;"></div>


# 3. 示例代码

## 3.1 天目Ads SDK的初始化

```obj-c
#import <TianmuSDK/TianmuSDK.h>
...

// 申请的 appid 必须与您的包名一一对应
[TianmuSDK initWithAppId:@"1001006" completionBlock:^(NSError * _Nullable error) {
     if (error){
         NSLog(@"初始化失败%@",error);
     }
}];
```

若有获取SDK版本的需求，也可直接调用接口：

```obj-c
//获取SDK版本号
NSString *sdkVersion = [TianmuSDK getSDKVersion];
```

<div STYLE="page-break-after: always;"></div>

## 3.2 个性化开关

```obj-c
// 是否开启个性化广告；默认YES，建议初始化SDK之前设置
TianmuSDK.enablePersonalAd = NO;
```

<div STYLE="page-break-after: always;"></div>


##  开屏广告 - TianmuSplashAd

### 3.3.1 开屏广告介绍

开屏广告会在您的应用开启时加载展示，拥有固定展示时间，展示完毕后自动关闭并进入您的应用主界面。

开屏广告建议在闪屏页进行展示，开屏广告的宽度和高度取决于容器的宽高，都是会撑满广告容器；**开屏广告的高度必须大于等于屏幕高度（手机屏幕完整高度，包括状态栏之类）的75%**，否则可能会影响收益计费。

推荐在 `AppDelegate`的 `didFinishLaunchingWithOptions`方法的 `return YES`之前调用开屏。

- `Github: OC请求开屏代码示例：`[[开屏代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-OC/blob/master/TianmuSDK-Demo/AppDelegate.m)
- `Gitee: OC请求开屏代码示例：`[[开屏代码示例]](https://gitee.com/admobile/tianmu-advertising-sdk-ios/blob/master/TianmuSDK-Demo/AppDelegate.m)

- `Github: Swift请求开屏代码示例：`[[开屏代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-Swift/blob/master/TianmuSDK-iOS-Swift/AppDelegate.swift)
- `Gitee: Swift请求开屏代码示例：`[[开屏代码示例]](https://gitee.com/admobile/tianmu-advertising-sdk-ios-swift/blob/master/TianmuSDK-iOS-Swift/AppDelegate.swift)


> **冷启动**：应用进程不存在时，应用的初次启动
> 
> **热启动**：应用通过home键暂时退到后台，在该应用进程还存在时，重新回到应用

### 3.3.2 开屏广告API说明

**TianmuSplashAd**: 开屏广告的加载类

| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| posId | NSString | 广告位id  |
|  - | |  |
| delegate | id\<TianmuSplashAdDelegate> | 委托对象 |
| backgroundColor           | UIColor | 用于开屏请求过渡，可将启动图转为color传入，默认为透明|
| viewController            | UIViewController | 使用 controller present 落地页，默认获取当前window最上层控制器 |
| skipView                  | UIView | 自定义跳过按钮，可以通过此接口替换开屏广告的跳过按钮样式 |
| disableMotion                  | bool | 屏蔽摇一摇、晃一晃 |


| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| loadAndShowInWindow:withBottomView: | 加载并展示开屏<br/>window：开屏广告展示的window，若为自定义window需设置viewController<br/>bottomView：底部logo视图, 高度不能超过屏幕的25%，可传nil  |
| - |  |
| loadAdWithBottomView: | 加载开屏广告<br/>bottomView：底部logo视图, 高度不能超过屏幕的25%，可传nil  |
| loadAd | 加载开屏广告（接口即将废弃，请使用loadAdWithBottomView:）  |
| isDataTimeout | 广告是否超时 |
| showInWindow:withBottomView： | 展示开屏（接口即将废弃，请使用showInWindow:）<br/>window：开屏广告展示的window，若为自定义window需设置viewController<br/>bottomView：底部logo视图, 高度不能超过屏幕的25%，可传nil  |
| showInWindow: | 展示开屏<br/>window：开屏广告展示的window<br/> |
| - |     |
| bidPrice | 返回广告的出价，单位：分 |
| bidFloor | 返回广告的底价，单位：分 |
| sendWinNotificationWithPrice: | 竞胜之后调用, 需要在展示广告之前调用<br/>price： 如天目从竞价队列中胜出，则传入广告返回的出价，如：[adView bidPrice]（单位：分） |
| sendWinFailNotificationReason:winnerPirce: | 竞败之后调用<br/>reason：竞价失败原因<br/>winnerPirce：竟赢者价格，单位：分 |

**TianmuSplashAdDelegate**：开屏代理方法

| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| tianmuSplashAdSuccessLoad: | 开屏广告请求成功  |
| tianmuSplashAdDidLoad: | 开屏广告素材渲染成功  |
| tianmuSplashAdDidPresent: | 开屏广告展示成功  |
| tianmuSplashAdFailLoad:withError: | 开屏广告请求失败  |
| tianmuSplashAdRenderFaild:withError: | 开屏广告渲染失败 |
| tianmuSplashAdExposured: | 开屏广告曝光回调  |
| tianmuSplashAdClicked: | 开屏广告点击回调  |
| tianmuSplashAdCountdownToZero: | 开屏广告倒计时结束回调  |
| tianmuSplashAdSkiped: | 开屏广告点击跳过回调  |
| tianmuSplashAdClosed: | 开屏广告关闭回调  |
| tianmuSplashAdCloseLandingPage: | 开屏广告关闭落地页回调  |
| tianmuSplashAdFailToShow: | 开屏广告展示失败  |

<div STYLE="page-break-after: always;"></div>

### 3.3.3 请求开屏代码示例

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
 *  开屏广告请求失败
 */
- (void)tianmuSplashAdFailLoad:(TianmuSplashAd *)splashAd withError:(NSError *)error {
    NSLog(@"splash开屏广告加载失败%@",error);
}

/**
 *  开屏广告展示失败
 */
- (void)tianmuSplashAdRenderFaild:(TianmuSplashAd *)splashAd withError:(NSError *)error {
    NSLog(@"splash开屏广告展示失败%@",error);   
}

/**
 *  开屏广告关闭回调
 */
- (void)tianmuSplashAdClosed:(TianmuSplashAd *)splashAd {
    _splashAd = nil;
}

/**
 *  开屏广告关闭落地页
 */
- (void)tianmuSplashAdCloseLandingPage:(TianmuSplashAd *)splashAd {

}

```

<div STYLE="page-break-after: always;"></div>


## 3.4 Banner横幅广告 - TianmuBannerAdView

### 3.4.1 Banner横幅广告介绍

Banner广告(横幅广告)位于app顶部、中部、底部任意一处，横向贯穿整个app页面；当用户与app互动时，Banner广告会停留在屏幕上，并可在一段时间后自动刷新。

- `Github: OC请求横幅代码示例：`[[横幅代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-OC/blob/master/TianmuSDK-Demo/TianmuAds/BannderAd/TianmuBannderViewController.m)
- `Gitee: OC请求横幅代码示例：`[[横幅代码示例]](https://gitee.com/admobile/tianmu-advertising-sdk-ios/blob/master/TianmuSDK-Demo/TianmuAds/BannderAd/TianmuBannderViewController.m)

- `Github: Swift请求横幅代码示例：`[[横幅代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-Swift/blob/master/TianmuSDK-iOS-Swift/TianmuAds/TianmuBannderViewController.swift)
- `Gitee: Swift请求横幅代码示例：`[[横幅代码示例]](https://gitee.com/admobile/tianmu-advertising-sdk-ios-swift/blob/master/TianmuSDK-iOS-Swift/TianmuAds/TianmuBannderViewController.swift)


### 3.4.2 横幅广告API说明

**TianmuBannerAdView**: 横幅广告的加载类

| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| posId | NSString | 广告位id  |
| viewController | UIViewController | 当前ViewController |
| delegate | id\<TianmuBannerAdViewDelegate> | 委托对象 |

| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| loadRequest | 开始请求广告 |
| isDataTimeout | 广告是否超时 |
| - |     |
| bidPrice | 返回广告的出价，单位：分 |
| bidFloor | 返回广告的底价，单位：分 |
| sendWinNotificationWithPrice: | 竞胜之后调用, 需要在展示广告之前调用<br/>price： 如天目从竞价队列中胜出，则传入广告返回的出价，如：[adView bidPrice]（单位：分） |
| sendWinFailNotificationReason:winnerPirce: | 竞败之后调用<br/>reason：竞价失败原因<br/>winnerPirce：竟赢者价格，单位：分 |

**TianmuBannerAdViewDelegate**：横幅代理方法

| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| tianmuBannerSuccessLoad: | 请求成功 |
| tianmuBannerViewFailedToLoadWithError: | 请求失败 |
| tianmuBannerViewDidPresent: | 展示回调  |
| tianmuBannerViewWillExpose: | 曝光回调  |
| tianmuBannerViewClicked: | 点击回调 |
| tianmuBannerViewWillClose: | 被用户关闭时调用 |
| tianmuBannerViewCloseLandingPage: | 被用户关闭广告落地页调用 |

### 3.4.3 请求横幅代码示例

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
 *  请求广告数据失败后调用
 *  当接收服务器返回的广告数据失败后调用该函数
 */
- (void)tianmuBannerViewFailedToLoadWithError:(NSError *)error {
    NSLog(@"banner广告加载失败%@",error);
    [self.bannerAd removeFromSuperview];
    self.bannerAd = nil;
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

## 3.5 信息流广告 - TianmuNativeExpressAd

### 3.5.1 信息流广告介绍

模板信息流广告，具备上下图文，左右图文和纯图等样式，开发者可从天目管理后台设置广告位样式，模板信息流广告不得被遮挡。** **注意，信息流广告点击关闭时，开发者需要在- (void)tianmuExpressAdClosed:回调中将广告视图隐藏或移除**

- `Github: OC请求信息流广告代码示例：`[[信息流广告代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-OC/blob/master/TianmuSDK-Demo/TianmuAds/NativeAd/TianmuNativeAdViewController.m)
- `Gitee: OC请求信息流广告代码示例：`[[信息流广告代码示例]](https://gitee.com/admobile/tianmu-advertising-sdk-ios/blob/master/TianmuSDK-Demo/TianmuAds/NativeAd/TianmuNativeAdViewController.m)

- `Github: Swift请求信息流广告代码示例：`[[信息流广告代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-Swift/blob/master/TianmuSDK-iOS-Swift/TianmuAds/TianmuNativeAdViewController.swift)
- `Gitee: Swift请求信息流广告代码示例：`[[信息流广告代码示例]](https://gitee.com/admobile/tianmu-advertising-sdk-ios-swift/blob/master/TianmuSDK-iOS-Swift/TianmuAds/TianmuNativeAdViewController.swift)

### 3.5.2 信息流广告API说明

**TianmuNativeExpressAd**: 信息流广告的加载类

| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| posId | NSString | 广告位id  |
| controller | UIViewController | 当前ViewController |
| delegate | id\<TianmuNativeExpressAdDelegate> | 委托对象 |
| tolerateTimeout | NSInteger | 请求超时时间,默认为4s,需要设置3s及以上 |
| playMute | BOOL | 是否设置静音模式，默认是true |

| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| initWithAdSize: | 初始化广告加载器，需传入需要广告尺寸(一般按照16：9比例返回广告视图） |
| loadAdWithCount: | 加载广告<br/>count：拉取几条广告,建议区间 1~4, 超过可能无法拉取到 |
| sendWinNotificationWithPrice: | 竞胜之后调用, 需要在展示广告之前调用<br/>price： 如天目从竞价队列中胜出，则传入广告返回的出价，如：[adView bidPrice]（单位：分） |
| sendWinFailNotificationReason:winnerPirce: | 竞败之后调用<br/>reason：竞价失败原因<br/>winnerPirce：竟赢者价格，单位：分 |

**TianmuNativeExpressAdDelegate**：信息流代理方法

| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| tianmuExpressAdSucceedToLoad:views: | 信息流广告加载成功 |
| tianmuExpressAdFailToLoad:error: | 信息流广告加载失败 |
| tianmuExpressAdRenderFail:error: | 信息流广告渲染失败 |
| tianmuExpressAdRenderSucceed:adView: | 信息流广告渲染成功 |
| tianmuExpressAdClosed:adView: | 信息流广告关闭 |
| tianmuExpressAdClick:adView: | 信息流广告点击 |
| tianmuExpressAdDidExpourse:adView: | 信息流广告展示 |
| tianmuExpressAdDidCloseLandingPage:adView: | 信息流广告关闭落地页 |
| 视频信息流相关回调 | |
| tianmuExpressAdVideoPlay:adView: | 信息流视频广告开始播放 |
| tianmuExpressAdVideoPlayFail:error: | 信息流视频广告视频播放失败 |
| tianmuExpressAdVideoPause:adView: | 信息流视频广告视频暂停 |
| tianmuExpressAdVideoFinish:adView: | 信息流视频广告视频播放完成 |

**UIView\<TianmuExpressViewRegisterProtocol>**：信息流视图
| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| renderType | TianmuAdRenderType | 渲染类型  |
| adData | TianmuNativeData | 广告数据模型,模板渲染为空 |
| bidPrice | NSInteger | 需要于成功回调中获取<br/>竞价广告出价,单位：分 |
| bidFloor | NSInteger | 需要于成功回调中获取<br/>竞价广告底价,单位：分 |

| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| tianmu_registViews: | 注册广告视图（必须调用的方法），不调用将无法渲染广告 |
| tianmu_mediaViewForWidth: | 获取视频视图，如果是模版广告则为nil |
| tianmu_platformLogoImageDarkMode:loadImageBlock: | 获取logo图片 |
| tianmu_close | 自渲染信息流关闭按钮响应方法（会回调关闭） |
| tianmu_setFrame: | 信息流重设广告尺寸 |


### 3.5.3 请求信息流代码示例

```obj-c
#import <TianmuSDK/TianmuNativeExpressAd.h>
#import <TianmuSDK/TianmuNativeExpressView.h>

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

// 信息流广告加载成功
- (void)tianmuExpressAdSucceedToLoad:(TianmuNativeExpressAd *)expressAd views:(NSArray<__kindof UIView<TianmuExpressViewRegisterProtocol> *> *)views {
    for (TianmuNativeExpressView *adView in views) {
        if (adView.renderType == TianmuAdRenderTypeNative) {
            //如果是自渲染信息流 则自行布局
            [self setUpUnifiedTopImageNativeAdView:adView];
        }
        [adView tianmu_registViews:@[adView]];
    }
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

// 信息流广告加载失败
- (void)tianmuExpressAdFailToLoad:(TianmuNativeExpressAd *)expressAd error:(NSError *)error {
    NSLog(@"信息流广告加载失败%@",error);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    });
}

// 信息流广告渲染成功
- (void)tianmuExpressAdRenderSucceed:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView {
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < 6; i ++) {
            [self.items addObject:[NSNull null]];
        }
        [self.items addObject:expressAdView];
        [self.tableView reloadData];
    });
}

// 信息流广告渲染失败
- (void)tianmuExpressAdRenderFail:(TianmuNativeExpressAd *)expressAd error:(NSError *)error {
    [self.view makeToast:[NSString stringWithFormat:@"信息流渲染失败：%@",error]];
}

// 信息流广告关闭
- (void)tianmuExpressAdClosed:(TianmuNativeExpressAd *)expressAd adView:(UIView<TianmuExpressViewRegisterProtocol> *)expressAdView {
    [self.items removeObject:expressAdView];
    [self.tableView reloadData];
}

```

<div STYLE="page-break-after: always;"></div>

<div STYLE="page-break-after: always;"></div>


## 3.6 插屏广告 - TianmuInterstitialAd

### 3.6.1 插屏广告介绍

插屏广告是移动广告的一种常见形式，在应用流程中弹出，当应用展示插屏广告时，用户可以选择点击广告，访问其目标网址，也可以将其关闭并返回应用。在应用执行流程的自然停顿点，适合投放这类广告。

- `Github: OC请求插屏广告代码示例：`[[插屏广告代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-OC/blob/master/TianmuSDK-Demo/TianmuAds/InterstitialAd/TianmuInterstitialAdViewController.m)
- `Gitee: OC请求插屏广告代码示例：`[[插屏广告代码示例]](https://gitee.com/admobile/tianmu-advertising-sdk-ios/blob/master/TianmuSDK-Demo/TianmuAds/InterstitialAd/TianmuInterstitialAdViewController.m)

- `Github: Swift请求插屏广告代码示例：`[[插屏广告代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-Swift/blob/master/TianmuSDK-iOS-Swift/TianmuAds/TianmuInterstitialAdViewController.swift)
- `Gitee: Swift请求插屏广告代码示例：`[[插屏广告代码示例]](https://gitee.com/admobile/tianmu-advertising-sdk-ios-swift/blob/master/TianmuSDK-iOS-Swift/TianmuAds/TianmuInterstitialAdViewController.swift)

### 3.6.2 插屏广告API说明

**TianmuInterstitialAd**: 插屏广告的加载类

| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| posId | NSString | 广告位id  |
| controller | UIViewController | 当前ViewController |
| delegate | id\<TianmuInterstitialAdDelegate> | 委托对象 |
| tolerateTimeout | NSInteger | 请求超时时间,默认为4s,需要设置3s及以上 |
| playMute | BOOL | 是否设置视频静音模式,默认false |
| disableMotion                  | bool | 屏蔽摇一摇、晃一晃 |
| supportScreenType                  | TianmuAdSupportScreenType | 支持屏幕方向，默认竖屏 |
| isAutoClose | bool | 是否开启自动关闭功能， 默认不开启  |
| autoCloseTime | NSInteger | [3~100) 区间内有效；默认5秒后关闭;需和isAutoClose配合使用  |

| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| loadAdData | 加载广告数据 |
| isDataTimeout | 广告是否超时 |
| showFromRootViewController: | 展示广告 |
| bidPrice | 返回广告的eCPM，单位：分 |
| bidFloor | 返回广告的底价，单位：分 |
| sendWinNotificationWithPrice: | 竞胜之后调用, 需要在展示广告之前调用<br/>price： 如天目从竞价队列中胜出，则传入广告返回的出价，如：[adView bidPrice]（单位：分） |
| sendWinFailNotificationReason:winnerPirce: | 竞败之后调用<br/>reason：竞价失败原因<br/>winnerPirce：竟赢者价格，单位：分 |

**TianmuInterstitialAdDelegate**：插屏代理方法

| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| tianmuInterstitialSuccessToLoadAd: | 插屏广告数据请求成功 |
| tianmuInterstitialFailToLoadAd:error: | 插屏广告数据请求失败 |
| tianmuInterstitialRenderSuccess: | 插屏广告渲染成功<br/>建议在此回调后展示广告  |
| tianmuInterstitialDidPresentScreen: | 插屏广告视图展示成功回调<br/>插屏广告展示成功回调该函数  |
| tianmuInterstitialFailToPresent:error: | 插屏广告视图展示失败回调<br/>插屏广告展示失败回调该函数 |
| tianmuInterstitialWillExposure: | 插屏广告曝光回调 |
| tianmuInterstitialClicked: | 插屏广告点击回调 |
| tianmuInterstitialAdDidDismissClose: | 插屏广告页关闭 |
| tianmuInterstitialAdDidCloseLandingPage: | 插屏广告落地页关闭 |
| 以下为视频插屏相关回调 |  |
| tianmuInterstitialAdVideoPlay: | 插屏视频广告开始播放 |
| tianmuInterstitialAdVideoPlayFail:error: | 插屏视频广告视频播放失败 |
| tianmuInterstitialAdVideoPause: | 插屏视频广告视频暂停 |
| tianmuInterstitialAdVideoFinish: | 插屏视频广告视频播放完成 |

### 3.6.3 请求插屏代码示例

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
/**
 *  插屏广告数据请求成功
 */
- (void)tianmuInterstitialSuccessToLoadAd:(TianmuInterstitialAd *)unifiedInterstitial {
    [self.view makeToast:@"广告准备好"];
    if (!_isNormalAd){
        [self.view makeToast:[NSString stringWithFormat:@"当前广告价格：%ld",unifiedInterstitial.bidPrice]];
    }
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
 *  插屏广告视图展示失败回调
 *  插屏广告展示失败回调该函数
 */
- (void)tianmuInterstitialFailToPresent:(TianmuInterstitialAd *)unifiedInterstitial error:(NSError *)error {
    [self.view makeToast:[NSString stringWithFormat:@"当前广告展示失败%@",error]];
}

/**
 *  插屏广告页关闭
 */
- (void)tianmuInterstitialAdDidDismissClose:(TianmuInterstitialAd *)unifiedInterstitial {
    _interstitialAd = nil;
}

```

<div STYLE="page-break-after: always;"></div>


## 3.7 激励视频广告 - TianmuRewardVodAd

### 3.7.1 激励视频广告介绍

将短视频融入到APP场景当中，用户观看短视频广告后可以给予一些应用内奖励。常出现在游戏的复活、任务等位置，或者网服类APP的一些增值服务场景。

- `Github: OC请求激励视频广告代码示例：`[[激励视频广告代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-OC/blob/master/TianmuSDK-Demo/TianmuAds/RewardVodAd/ADTianmuRewardVodAdViewController.m)
- `Gitee: OC请求激励视频广告代码示例：`[[激励视频广告代码示例]](https://gitee.com/admobile/tianmu-advertising-sdk-ios/blob/master/TianmuSDK-Demo/TianmuAds/RewardVodAd/ADTianmuRewardVodAdViewController.m)

- `Github: Swift请求激励视频广告代码示例：`[[激励视频广告代码示例]](https://github.com/ADSuyi/TianmuSDKDemo-Swift/blob/master/TianmuSDK-iOS-Swift/TianmuAds/ADTianmuRewardVodAdViewController.swift)
- `Gitee: Swift请求激励视频广告代码示例：`[[激励视频广告代码示例]](https://gitee.com/admobile/tianmu-advertising-sdk-ios-swift/blob/master/TianmuSDK-iOS-Swift/TianmuAds/ADTianmuRewardVodAdViewController.swift)

### 3.7.2 激励视频广告API说明

**TianmuRewardVodAd**: 激励视频广告的加载类

| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| posId | NSString | 广告位id  |
| controller | UIViewController | 当前ViewController |
| delegate | id\<TianmuRewardVodAdDelegate> | 委托对象 |
| tolerateTimeout | NSInteger | 请求超时时间,默认为4s,需要设置3s及以上 |
| playMute | BOOL | 是否设置静音模式,默认false |

| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| loadAdData | 加载广告数据 |
| isDataTimeout | 广告是否超时 |
| showFromRootViewController: | 展示广告 |
| bidPrice | 返回广告的eCPM，单位：分 |
| bidFloor | 返回广告的底价，单位：分 |
| sendWinNotificationWithPrice: | 竞胜之后调用, 需要在展示广告之前调用<br/>price： 如天目从竞价队列中胜出，则传入广告返回的出价，如：[adView bidPrice]（单位：分） |
| sendWinFailNotificationReason:winnerPirce: | 竞败之后调用<br/>reason：竞价失败原因<br/>winnerPirce：竟赢者价格，单位：分 |

**TianmuNativeExpressDelegate**：激励视频代理方法

| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| tianmuRewardVodAdSuccessToLoadAd: | 激励视频广告数据请求成功 |
| tianmuRewardVodAdFailToLoadAd:error: | 激励视频广告数据请求失败 |
| tianmuRewardVodAdVideoCacheFinish: | 激励视频广告视频缓存成功 |
| tianmuRewardVodAdVideoReadyToPlay: | 激励视频广告渲染成功 |
| tianmuRewardVodAdVideoPlayFail:error: | 激励视频广告播放失败 |
| tianmuRewardVodAdDidPresentScreen: | 激励视频视图展示成功回调 |
| tianmuRewardVodAdFailToPresent:error: | 激励视频广告视图展示失败回调 |
| tianmuRewardVodAdWillExposure: | 激励视频广告曝光回调 |
| tianmuRewardVodAdClicked: | 激励视频广告点击回调 |
| tianmuRewardVodAdAdDidDismissClose: | 激励视频广告页关闭 |
| tianmuRewardVodAdAdDidEffective: | 激励视频广告达到激励条件 |
| tianmuRewardVodAdAdVideoPlayFinish: | 激励视频广告视频播放结束 |
| tianmuRewardVodAdCloseLandingPage: | 激励视频广告关闭落地页 |

### 3.7.3 请求激励视频代码示例

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


/**
 *  激励视频广告数据请求成功
 */
- (void)tianmuRewardVodAdSuccessToLoadAd:(TianmuRewardVodAd *)rewardVodAd {
    if (!_isNormalAd){
        [self.view makeToast:[NSString stringWithFormat:@"当前广告价格：%ld",rewardVodAd.bidPrice]];
    }
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

```

<div STYLE="page-break-after: always;"></div>
<div STYLE="page-break-after: always;"></div> 
    
# 错误码


| 错误码 | 错误说明                                               |
|---|----------------------------------------------------|
| 100201 | 广告请求超时                                             |
| 100102 | 包名校验失败                                             |
| 100103 | 请求配置为空、或失败                                         |
| 100104 | 请求额外配置为空、或失败                                         |
| 100203 | 未获取到该PosId对应配置信息、广告类型与PosId对应广告配置信息不一致             |
| 100204 | 落地页地址为空                                            |
| 100205 | 无填充                                                |
| 100207 | 素材渲染失败，如为竞价广告请排查是否于有效时间内展示并上报竞价成功及上报价格合法 |
| 100207 | 素材渲染失败，如为竞价广告请排查是否于有效时间内展示并上报竞价成功及上报价格合法 |
| 100209 | 无可请求广告源                                            |
| 100210 | 视频播放失败                                             |
| 100211 | 素材为准备完成，如为竞价广告请排查是否于有效时间内展示并上报竞价成功及上报价格合法 |
| 100212 | 告数据无效（如为竞价广告请排查是否于有效时间内展示并上报竞价成功及上报价格合法） |



# 商务合作

邮箱：yuxingcao@admobile.top
