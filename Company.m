//
//  Company.m
//  NavCtrl
//
//  Created by Olivia Taylor on 8/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

- (instancetype)initWithCompanyName:(NSString *)companyName andLogo:(UIImage *)companyLogo {
    self = [super init];
    if (self) {
        self.companyName = companyName;
        self.companyLogo = companyLogo;
        self.products = [[NSMutableArray alloc] init];
        return self;
    }
    return nil;
}

@end
