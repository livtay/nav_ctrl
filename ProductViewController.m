//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"

@interface ProductViewController ()

@property (strong, nonatomic) NSMutableDictionary *productsForCompany;

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
    self.productsForCompany = [[NSMutableDictionary alloc] init];
    [self.productsForCompany setObject:[[NSMutableArray alloc] initWithArray:@[@"iPad", @"iPod Touch",@"iPhone"]] forKey:@"Apple mobile devices"];
    [self.productsForCompany setObject:[[NSMutableArray alloc] initWithArray:@[@"Galaxy S4", @"Galaxy Note", @"Galaxy Tab"]] forKey:@"Samsung mobile devices"];
    [self.productsForCompany setObject:[[NSMutableArray alloc] initWithArray:@[@"Lumia 1520", @"Lumia 650", @"N1"]] forKey:@"Nokia mobile devices"];
    [self.productsForCompany setObject:[[NSMutableArray alloc] initWithArray:@[@"Moto Z Droid", @"Moto X Pure Edition", @"XOOM Tablet"]] forKey:@"Motorola mobile devices"];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.products = [self.productsForCompany objectForKey:self.title];

    [self.tableView reloadData];
    
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
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [self.products objectAtIndex:[indexPath row]];
    
    if ([self.title isEqualToString:@"Apple mobile devices"]) {
        [[cell imageView] setImage:[UIImage imageNamed:@"apple.png"]];
    } else if ([self.title isEqualToString:@"Samsung mobile devices"]) {
        [[cell imageView] setImage:[UIImage imageNamed:@"Samsung.png"]];
    } else if ([self.title isEqualToString:@"Nokia mobile devices"]) {
        [[cell imageView] setImage:[UIImage imageNamed:@"Nokia2.jpg"]];
    } else if ([self.title isEqualToString:@"Motorola mobile devices"]) {
        [[cell imageView] setImage:[UIImage imageNamed:@"motorola2.jpg"]];
    }
    
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
        [self.products removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSString *stringToMove = [self.products objectAtIndex:fromIndexPath.row];
    [self.products removeObjectAtIndex:fromIndexPath.row];
    [self.products insertObject:stringToMove atIndex:toIndexPath.row];
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
    // Navigation logic may go here, for example:
    // Create the next view controller.

    // Pass the selected object to the new view controller.
    NSString *ipodUrl = @"https://www.apple.com/ipod-touch/";
    NSString *ipadUrl = @"https://www.apple.com/ipad/";
    NSString *iphoneUrl = @"https://www.apple.com/iphone/";
    
    NSString *s4Url = @"https://www.cnet.com/products/samsung-galaxy-s4/";
    NSString *noteUrl = @"https://www.cnet.com/products/samsung-galaxy-note-7-preview/";
    NSString *galTabUrl = @"https://www.cnet.com/products/samsung-galaxy-tab-e/";
    
    NSString *lumia1520 = @"https://www.microsoft.com/en-us/mobile/phone/lumia1520/";
    NSString *lumia650 = @"https://www.microsoft.com/en-us/mobile/es/lumia650/";
    NSString *n1 = @"https://www.cnet.com/products/nokia-n1/";
    
    NSString *motoZ = @"https://www.motorola.com/us/products/moto-z-droid-edition";
    NSString *motoX = @"https://www.motorola.com/us/products/moto-x-pure-edition";
    NSString *xoomTab = @"https://www.cnet.com/products/motorola-with-wi-fi/";
    
    
    NSString *product = [self.products objectAtIndex:indexPath.row];
    
    
    if ([self.title isEqualToString:@"Apple mobile devices"]) {
        if ([product isEqual:@"iPad"]){
            self.wVC.webUrl = [NSURL URLWithString:ipadUrl];
        } else if ([product isEqual:@"iPod Touch"]){
            self.wVC.webUrl = [NSURL URLWithString:ipodUrl];
        } else if ([product isEqual:@"iPhone"]) {
            self.wVC.webUrl = [NSURL URLWithString:iphoneUrl];
        }
    } else if ([self.title isEqualToString:@"Samsung mobile devices"]) {
        if ([product isEqual:@"Galaxy S4"]) {
            self.wVC.webUrl = [NSURL URLWithString:s4Url];
        } else if ([product isEqual:@"Galaxy Note"]) {
            self.wVC.webUrl = [NSURL URLWithString:noteUrl];
        } else if ([product isEqual:@"Galaxy Tab"]) {
            self.wVC.webUrl = [NSURL URLWithString:galTabUrl];
        }
    } else if ([self.title isEqualToString:@"Nokia mobile devices"]) {
        if ([product isEqual:@"Lumia 1520"]) {
            self.wVC.webUrl = [NSURL URLWithString:lumia1520];
        } else if ([product isEqual:@"Lumia 650"]) {
            self.wVC.webUrl = [NSURL URLWithString:lumia650];
        } else if ([product isEqual:@"N1"]) {
            self.wVC.webUrl = [NSURL URLWithString:n1];
        }
    } else if ([self.title isEqualToString:@"Motorola mobile devices"]) {
        if ([product isEqual:@"Moto Z Droid"]) {
            self.wVC.webUrl = [NSURL URLWithString:motoZ];
        } else if ([product isEqual:@"Moto X Pure Edition"]) {
            self.wVC.webUrl = [NSURL URLWithString:motoX];
        } else if ([product isEqual:@"XOOM Tablet"]) {
            self.wVC.webUrl = [NSURL URLWithString:xoomTab];
        }
    }
    
    // Push the view controller.
    [self.navigationController pushViewController:self.wVC animated:YES];
}
 



@end















