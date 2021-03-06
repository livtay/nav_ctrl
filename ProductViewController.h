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
#import "AddNewProductViewController.h"
#import "EditProductViewController.h"
#import "DAO.h"

@class WebViewController;

@interface ProductViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, retain) NSMutableArray *products; //
@property (strong, nonatomic) WebViewController *wVC;
@property (strong, nonatomic) Company *company;
//@property (strong, nonatomic) DAO *dao;
@property (nonatomic, retain) IBOutlet AddNewProductViewController *addNewProductViewController;
@property (nonatomic, retain) IBOutlet EditProductViewController *editProductViewController;
@property (nonatomic, retain) IBOutlet CompanyViewController *companyViewController;
@property (retain, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)emptyAddProductButton:(id)sender;

@end
