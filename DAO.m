//
//  DAO.m
//  NavCtrl
//
//  Created by Olivia Taylor on 8/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DAO.h"
#import "Company.h"
#import "Product.h"
#import <CoreData/CoreData.h>
#import "ManagedCompany.h"
#import "ManagedProduct.h"


@interface DAO()
@property (nonatomic, strong) NSManagedObjectModel *model;
@property (nonatomic, retain) NSMutableArray *managedCompanies;
@property (nonatomic, retain) NSMutableArray *managedProducts;
@end

@implementation DAO

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance createModelContext];
    });
    
    return sharedInstance;
}

- (void)createModelContext {
    
    self.model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *psc =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
    NSString *path = [self archivePath];
    NSURL *storeURL = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    if(![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        [NSException raise:@"Open failed" format:@"Reason: %@", [error localizedDescription]];
    }
    self.context = [[NSManagedObjectContext alloc] init];
    [self.context setPersistentStoreCoordinator:psc];
    [self.context setUndoManager: [[NSUndoManager alloc] init]];
    self.managedCompanies = [[NSMutableArray alloc] init];
    self.companyList = [[NSMutableArray alloc]init];
    
}

- (NSString*)archivePath {

    NSArray *documentsDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [documentsDirectories objectAtIndex:0];
    NSLog(@"%@", documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:@"store.data"];
}

- (Company*)addCompanyWithName:(NSString *)newCompanyName andStockSymbol:(NSString *)newStockSymbol andLogo:(NSString *)newImageUrl {
    
    Company *newCompany = [[Company alloc] initWithCompanyName:newCompanyName andStockSymbol:newStockSymbol andLogo:newImageUrl];
    [self.companyList addObject:newCompany];
    ManagedCompany *companyMO = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:self.context];
    companyMO.companyName = newCompany.companyName;
    companyMO.stockSymbol = newCompany.stockSymbol;
    companyMO.companyLogo = newCompany.companyLogo;
    companyMO.companyId = [NSNumber numberWithInteger:newCompany.companyId];
    [self.managedCompanies addObject:companyMO];
    
    [self.context save:nil];
    return newCompany;
}

- (void)addProductWithName:(NSString *)newProductName andUrl:(NSString *)newProductUrl andImage:(NSString *)newProductImageUrl toCompany:(int)companyId {
    
    Product *newProduct = [[Product alloc] initWithProductName:newProductName andUrl:newProductUrl andImageName:newProductImageUrl toCompany:companyId];
    [self.company.products addObject:newProduct];
    
    ManagedProduct *productMO = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.context];
    productMO.productName = newProduct.productName;
    productMO.productUrl = newProduct.productUrl;
    productMO.productImage = newProduct.imageName;
    productMO.companyId = [NSNumber numberWithInteger:newProduct.companyId];
    [self.managedProducts addObject:productMO];
    
    //Fetch a company with companyID
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"companyId == %d", companyId];
    [request setPredicate:p];
    NSEntityDescription *e = [[self.model entitiesByName] objectForKey:@"Company"];
    [request setEntity:e];
    NSError *error = nil;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    
    if(error){
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    } else if(result.count >= 1){
        ManagedCompany *mc = [result objectAtIndex:0];
        productMO.company = mc;
    }
    
    //get only one object
    //set relationship between NSManagedProduct and NSManagedCompany
    
    [self.context save:nil];
}

- (void)createCompanies {
        
    Company *apple = [self addCompanyWithName:@"Apple Inc." andStockSymbol:@"AAPL" andLogo:@"img-companyLogo-Apple.png"];
    self.company = apple;
    [self addProductWithName:@"iPad" andUrl:@"https://www.apple.com/ipad/" andImage:@"ipad-img.png" toCompany:apple.companyId];
    [self addProductWithName:@"MacBook Pro" andUrl:@"https://www.apple.com/macbook-pro/" andImage:@"img-MacBook-Pro.png" toCompany:apple.companyId];
    [self addProductWithName:@"iPhone" andUrl:@"https://www.apple.com/iphone/" andImage:@"iphone6-img.png" toCompany:apple.companyId];
    
    Company *google = [self addCompanyWithName:@"Google" andStockSymbol:@"GOOG" andLogo:@"img-companyLogo-Google.png"];
    self.company = google;
    
    Company *twitter = [self addCompanyWithName:@"Twitter" andStockSymbol:@"TWTR" andLogo:@"img-companyLogo-Twitter.png"];
    self.company = twitter;
    
    Company *tesla = [self addCompanyWithName:@"Tesla Motors" andStockSymbol:@"TSLA" andLogo:@"img-companyLogo-Tesla.png"];
    self.company = tesla;
    
    [self downloadStockQuotes];
    
    [self.context save:nil];
}


- (void)loadAllCompanies {

    [self.companyList removeAllObjects];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    //NSPredicate *p = [NSPredicate predicateWithFormat:@"emp_id >1"];
    //[request setPredicate:p];
    NSEntityDescription *e = [[self.model entitiesByName] objectForKey:@"Company"];
    [request setEntity:e];
    NSError *error = nil;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    } else if (!result) {
        [self createCompanies];
    } else {
        for(ManagedCompany *mc in result){
            Company *company = [[Company alloc]initWithCompanyName:mc.companyName andStockSymbol:mc.stockSymbol andLogo:[mc valueForKey:@"companyLogo"] andId:[mc.companyId intValue]];
            [self.companyList addObject:company];
            
            for (ManagedProduct *mp in mc.products) {
                Product *product = [[Product alloc] initWithProductName:mp.productName andUrl:mp.productUrl andImageName:mp.productImage toCompany:(int)[mp.companyId integerValue]];
                [company.products addObject:product];
            }
            // 1. get (core data) managed products from mc
            // 2. loop through them
            // 3. for each one create an NSObject Product and add to company.products
        }

    }
    
}

- (void)loadAllProducts
{
    for (Company *company in self.companyList) {
        if (company.products.count == 0) {
            NSFetchRequest *request = [[NSFetchRequest alloc]init];
            //NSPredicate *p = [NSPredicate predicateWithFormat:@"emp_id >1"];
            //[request setPredicate:p];
            NSEntityDescription *e = [[self.model entitiesByName] objectForKey:@"Product"];
            [request setEntity:e];
            NSError *error = nil;
            NSArray *result = [self.context executeFetchRequest:request error:&error];
            if(error){
                [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
            } else if (!result) {
                [self createCompanies];
            } else {
                self.company.products = [[NSMutableArray alloc]initWithArray:result];
                
            }
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"Data Updated"
         object:self];
    });
}

- (void)deleteCompany:(int)companyId {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"companyId == %d", companyId];
    [request setPredicate:p];
    NSEntityDescription *e = [[self.model entitiesByName] objectForKey:@"Company"];
    [request setEntity:e];
    NSError *error = nil;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    } else if (result.count >= 1) {
        NSManagedObject *managedCompany = [result objectAtIndex:0];
        [self.context deleteObject:managedCompany];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"Data Updated"
         object:self];
    });
}

- (void)deleteProduct:(NSString *)productName {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"productName == %@", productName];
    [request setPredicate:p];
    NSEntityDescription *e = [[self.model entitiesByName] objectForKey:@"Product"];
    [request setEntity:e];
    NSError *error = nil;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    if(error){
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    } else if (result.count >= 1) {
        NSManagedObject *managedProduct = [result objectAtIndex:0];
        [self.context deleteObject:managedProduct];
    }
}

- (void)undoAction {
    
    [self.context undo];
    [self loadAllCompanies];
}

- (void)redoAction {
    
    [self.context redo];
    [self loadAllCompanies];
}

-(void) reloadDataFromContext {
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *e = [[[self model] entitiesByName] objectForKey:@"Company"];
    [request setEntity:e];
    NSError *error = nil;
    
    //This gets data only from context, not from store
    NSArray *result = [[self context] executeFetchRequest:request error:&error];
    
    if(!result) {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }

    self.managedCompanies = [[NSMutableArray alloc]initWithArray:result];
    
}

- (void)downloadImageUrl:(NSString *)imageUrl andName:(NSString *)name {
    
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSURLSessionTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"downloadTaskWithRequest failed: %@", error);
            return;
        }
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *documentsURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
        NSURL *fileURL = [documentsURL URLByAppendingPathComponent:name];
        NSLog(@"%@", fileURL);
        NSError *moveError;
        if (![fileManager moveItemAtURL:location toURL:fileURL error:&moveError]) {
            NSLog(@"moveItemAtURL failed: %@", moveError);
            return;
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"Data Updated"
                 object:self];
            });
        }
    }];
    [downloadTask resume];
}

- (void)downloadStockQuotes {
    
    NSString *urlString = @"http://finance.yahoo.com/d/quotes.csv?s=";
    
    NSMutableArray *stockSymbols = [[NSMutableArray alloc] init];
    for (Company *company in self.companyList) {
        [stockSymbols addObject:company.stockSymbol];
    }
    NSString *stockSymbolSeparator = [stockSymbols componentsJoinedByString:@"+"];
    urlString = [[urlString stringByAppendingString:stockSymbolSeparator] stringByAppendingString:@"&f=a"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlReq = [NSMutableURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:urlReq completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error != nil) {
                if (error.code == NSURLErrorNotConnectedToInternet) {
                    UIAlertController *errorAlert;
                    errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"No internet access" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
                    [errorAlert addAction:defaultAction];
                }
            }
        });
        if (!error) {
            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSArray *stockPrices = [dataString componentsSeparatedByString:@"\n"];
            NSLog(@"%@", stockPrices);
            
            for (int i = 0; i < stockPrices.count; i++) {
                for (i = 0; i < [self.companyList count]; i++) {
                    Company *company = [self.companyList objectAtIndex:i];
                    company.stockPrice = stockPrices[i];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"Data Updated"
                 object:self];
            });
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
    }];
    [task resume];
    
}



@end











