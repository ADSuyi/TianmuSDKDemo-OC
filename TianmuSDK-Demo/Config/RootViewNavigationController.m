//
//  RootViewNavigationController.m
//  TianmuSDK-Demo
//
//  Created by 陈则富 on 2021/9/13.
//

#import "RootViewNavigationController.h"

@interface RootViewNavigationController ()

@end

@implementation RootViewNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 13.0, *)) {
        [self.navigationBar.standardAppearance configureWithOpaqueBackground];
        self.navigationBar.standardAppearance.backgroundColor = [UIColor colorWithRed:36/255.0 green:132/255.0 blue:207/255.0 alpha:1];
        [self.navigationBar.standardAppearance setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        self.navigationBar.scrollEdgeAppearance= self.navigationBar.standardAppearance;
        
    } else {
        // Fallback on earlier versions
        self.navigationBar.barTintColor = [UIColor colorWithRed:36/255.0 green:132/255.0 blue:207/255.0 alpha:1];
        [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    }
    // Do any additional setup after loading the view.
   
}

- (void)backBtnclick {
    [self popViewControllerAnimated:YES];
}

@end
