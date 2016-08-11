//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "WebViewController.h"
#import "CompanyViewController.h"
#import "Product.h"

@interface ProductViewController : UITableViewController

//@property (nonatomic, retain) NSMutableArray *products; //
@property (strong, nonatomic) WebViewController *wVC;
@property (strong, nonatomic) Company *company;
//@property (strong, nonatomic) DAO *dao;


@end
