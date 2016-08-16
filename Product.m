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
        
        NSURL *url = [NSURL URLWithString:productUrl];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        NSURLSessionTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"downloadTaskWithRequest failed: %@", error);
                return;
            }
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSURL *documentsURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
            NSURL *fileURL = [documentsURL URLByAppendingPathComponent:self.productName];
            NSLog(@"%@", fileURL);
            NSError *moveError;
            if (![fileManager moveItemAtURL:location toURL:fileURL error:&moveError]) {
                NSLog(@"moveItemAtURL failed: %@", moveError);
                return;
            }
        }];
        [downloadTask resume];
        
        self.productUrl = [NSURL URLWithString:productUrl];
        self.imageName = imageName;
        return self;
    }
    return nil;
}

@end
