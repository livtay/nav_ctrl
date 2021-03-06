//
//  AddNewCompanyViewController.h
//  NavCtrl
//
//  Created by Olivia Taylor on 8/16/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
#import "CompanyViewController.h"

@interface AddNewCompanyViewController : SuperViewController

@property (retain, nonatomic) IBOutlet UITextField *addCompanyNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *addStockSymbolTextField;
@property (retain, nonatomic) IBOutlet UITextField *addImageUrlTextField;

@end
