//
//  Product.m
//  NavCtrl
//
//  Created by Olivia Taylor on 8/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

- (instancetype)initWithProductName:(NSString *)productName andUrl:(NSString *)productUrl andImageName:(NSString *)imageName {
    self = [super init];
    if (self) {
        self.productName = productName;
        self.productUrl = [NSURL URLWithString:productUrl];
        self.imageName = imageName;
        return self;
    }
    return nil;
}

@end
