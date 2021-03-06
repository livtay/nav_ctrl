//
//  EditCompanyViewController.h
//  NavCtrl
//
//  Created by Olivia Taylor on 8/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "SuperViewController.h"
#import "CompanyViewController.h"

@interface EditCompanyViewController : SuperViewController

@property (retain, nonatomic) IBOutlet UITextField *editCompanyTextField;
@property (retain, nonatomic) IBOutlet UITextField *editSymbolTextField;
@property (retain, nonatomic) IBOutlet UITextField *editImageUrlTextField;
@property (strong, nonatomic) Company *company;

@end
