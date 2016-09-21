//
//  WebViewController.m
//  NavCtrl
//
//  Created by Olivia Taylor on 8/10/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIBarButtonItem *editBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed)];
    self.navigationItem.rightBarButtonItem = editBtn;
    
    [editBtn release];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.webUrl];
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.webView loadRequest:request];
    self.webView.frame = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.webView];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)editButtonPressed {
    NSString *editTitle = [NSString stringWithFormat:@"Edit Product: %@", self.product.productName];
    self.editProductViewController = [[EditProductViewController alloc] init];
    self.editProductViewController.title = editTitle;
    self.editProductViewController.product = self.product;
    [self.navigationController pushViewController:self.editProductViewController
                                         animated:YES];

}


@end
