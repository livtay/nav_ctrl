//
//  WebViewController.h
//  NavCtrl
//
//  Created by Olivia Taylor on 8/10/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "EditProductViewController.h"
#import "CompanyViewController.h"
#import "Company.h"
#import "ProductViewController.h"

@interface WebViewController : UIViewController

@property (strong, nonatomic) NSURL *webUrl;
@property (nonatomic, retain) IBOutlet EditProductViewController *editProductViewController;
@property (strong, nonatomic) Company *company;
@property (strong, nonatomic) Product *product;

@end
