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

@interface CompanyViewController ()

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
    
    Product *iPad = [[Product alloc] initWithProductName:@"iPad" andUrl:@"https://www.apple.com/ipad/" andImageName:@"apple.png"];
    Product *iPodTouch = [[Product alloc] initWithProductName:@"iPod Touch" andUrl:@"https://www.apple.com/ipod-touch/" andImageName:@"apple.png"];
    Product *iPhone = [[Product alloc] initWithProductName:@"iPhone" andUrl:@"https://www.apple.com/iphone/" andImageName:@"apple.png"];
    Company *apple = [[Company alloc] initWithCompanyName:@"Apple mobile devices" andLogo:[UIImage imageNamed:@"apple.png"]];
    [apple.products addObjectsFromArray:@[iPad, iPhone, iPodTouch]];

    Product *galaxyS4 = [[Product alloc] initWithProductName:@"Galaxy S4" andUrl:@"https://www.cnet.com/products/samsung-galaxy-s4/" andImageName:@"Samsung"];
    Product *galaxyNote = [[Product alloc] initWithProductName:@"Galaxy Note" andUrl:@"https://www.cnet.com/products/samsung-galaxy-note-7-preview/" andImageName:@"Samsung"];
    Product *galaxyTab = [[Product alloc] initWithProductName:@"Galaxy Tab" andUrl:@"https://www.cnet.com/products/samsung-galaxy-tab-e/" andImageName:@"Samsung"];
    Company *samsung = [[Company alloc] initWithCompanyName:@"Samsung mobile devices" andLogo:[UIImage imageNamed:@"Samsung.png"]];
    [samsung.products addObjectsFromArray:@[galaxyS4, galaxyNote, galaxyTab]];
    
    Product *lumia1520 = [[Product alloc] initWithProductName:@"Lumia 1520" andUrl:@"https://www.microsoft.com/en-us/mobile/phone/lumia1520/" andImageName:@"Nokia2.jpg"];
    Product *lumia650 = [[Product alloc] initWithProductName:@"Lumia 650" andUrl:@"https://www.microsoft.com/en-us/mobile/es/lumia650/" andImageName:@"Nokia2.jpg"];
    Product *n1 = [[Product alloc] initWithProductName:@"N1" andUrl:@"https://www.cnet.com/products/nokia-n1/" andImageName:@"Nokia2.jpg"];
    Company *nokia = [[Company alloc] initWithCompanyName:@"Nokia mobile devices" andLogo:[UIImage imageNamed:@"Nokia2.jpg"]];
    [nokia.products addObjectsFromArray:@[lumia1520, lumia650, n1]];
    
    Product *motoZ = [[Product alloc] initWithProductName:@"Moto Z Droid" andUrl:@"https://www.motorola.com/us/products/moto-z-droid-edition" andImageName:@"motorola2.jpg"];
    Product *motoXPure = [[Product alloc] initWithProductName:@"Moto X Pure Edition" andUrl:@"https://www.motorola.com/us/products/moto-x-pure-edition" andImageName:@"motorola2.jpg"];
    Product *xoomTab = [[Product alloc] initWithProductName:@"XOOM Tablet" andUrl:@"https://www.cnet.com/products/motorola-with-wi-fi/" andImageName:@"motorola2.jpg"];
    Company *motorola = [[Company alloc] initWithCompanyName:@"Motorola mobile devices" andLogo:[UIImage imageNamed:@"motorola2.jpg"]];
    [motorola.products addObjectsFromArray:@[motoZ, motoXPure, xoomTab]];
    
    self.companyList = [[NSMutableArray alloc] initWithObjects:apple, samsung, nokia, motorola, nil];
    self.title = @"Mobile device makers";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

    cell.textLabel.text = [[self.companyList objectAtIndex:[indexPath row]] companyName];
    [[cell imageView] setImage:[[self.companyList objectAtIndex:[indexPath row]] companyLogo]];
    
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
        [self.companyList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
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

    self.productViewController.title = [[self.companyList objectAtIndex:indexPath.row] companyName];
    self.productViewController.company = [self.companyList objectAtIndex:indexPath.row];

    
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];
    

}



@end
