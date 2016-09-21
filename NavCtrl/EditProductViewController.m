//
//  EditProductViewController.m
//  NavCtrl
//
//  Created by Olivia Taylor on 8/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "EditProductViewController.h"
#define kOFFSET_FOR_KEYBOARD 80.0

@interface EditProductViewController ()

@end

@implementation EditProductViewController

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
    // Do any additional setup after loading the view from its nib.
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
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveEditedProduct)];
    self.navigationItem.rightBarButtonItem = saveButton;
    self.editProductNameTextField.text = self.product.productName;
    self.editProductUrlTextField.text = self.product.productUrl;
    self.editProductImageTextField.text = self.product.imageName;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveEditedProduct {
    self.product.productName = self.editProductNameTextField.text;
    self.product.productUrl = self.editProductUrlTextField.text;
    self.product.imageName = self.editProductImageTextField.text;
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


#pragma mark - UITextfieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self setViewMovedUp:NO];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self keyboardWillHide];
    [self.editProductNameTextField endEditing:YES];
    [self.editProductUrlTextField endEditing:YES];
    [self.editProductImageTextField endEditing:YES];
    [self setViewMovedUp:NO];
}

- (void)dealloc {
    [self.editProductNameTextField release];
    [self.editProductUrlTextField release];
    [self.editProductImageTextField release];
    [super dealloc];
}
@end
