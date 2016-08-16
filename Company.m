//
//  Company.m
//  NavCtrl
//
//  Created by Olivia Taylor on 8/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

- (instancetype)initWithCompanyName:(NSString *)companyName andLogo:(NSString *)companyLogo {
    self = [super init];
    if (self) {
        self.companyName = companyName;
        
        //Download image
        //save to file with filename that matches company name
        //load images in the table view (cellforrrowatindexpath) based on the image having the same name as the company
        
        NSURL *url = [NSURL URLWithString:companyLogo];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        NSURLSessionTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"downloadTaskWithRequest failed: %@", error);
                return;
            }
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSURL *documentsURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
            NSURL *fileURL = [documentsURL URLByAppendingPathComponent:self.companyName];
            NSLog(@"%@", fileURL);
            NSError *moveError;
            if (![fileManager moveItemAtURL:location toURL:fileURL error:&moveError]) {
                NSLog(@"moveItemAtURL failed: %@", moveError);
                return;
            }
        }];
        [downloadTask resume];
        
        
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        [data writeToFile:[NSString stringWithFormat:@"%@", companyName] options:NSAtomicWrite error:nil];
        
        
        self.companyLogo = companyLogo;
        self.products = [[NSMutableArray alloc] init];
        return self;
    }
    return nil;
}

@end





