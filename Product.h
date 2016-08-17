//
//  Product.h
//  NavCtrl
//
//  Created by Olivia Taylor on 8/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"

@interface Product : NSObject

@property (strong, nonatomic) NSString *productName;
@property (strong, nonatomic) NSString *productUrl;
@property (strong, nonatomic) NSString *imageName;

- (instancetype)initWithProductName:(NSString *)productName andUrl:(NSString *)productUrl andImageName:(NSString *)imageName;

@end
