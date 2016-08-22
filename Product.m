//
//  Product.m
//  NavCtrl
//
//  Created by Olivia Taylor on 8/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Product.h"
#import "DAO.h"

@implementation Product

- (instancetype)initWithProductName:(NSString *)productName andUrl:(NSString *)productUrl andImageName:(NSString *)imageName {
    self = [super init];
    if (self) {
        self.productName = productName;
        
        [[DAO sharedInstance] downloadImageUrl:imageName andName:productName];
        self.productUrl = productUrl;
        self.imageName = imageName;
        return self;
    }
    return nil;
}

@end
