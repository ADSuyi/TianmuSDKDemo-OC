//
//  ViewController.m
//  TianmuSDK-Demo
//
//  Created by Erik on 2021/9/11.
//

#import "ViewController.h"
#import <ADSuyiKit/NSObject+ADSuyiKit.h>
#import <ADSuyiKit/UIColor+ADSuyiKit.h>
#import <ADSuyiKit/UIFont+ADSuyiKit.h>
#import "TianmuSplashViewController.h"
#import "TianmuBannderViewController.h"
#import "TianmuInterstitialAdViewController.h"
#import "TianmuNativeAdViewController.h"
#import "ADTianmuRewardVodAdViewController.h"
#import <TianmuSDK/TianmuSDK.h>
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"天目广告 Demo"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = @[@"开屏广告-半屏", @"开屏广告-全屏", @"信息流广告", @"Banner横幅广告",@"插屏广告",@"激励视频"];
    
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mainTableView];
}


- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

#pragma make - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:36/255.0 green:132/255.0 blue:207/255.0 alpha:1];
    label.text = [TianmuSDK getSDKVersion];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    cell.contentView.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    NSString *title = [self.dataArray adsy_objectOrNilAtIndex:indexPath.row];
    cell.contentView.clipsToBounds = YES;
    cell.clipsToBounds = YES;
    cell.contentView.layer.cornerRadius = 6;
    cell.layer.cornerRadius = 6;
    UIView *view = [cell.contentView viewWithTag:999];
    if (view) {
        [view removeFromSuperview];
    }
    
    UILabel *labTitle = [[UILabel alloc]init];
    labTitle.font = [UIFont systemFontOfSize:14];
    labTitle.backgroundColor = [UIColor whiteColor];
    labTitle.textAlignment = NSTextAlignmentCenter;
    labTitle.textColor = [UIColor adsy_colorWithHexString:@"#666666"];
    labTitle.tag = 999;
    labTitle.text = title;
    labTitle.clipsToBounds = YES;
    [cell.contentView addSubview:labTitle];
    labTitle.frame = CGRectMake(18, 12, self.view.bounds.size.width - 36, 36);
    labTitle.layer.cornerRadius = 6;
    labTitle.layer.borderWidth = 1;
    labTitle.layer.borderColor = [UIColor adsy_colorWithHexString:@"#E5E5EA"].CGColor;
    labTitle.layer.shadowColor = [UIColor adsy_colorWithHexString:@"#000000" alphaComponent:0.1].CGColor;
    labTitle.layer.shadowOffset = CGSizeMake(0, 1);
    labTitle.layer.shadowOpacity = 1;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0: {
            [self.navigationController pushViewController:[TianmuSplashViewController new] animated:YES];
            break;
        }
        case 1: {
            TianmuSplashViewController *vc = [[TianmuSplashViewController alloc]init];
            vc.fullBool = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2: {
            TianmuNativeAdViewController *vc = [TianmuNativeAdViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3: {
            [self.navigationController pushViewController:[TianmuBannderViewController new] animated:YES];
            break;
        }
        case 4: {
            [self.navigationController pushViewController:[TianmuInterstitialAdViewController new] animated:YES];
            break;
        }
        case 5: {
            [self.navigationController pushViewController:[ADTianmuRewardVodAdViewController new] animated:YES];
            break;
        }
        default:
            break;
    }
}


@end
