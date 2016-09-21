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
#define kOFFSET_FOR_KEYBOARD 80.0

@interface AddNewProductViewController ()

@end

@implementation AddNewProductViewController

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    [backBarButtonItem release];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
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
    int newProductCompany = self.company.companyId;
    
    [[DAO sharedInstance] addProductWithName:newProductName andUrl:newProductUrl andImage:newProductImageUrl toCompany:newProductCompany] ;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)back {
    
    CompanyViewController *companyVC = [[CompanyViewController alloc] init];
    
    [UIView transitionWithView:self.navigationController.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^{
                        [self.navigationController pushViewController:companyVC animated:NO];
                    }
                    completion:nil];
}

#pragma mark - UITextfieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self setViewMovedUp:NO];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self keyboardWillHide];
    [self.addNewProductTextField endEditing:YES];
    [self.addNewProductUrlTextField endEditing:YES];
    [self.addNewProductImageUrlTextField endEditing:YES];
    [self setViewMovedUp:NO];
}

- (void)dealloc {
    [self.addNewProductTextField release];
    [self.addNewProductUrlTextField release];
    [self.addNewProductImageUrlTextField release];
    [super dealloc];
}
@end
