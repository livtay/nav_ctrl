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
#import "CompanyCell.h"

@interface CompanyViewController ()

@property (nonatomic, strong) DAO *dao;
@property (strong, nonatomic) UIView *emptyView;
@property (strong, nonatomic) UIBarButtonItem *editBtn;

@end

@implementation CompanyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    // Uncomment the following line to preserve selection between presentations.
//     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.editBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed)];
    self.navigationItem.leftBarButtonItem = self.editBtn;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.50 green:0.71 blue:0.22 alpha:1.0];
    
    self.dao = [DAO sharedInstance];
    self.tableView.allowsSelectionDuringEditing = true;
    self.title = @"Watch List";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCompany)];
    self.navigationItem.rightBarButtonItem = addBtn;
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
    self.emptyView = [[[NSBundle mainBundle] loadNibNamed:@"EmptyCompanies" owner:self options:nil] objectAtIndex:0];
    self.emptyView.frame = self.view.frame;
    self.tableView.frame = self.view.frame;
    [self.view addSubview:self.emptyView];
    
    
}

- (void)editButtonPressed {
    self.tableView.editing = YES;
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    self.navigationItem.leftBarButtonItem = doneBtn;
    
    //Bottom toolbar
    [self.navigationController setToolbarHidden:NO];
    self.navigationController.toolbar.barTintColor = [UIColor blackColor];
    self.navigationController.toolbar.tintColor = [UIColor whiteColor];
    //Add button items
    UIBarButtonItem *undoButton = [[UIBarButtonItem alloc] initWithTitle:@"Undo"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(undoAction)];
    UIBarButtonItem *redoButton = [[UIBarButtonItem alloc] initWithTitle:@"Redo"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(redoAction)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil
                                                                                   action:nil];
    self.toolbarItems = [NSArray arrayWithObjects:flexibleSpace, redoButton, flexibleSpace, undoButton, flexibleSpace, nil];
    
}

- (void)doneButtonPressed {
    self.tableView.editing = NO;
    self.navigationItem.leftBarButtonItem = self.editBtn;
    [self.navigationController setToolbarHidden:YES];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self reloadTable];
    [self.navigationController setToolbarHidden:YES];
    [[DAO sharedInstance] downloadStockQuotes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadTable {
    [self.tableView reloadData];
    if (self.companyList.count > 0) {
        self.emptyView.hidden = true;
    } else {
        self.emptyView.hidden = false;
    }
}

- (void)undoAction {
    [[DAO sharedInstance] undoAction];
    [self reloadTable];

}

- (void)redoAction {
    [[DAO sharedInstance] redoAction];
    [self reloadTable];
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
    // Return the number of rows in the section.
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CompanyCell";
    CompanyCell *cell = (CompanyCell *)[[tableView dequeueReusableCellWithIdentifier:CellIdentifier] retain];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.cellCompanyName.text = [NSString stringWithFormat:@"%@ (%@)", [[self.companyList objectAtIndex:[indexPath row]] companyName], [[self.companyList objectAtIndex:[indexPath row]] stockSymbol]];
    cell.cellCompanyStockPrice.text = [NSString stringWithFormat:@"$%@", [[self.companyList objectAtIndex:[indexPath row]] stockPrice]];
    
    UIImage *logoImage = [UIImage imageNamed:[[self.companyList objectAtIndex:[indexPath row]] companyLogo]];
    if (logoImage == nil) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *documentsURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
        NSURL *fileURL = [documentsURL URLByAppendingPathComponent:[[self.companyList objectAtIndex:[indexPath row]] companyName]];
        NSData *imageData = [NSData dataWithContentsOfURL:fileURL];
        logoImage = [UIImage imageWithData:imageData];
    }
    
//    [[cell imageView] setImage:logoImage];
    cell.cellCompanyLogo.image = logoImage;
    
    
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

-(void)emptyAddCompanyButton:(id)sender {
    
    [self addCompany];
}

-(void)addCompany {
    [self.navigationController setToolbarHidden:YES];
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
    if (self.tableView.editing == YES) {
        [self.navigationController setToolbarHidden:YES];
        self.editCompanyViewController = [[EditCompanyViewController alloc] init];
        self.editCompanyViewController.title = editTitle;
        self.editCompanyViewController.company = [self.companyList objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:self.editCompanyViewController
                                             animated:YES];
        
    } else {
        
        //id pid = [[[NSBundle mainBundle] loadNibNamed:@"ProductViewController" owner:self options:nil] objectAtIndex:0];
        
        ProductViewController *productViewController =
        [[ProductViewController alloc]
         initWithNibName:@"ProductViewController" bundle:nil];
        
       // self.productViewController = [[[NSBundle mainBundle] loadNibNamed:@"ProductViewController" owner:self options:nil] objectAtIndex:0];
        
        productViewController.title = [[self.companyList objectAtIndex:indexPath.row] companyName];
        productViewController.company = [self.companyList objectAtIndex:indexPath.row];
        self.dao.company = [self.companyList objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:productViewController
                                             animated:YES];
        
        [productViewController release];
    }
    

}

- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_tableView release];
    [_emptyAddCompanyButton release];
    [super dealloc];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

@end
