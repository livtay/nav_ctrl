//
//  AddNewProductViewController.m
//  NavCtrl
//
//  Created by Olivia Taylor on 8/16/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "AddNewProductViewController.h"
#import "ProductViewController.h"
#import "Product.h"
#import "DAO.h"

@interface AddNewProductViewController ()

@end

@implementation AddNewProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNewProduct)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)saveNewProduct {
    NSString *newProductName = self.addNewProductTextField.text;
    NSString *newProductUrl = self.addNewProductUrlTextField.text;
    NSString *newProductImageUrl = self.addNewProductImageUrlTextField.text;
    
    Product *newProduct = [[Product alloc] initWithProductName:newProductName andUrl:newProductUrl andImageName:newProductImageUrl];
    [self.company.products addObject:newProduct];
}

- (void)dealloc {
    [self.addNewProductTextField release];
    [self.addNewProductUrlTextField release];
    [self.addNewProductImageUrlTextField release];
    [super dealloc];
}
@end
