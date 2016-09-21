//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"
#import "AddNewProductViewController.h"
#import "ProductCell.h"

@interface ProductViewController ()

//@property (strong, nonatomic) NSMutableDictionary *productsForCompany;
@property (retain, nonatomic) IBOutlet UIImageView *productCompanyLogo;
@property (retain, nonatomic) IBOutlet UILabel *productCompanyName;
@property (strong, nonatomic) UIView *emptyView;

@end

@implementation ProductViewController

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
    self.wVC = [[WebViewController alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addProduct)];
//    self.navigationItem.rightBarButtonItems = @[editButton, addBtn];
    self.navigationItem.rightBarButtonItem = addBtn;
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< Watch List" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    self.tableView.allowsSelectionDuringEditing = true;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable)
                                                 name:@"Data Downloaded"
                                               object:nil];
    self.productCompanyLogo.image = [UIImage imageNamed:self.company.companyLogo];
    self.productCompanyName.text = [NSString stringWithFormat:@"%@ (%@)", [self.company.companyName retain], [self.company.stockSymbol retain]];
    
    [addBtn release];
    [backBarButtonItem release];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES];
    self.emptyView = [[[NSBundle mainBundle] loadNibNamed:@"EmptyProducts" owner:self options:nil] objectAtIndex:0];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    self.emptyView.frame = CGRectMake(0, screenHeight/2, screenWidth , screenHeight/2);
    [self.view addSubview:self.emptyView];
    [self reloadTable];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadTable {
    [self.tableView reloadData];
    if (self.company.products.count > 0) {
        self.emptyView.hidden = true;
    } else {
        self.emptyView.hidden = false;
    }
}

-(IBAction)back {
    
    CompanyViewController *companyVC = [[CompanyViewController alloc] init];
    
    [UIView transitionWithView:self.navigationController.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.navigationController pushViewController:companyVC animated:NO];
                    }
                    completion:nil];
}

- (IBAction)emptyAddProductButton:(id)sender {
    
    [self addProduct];
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
    static NSString *CellIdentifier = @"ProductCell";
    ProductCell *cell = [(ProductCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier] retain];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    Product *product = [self.company.products objectAtIndex:[indexPath row]];

    cell.cellProductName.text = [NSString stringWithFormat:@"%@", product.productName];
    
//    cell.imageView.image = [UIImage imageNamed:product.imageName];
    
    UIImage *productImage = [UIImage imageNamed:[[self.company.products objectAtIndex:[indexPath row]] imageName]];
    if (productImage == nil) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *documentsURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
        NSURL *fileURL = [documentsURL URLByAppendingPathComponent:[[self.company.products objectAtIndex:[indexPath row]] productName]];
        NSData *imageData = [NSData dataWithContentsOfURL:fileURL];
        productImage = [UIImage imageWithData:imageData];
    }
    
//    [[cell imageView] setImage:productImage];
    cell.cellProductImage.image = productImage;
    
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
        
        Product *product = [self.company.products objectAtIndex:[indexPath row]];
        [[DAO sharedInstance] deleteProduct:product.productName];
        
        [self.company.products removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self reloadTable];
        
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
    
    [UIView transitionWithView:self.navigationController.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^{
                        [self.navigationController pushViewController:self.addNewProductViewController animated:NO];
                    }
                    completion:nil];
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
    NSURL *prodUrl = [NSURL URLWithString:[self.company.products[indexPath.row] productUrl]];
    self.wVC.webUrl = prodUrl;
    self.wVC.product = [self.company.products objectAtIndex:indexPath.row];
    
    [UIView transitionWithView:self.navigationController.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self.navigationController pushViewController:self.wVC animated:NO];
                    }
                    completion:nil];
    
}


- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_productCompanyLogo release];
    [_productCompanyName release];
    [_tableView release];
    [_company release];
    [super dealloc];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

@end















