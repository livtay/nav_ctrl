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
#define kOFFSET_FOR_KEYBOARD 80.0

@interface AddNewCompanyViewController () 

@end

@implementation AddNewCompanyViewController

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
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< Watch List" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
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
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNewCompany)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveNewCompany {
    NSString *newCompanyName = self.addCompanyNameTextField.text;
    NSString *newStockSymbol = self.addStockSymbolTextField.text;
    NSString *newImageUrl = self.addImageUrlTextField.text;
    
    [[DAO sharedInstance] addCompanyWithName:newCompanyName andStockSymbol:newStockSymbol andLogo:newImageUrl];
    
    [UIView transitionWithView:self.navigationController.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self.navigationController popToRootViewControllerAnimated:NO];
                    }
                    completion:nil];
    
    [[DAO sharedInstance] downloadStockQuotes];
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
    [self.addCompanyNameTextField endEditing:YES];
    [self.addStockSymbolTextField endEditing:YES];
    [self.addImageUrlTextField endEditing:YES];
    [self setViewMovedUp:NO];
}

- (void)dealloc {
    [self.addCompanyNameTextField release];
    [self.addStockSymbolTextField release];
    [self.addImageUrlTextField release];
    [super dealloc];
}
@end
