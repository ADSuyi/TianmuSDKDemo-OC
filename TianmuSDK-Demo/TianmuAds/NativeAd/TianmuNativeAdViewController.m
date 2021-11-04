//
//  TianmuNativeAdViewController.m
//  TianmuSDK-Demo
//
//  Created by 陈则富 on 2021/9/14.
//

#import "TianmuNativeAdViewController.h"
#import "TianmuNativeTableViewCell.h"
#import <TianmuSDK/TianmuExpressViewRegisterProtocol.h>
#import <TianmuSDK/TianmuNativeExpressAd.h>
#import <TianmuSDK/TianmuNativeExpressView.h>
#import <ADSuyiKit/ADSuyiKit.h>
#import <MJRefresh/MJRefresh.h>



@interface TianmuNativeAdViewController ()<UITableViewDelegate, UITableViewDataSource,TianmuNativeExpressAdDelegate>

@property (nonatomic ,strong) TianmuNativeExpressAd  *nativeAd;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic ,strong) UIRefreshControl  *refreshControl;

@end

@implementation TianmuNativeAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    
    _nativeAd = [[TianmuNativeExpressAd alloc]initWithAdSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width, 10)];
    _nativeAd.delegate = self;
    _nativeAd.posId = @"1d3ba74c8e92";//@"15c76f032d4b";
    _nativeAd.controller = self;
}

- (void)setUI{
    _items = [NSMutableArray new];
    
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[TianmuNativeTableViewCell class] forCellReuseIdentifier:@"adcell"];
    [self.view addSubview:_tableView];
    _tableView.frame = self.view.bounds;
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf cleanAllAd];
        [weakSelf.nativeAd loadAdWithCount:3];
    }];

    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf.nativeAd loadAdWithCount:3];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [_items objectAtIndex:indexPath.row];
    if([item isKindOfClass:[TianmuNativeExpressView class]]) {
        return [(UIView *)item frame].size.height;
    } else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if([cell isKindOfClass:[TianmuNativeTableViewCell class]]) {
        [(TianmuNativeTableViewCell *)cell setAdView:nil];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [_items objectAtIndex:indexPath.row];
    if([item isKindOfClass:[TianmuNativeExpressView class]]) {
        TianmuNativeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adcell" forIndexPath:indexPath];
        cell.adView = item;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = [NSString stringWithFormat:@"ListViewitem %ld", indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)cleanAllAd {
    _items = [NSMutableArray new];
    [self.tableView reloadData];
}

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





@end
