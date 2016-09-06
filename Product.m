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

- (instancetype)initWithProductName:(NSString *)productName andUrl:(NSString *)productUrl andImageName:(NSString *)imageName toCompany:(int)companyId {
    self = [super init];
    if (self) {
        _productName = [productName retain];
        
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        NSURL *documentsURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
//        NSURL *fileURL = [documentsURL URLByAppendingPathComponent:productName];
//        NSString *fileUrlString = [fileURL absoluteString];
        UIImage *logoImage = [UIImage imageNamed:imageName];
        if (logoImage == nil) {
            [[DAO sharedInstance] downloadImageUrl:imageName andName:productName];
        }
        
        _productUrl = [productUrl retain];
        _imageName = [imageName retain];
        _companyId = companyId;
        return self;
    }
    return nil;
}

@end
