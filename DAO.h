//
//  DAO.h
//  NavCtrl
//
//  Created by Olivia Taylor on 8/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAO : NSObject

@property (nonatomic, retain) NSMutableArray *companyList;

+ (instancetype)sharedInstance;

- (void)createCompanies;
- (void)downloadImageUrl:(NSString *)imageUrl andName:(NSString *)name;
- (void)downloadStockQuotes;

@end
