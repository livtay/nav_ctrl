//
//  DAO.h
//  NavCtrl
//
//  Created by Olivia Taylor on 8/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "ManagedCompany.h"

@interface DAO : NSObject

@property (nonatomic, retain) NSMutableArray *companyList;
@property (strong, nonatomic) Company *company;
@property (nonatomic, strong) NSManagedObjectContext *context;


+ (instancetype)sharedInstance;

- (void)createCompanies;
- (void)downloadImageUrl:(NSString *)imageUrl andName:(NSString *)name;
- (void)downloadStockQuotes;
- (Company*)addCompanyWithName:(NSString *)newCompanyName andStockSymbol:(NSString *)newStockSymbol andLogo:(NSString *)newImageUrl;
- (void)addProductWithName:(NSString *)newProductName andUrl:(NSString *)newProductUrl andImage:(NSString *)newProductImageUrl toCompany:(int)companyId;
- (void)loadAllCompanies;
- (void)loadAllProducts;
- (void)deleteProduct:(NSString *)productName;
- (void)deleteCompany:(int)companyId;
- (void)undoAction;
- (void)redoAction;

@end
