//
//  AddNewProductViewController.h
//  NavCtrl
//
//  Created by Olivia Taylor on 8/16/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"

@interface AddNewProductViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *addNewProductTextField;
@property (retain, nonatomic) IBOutlet UITextField *addNewProductUrlTextField;
@property (retain, nonatomic) IBOutlet UITextField *addNewProductImageUrlTextField;
@property (strong, nonatomic) Company *company;

@end
