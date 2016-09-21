//
//  SuperViewController.m
//  NavCtrl
//
//  Created by Olivia Taylor on 9/21/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "SuperViewController.h"

@interface SuperViewController ()

@end

@implementation SuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (UIView * view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField * textField = (UITextField*)view;
            textField.delegate = self;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
