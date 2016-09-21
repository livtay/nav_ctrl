//
//  Company.m
//  NavCtrl
//
//  Created by Olivia Taylor on 8/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"
#import "DAO.h"

@implementation Company

- (instancetype)initWithCompanyName:(NSString *)companyName andStockSymbol:(NSString *)stockSymbol andLogo:(NSString *)companyLogo andId:(int )companyId{
    self = [super init];
    if (self) {
        _companyName = [companyName retain];
        
        //Download image
        //save to file with filename that matches company name
        //load images in the table view (cellforrrowatindexpath) based on the image having the same name as the company
        
        //check if the image file already exists in the documents directory
        //if not, download it.
        //if it does exist, don't download it.
        //        NSFileManager *fileManager = [NSFileManager defaultManager];
        //        NSURL *documentsURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
        //        NSURL *fileURL = [documentsURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", companyName]];
        //        NSString *fileUrlString = [fileURL absoluteString];
        
        UIImage *logoImage = [UIImage imageNamed:companyLogo];
        if (logoImage == nil) {
            [[DAO sharedInstance] downloadImageUrl:companyLogo andName:companyName];
        }
        
        _stockSymbol = [stockSymbol retain];
        _companyLogo = [companyLogo retain];
        _products = [[NSMutableArray alloc] init];
        
        _companyId = companyId;
          return self;
    }
    return nil;
  
}

- (instancetype)initWithCompanyName:(NSString *)companyName andStockSymbol:(NSString *)stockSymbol andLogo:(NSString *)companyLogo {
    self = [super init];
    if (self) {
         _companyName = [companyName retain];
        
        //Download image
        //save to file with filename that matches company name
        //load images in the table view (cellforrrowatindexpath) based on the image having the same name as the company
        
        //check if the image file already exists in the documents directory
        //if not, download it.
        //if it does exist, don't download it.
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        NSURL *documentsURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
//        NSURL *fileURL = [documentsURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", companyName]];
//        NSString *fileUrlString = [fileURL absoluteString];
        
        UIImage *logoImage = [UIImage imageNamed:companyLogo];
        if (logoImage == nil) {
            [[DAO sharedInstance] downloadImageUrl:companyLogo andName:companyName];
        }
        
        _stockSymbol = [stockSymbol retain];
        _companyLogo = [companyLogo retain];
        _products = [[NSMutableArray alloc] init];
        
        //check nsuserdefaults for "companyIdCounter"
        //if there's a value, increment it and use it as the new company's companyId
        //else set it to 1 and use that.
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (![defaults integerForKey:@"companyIdCounter"]) {
            [defaults setInteger:1 forKey:@"companyIdCounter"];
            self.companyId = 1;
        } else {
            self.companyId = (int)[defaults integerForKey:@"companyIdCounter"] + 1;
            [defaults setInteger:self.companyId forKey:@"companyIdCounter"];
        }
        
        return self;
    }
    return nil;
}

-(void)dealloc {
    [_companyName release];
    [_stockSymbol release];
    [_companyLogo release];
    [_products release];
    [_stockPrice release];
    
    
    [super dealloc];
}

@end





