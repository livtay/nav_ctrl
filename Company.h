//
//  Company.h
//  NavCtrl
//
//  Created by Olivia Taylor on 8/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject

@property (strong, nonatomic) NSString *companyName;
@property (strong, nonatomic) NSString *companyLogo;
@property (strong, nonatomic) NSNumber *stockPrice;
@property (strong, nonatomic) NSString *stockName;
@property (strong, nonatomic) NSMutableArray *products;

- (instancetype)initWithCompanyName:(NSString *)companyName andLogo:(NSString *)companyLogo;

@end
