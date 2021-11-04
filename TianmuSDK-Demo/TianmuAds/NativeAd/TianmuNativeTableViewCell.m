//
//  TianmuNativeTableViewCell.m
//  TianmuSDK-Demo
//
//  Created by 陈则富 on 2021/9/18.
//

#import "TianmuNativeTableViewCell.h"

@implementation TianmuNativeTableViewCell

- (void)setAdView:(UIView *)adView {
    [_adView removeFromSuperview];
    
    _adView = adView;
    _adView.frame = self.contentView.bounds;
    [self.contentView addSubview:_adView];
}

- (void)setCloseBtnView:(UIView *)closeBtnView{
    
    _closeBtnView = closeBtnView;
    _closeBtnView.backgroundColor = UIColor.greenColor;
    _closeBtnView.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width-60, 10, 60, 30);
//    [self.contentView addSubview:_closeBtnView];
    
}

@end
