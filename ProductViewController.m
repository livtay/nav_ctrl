//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"
#import "AddNewProductViewController.h"


@interface ProductViewController ()

//@property (strong, nonatomic) NSMutableDictionary *productsForCompany;

@end

@implementation ProductViewController

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
    self.wVC = [[WebViewController alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *editButton = self.editButtonItem;
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addProduct)];
    self.navigationItem.rightBarButtonItems = @[editButton, addBtn];
    self.tableView.allowsSelectionDuringEditing = true;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable)
                                                 name:@"Data Downloaded"
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
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
    return [self.company.products count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Product *product = [self.company.products objectAtIndex:[indexPath row]];

    cell.textLabel.text = product.productName;
    
//    cell.imageView.image = [UIImage imageNamed:product.imageName];
    
    UIImage *productImage = [UIImage imageNamed:[[self.company.products objectAtIndex:[indexPath row]] imageName]];
    if (productImage == nil) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *documentsURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
        NSURL *fileURL = [documentsURL URLByAppendingPathComponent:[[self.company.products objectAtIndex:[indexPath row]] productName]];
        NSData *imageData = [NSData dataWithContentsOfURL:fileURL];
        productImage = [UIImage imageWithData:imageData];
    }
    
    [[cell imageView] setImage:productImage];
    
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
        [self.company.products removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

-(void)addProduct {
    
    if (self.addNewProductViewController == nil) {
        self.addNewProductViewController = [[AddNewProductViewController alloc] init];
    }
    
    self.addNewProductViewController.title = @"Add New Product";
    self.addNewProductViewController.company = self.company;
    
    [self.navigationController pushViewController:self.addNewProductViewController animated:YES];
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSString *stringToMove = [self.company.products objectAtIndex:fromIndexPath.row];
    [self.company.products removeObjectAtIndex:fromIndexPath.row];
    [self.company.products insertObject:stringToMove atIndex:toIndexPath.row];
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
    NSString *editTitle = [NSString stringWithFormat:@"Edit Product: %@", [[self.company.products objectAtIndex:indexPath.row] productName]];
    if (self.editing) {
        self.editProductViewController = [[EditProductViewController alloc] init];
        self.editProductViewController.title = editTitle;
        self.editProductViewController.product = [self.company.products objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:self.editProductViewController
                                             animated:YES];
        
    } else {
        NSURL *prodUrl = [NSURL URLWithString:[self.company.products[indexPath.row] productUrl]];
        self.wVC.webUrl = prodUrl;
        [self.navigationController pushViewController:self.wVC animated:YES];
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















