//
//  TianmuNativeTableViewCell.m
//  TianmuSDK-Demo
//
//  Created by 陈则富 on 2021/9/18.
//

#import "TianmuNativeTableViewCell.h"

@implementation TianmuNativeTableViewCell

- (void)setAdView:(UIView *)adView {
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    _adView = adView;
    _adView.frame = self.contentView.bounds;
    [self.contentView addSubview:_adView];
}

@end
