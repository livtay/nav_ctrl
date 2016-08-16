//
//  AddNewCompanyViewController.m
//  NavCtrl
//
//  Created by Olivia Taylor on 8/16/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "AddNewCompanyViewController.h"
#import "DAO.h"
#import "Company.h"

@interface AddNewCompanyViewController ()

@end

@implementation AddNewCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNewCompany)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveNewCompany {
    NSString *newCompanyName = self.addCompanyNameTextField.text;
//    NSString *newStockSymbol = self.addStockSymbolTextField.text;
    NSString *newImageUrl = self.addImageUrlTextField.text;
    
    Company *newCompany = [[Company alloc] initWithCompanyName:newCompanyName andLogo:newImageUrl];
    [[[DAO sharedInstance] companyList] addObject:newCompany];
    
}

- (void)dealloc {
    [self.addCompanyNameTextField release];
    [self.addStockSymbolTextField release];
    [self.addImageUrlTextField release];
    [super dealloc];
}
@end
