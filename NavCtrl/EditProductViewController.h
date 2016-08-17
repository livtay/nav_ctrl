//
//  EditProductViewController.h
//  NavCtrl
//
//  Created by Olivia Taylor on 8/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface EditProductViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *editProductNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *editProductUrlTextField;
@property (retain, nonatomic) IBOutlet UITextField *editProductImageTextField;
@property (strong, nonatomic) Product *product;

@end
