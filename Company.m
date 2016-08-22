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

- (instancetype)initWithCompanyName:(NSString *)companyName andStockSymbol:(NSString *)stockSymbol andLogo:(NSString *)companyLogo {
    self = [super init];
    if (self) {
        self.companyName = companyName;
        
        //Download image
        //save to file with filename that matches company name
        //load images in the table view (cellforrrowatindexpath) based on the image having the same name as the company
        
        [[DAO sharedInstance] downloadImageUrl:companyLogo andName:companyName];
        
        self.stockSymbol = stockSymbol;
        self.companyLogo = companyLogo;
        self.products = [[NSMutableArray alloc] init];
        return self;
    }
    return nil;
}

@end





