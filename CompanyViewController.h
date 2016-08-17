//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "Product.h"
#import "AddNewCompanyViewController.h"
#import "EditCompanyViewController.h"

@class ProductViewController;

@interface CompanyViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *companyList;

@property (nonatomic, retain) IBOutlet ProductViewController *productViewController;
@property (nonatomic, retain) IBOutlet AddNewCompanyViewController *addNewCompanyViewController;
@property (nonatomic, retain) IBOutlet EditCompanyViewController *editCompanyViewController;

@end
