//
//  AppDelegate.m
//  TianmuSDK-Demo
//
//  Created by Erik on 2021/9/11.
//

#import "AppDelegate.h"
#import "RootViewNavigationController.h"
#import "ViewController.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
#import <TianmuSDK/TianmuSDK.h>
#import <TianmuSDK/TianmuSplashAd.h>
#import <ADSuyiKit/ADSuyiKitMacros.h>
#import <ADSuyiKit/UIColor+ADSuyiKit.h>

@interface AppDelegate ()<TianmuSplashAdDelegate>

@property (nonatomic ,strong) TianmuSplashAd  *splashAd;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = [[RootViewNavigationController alloc] initWithRootViewController:[ViewController new]];
    [_window makeKeyAndVisible];
    
    [self setThirtyPartySdk];
        
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 热启动加载开屏广告 进入前台加载
    [self loadSplashAdView];
}

- (void)setThirtyPartySdk {
    if ([self isFirstAppLoad]) {
        [self showAgreePrivacy];
    }else {
        [self initTianSDK];
    }
}

- (void)initTianSDK{
    // 是否允许SDK采集设备信息（网络信息等） ，默认开启，如需关闭需在初始化之前设置(开启并不会影响审核)
    [TianmuSDK setEnablePersonalInformation:YES];
    
    //初始化TianmuSDK
    [TianmuSDK initWithAppId:@"1001006" completionBlock:^(NSError * _Nullable error) {
        if (error){
            NSLog(@"初始化失败%@",error);
        }else{
            NSLog(@"初始化成功");
        }
    }];
    
    [self loadSplashAdView];
}

- (void)loadSplashAdView{
    if (self.splashAd) {
        return;
    }
    CGFloat bottomViewHeight = [UIScreen mainScreen].bounds.size.height * 0.15;;
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, bottomViewHeight);
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Tianmu_Logo.png"]];
    logoImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-135)/2, (bottomViewHeight-46)/2, 135, 46);
    [bottomView addSubview:logoImageView];
    
    // 初始化开屏广告加载实例
    _splashAd = [[TianmuSplashAd alloc]init];
    // 开屏广告的posid
    _splashAd.posId = @"0b815e3cda9f";
    // 开屏广告委托对象
    _splashAd.delegate = self;
    //设置默认启动图(一般设置启动图的平铺颜色为背景颜色，使得视觉效果更加平滑)
    _splashAd.backgroundColor = [UIColor adsy_getColorWithImage:[UIImage imageNamed:@"750x1334.png"] withNewSize:[UIScreen mainScreen].bounds.size];
    // 加载并展示开屏广告
    [_splashAd loadAndShowInWindow:[UIApplication sharedApplication].keyWindow withBottomView:bottomView];
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
    _splashAd = nil;
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
    
}

/**
 *  开屏广告关闭回调
 */
- (void)tianmuSplashAdClosed:(TianmuSplashAd *)splashAd {
    _splashAd = nil;
}

/**
 *  开屏广告关闭落地页回调
 */
- (void)tianmuSplashAdCloseLandingPage:(TianmuSplashAd *)splashAd {
    
}

#pragma mark -- private

- (void)showAgreePrivacy {
    // 隐私合规化示例
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"亲爱的开发者，非常感谢您选择并选用天目Ads SDK！\n为了保证您的App顺利通过合规检测，本提示将向你演示天目Ads SDK初始化合规方案。\n1. APP首次运行时请通过弹窗等明显方式提示用户阅读《用户协议》和《隐私政策》，用户确认同意《用户协议》和《隐私政策》后，再启用SDK进行个人信息的收集与处理。\n2. 本提示的内容及《用户协议》和《隐私政策》需根据你的APP业务需求进行编写，可参考《网络安全标准实践指南—移动互联网应用程序（App）收集使用个人信息自评估指南》或咨询对接人员。\n你可以通过阅读完整版的ADmobile 《用户协议》和《隐私政策》了解ADmobile详细隐私策略" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"不同意" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"点击同意才能使用该App服务" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            [self->_window.rootViewController presentViewController:alertVc animated:YES completion:nil];
            }];
        [alert addAction:sure];
        [self->_window.rootViewController presentViewController:alert animated:YES completion:nil];
    }];
    UIAlertAction *agree = [UIAlertAction actionWithTitle:@"同意并继续" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        // 记录是否第一次启动
        [self writeAppLoad];
        //    获取idfa权限 建议启动就获取权限 不获取权限会影响收益
        if (@available(iOS 14.0, *)) {
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                
            }];
        }
        // 用户同意隐私后 初始化
        [self initTianSDK];
        
    }];
    UIAlertAction *userLink = [UIAlertAction actionWithTitle:@"《用户协议》" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        [self openLinkURL:@"https://doc.admobile.top/ssp/pages/contract/"];
    }];
    UIAlertAction *privacyLink = [UIAlertAction actionWithTitle:@"《隐私政策》" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        [self openLinkURL:@"https://www.admobile.top/privacyPolicy.html"];
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:agree];
    [alertVc addAction:userLink];
    [alertVc addAction:privacyLink];
    [_window.rootViewController presentViewController:alertVc animated:YES completion:nil];
}

- (void)openLinkURL:(NSString *)linkURL {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkURL] options:@{} completionHandler:nil];
    [self showAgreePrivacy];
}


#pragma mark -- helper

- (void)writeAppLoad {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@"yes" forKey:@"isFirstLoad"];
    [userDefault synchronize];
    
}

- (BOOL)isFirstAppLoad {

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([[userDefault objectForKey:@"isFirstLoad"] isEqualToString:@"yes"]) {
        return NO;
    }
    return YES;
    
}
@end
