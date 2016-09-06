//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"
#import "Product.h"
#import "DAO.h"
#import "AddNewCompanyViewController.h"

@interface CompanyViewController ()

@property (nonatomic, strong) DAO *dao;

@end

@implementation CompanyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.dao = [DAO sharedInstance];
    self.tableView.allowsSelectionDuringEditing = true;
    self.title = @"Mobile device makers";
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCompany)];
    self.navigationItem.leftBarButtonItem = addBtn;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable)
                                                 name:@"Data Updated"
                                               object:nil];
    static NSString* const hasRunAppOnceKey = @"hasRunAppOnceKey";
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:hasRunAppOnceKey]) {
        [[DAO sharedInstance] createCompanies];
        [[DAO sharedInstance] loadAllProducts];
        [defaults setBool:YES forKey:hasRunAppOnceKey];
    } else {
        [[DAO sharedInstance] loadAllCompanies];
        [[DAO sharedInstance] loadAllProducts];
    }
    self.companyList = self.dao.companyList;

    
}

-(void)viewWillAppear:(BOOL)animated {
    [self reloadTable];
    
    [[DAO sharedInstance] downloadStockQuotes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadTable {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *cellTextString = [NSString stringWithFormat:@"%@ (%@) - $%@", [[self.companyList objectAtIndex:[indexPath row]] companyName], [[self.companyList objectAtIndex:[indexPath row]] stockSymbol], [[self.companyList objectAtIndex:[indexPath row]] stockPrice]];
    cell.textLabel.text = cellTextString;
    
    
    UIImage *logoImage = [UIImage imageNamed:[[self.companyList objectAtIndex:[indexPath row]] companyLogo]];
    if (logoImage == nil) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *documentsURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
        NSURL *fileURL = [documentsURL URLByAppendingPathComponent:[[self.companyList objectAtIndex:[indexPath row]] companyName]];
        NSData *imageData = [NSData dataWithContentsOfURL:fileURL];
        logoImage = [UIImage imageWithData:imageData];
    }
    
    [[cell imageView] setImage:logoImage];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Company *company = [self.companyList objectAtIndex:[indexPath row]];
        [[DAO sharedInstance] deleteCompany:company.companyId];
        
        [self.companyList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
         
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        
       

    }   
}

-(void)addCompany {
    
    if (self.addNewCompanyViewController == nil) {
        self.addNewCompanyViewController = [[AddNewCompanyViewController alloc] init];
    }
    
    self.addNewCompanyViewController.title = @"Add New Company";
    
    [self.navigationController pushViewController:self.addNewCompanyViewController animated:YES];
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    //change the order of the array when this is called
    NSString *stringToMove = [self.companyList objectAtIndex:fromIndexPath.row];
    [self.companyList removeObjectAtIndex:fromIndexPath.row];
    [self.companyList insertObject:stringToMove atIndex:toIndexPath.row];

}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *editTitle = [NSString stringWithFormat:@"Edit Company: %@", [[self.companyList objectAtIndex:indexPath.row] companyName]];
    if (self.editing) {
        self.editCompanyViewController = [[EditCompanyViewController alloc] init];
        self.editCompanyViewController.title = editTitle;
        self.editCompanyViewController.company = [self.companyList objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:self.editCompanyViewController
                                             animated:YES];
        
    } else {
        self.productViewController.title = [[self.companyList objectAtIndex:indexPath.row] companyName];
        self.productViewController.company = [self.companyList objectAtIndex:indexPath.row];
        self.dao.company = [self.companyList objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:self.productViewController
                                             animated:YES];
    }
    

}

- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}



@end
