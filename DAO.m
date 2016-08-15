//
//  DAO.m
//  NavCtrl
//
//  Created by Olivia Taylor on 8/11/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DAO.h"
#import "Company.h"
#import "Product.h"

@implementation DAO

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)createCompanies {
    
    Product *iPad = [[Product alloc] initWithProductName:@"iPad" andUrl:@"https://www.apple.com/ipad/" andImageName:@"apple.png"];
    Product *iPodTouch = [[Product alloc] initWithProductName:@"iPod Touch" andUrl:@"https://www.apple.com/ipod-touch/" andImageName:@"apple.png"];
    Product *iPhone = [[Product alloc] initWithProductName:@"iPhone" andUrl:@"https://www.apple.com/iphone/" andImageName:@"apple.png"];
    Company *apple = [[Company alloc] initWithCompanyName:@"Apple mobile devices" andLogo:[UIImage imageNamed:@"apple.png"]];
    [apple.products addObjectsFromArray:@[iPad, iPhone, iPodTouch]];
    
    Product *galaxyS4 = [[Product alloc] initWithProductName:@"Galaxy S4" andUrl:@"https://www.cnet.com/products/samsung-galaxy-s4/" andImageName:@"Samsung"];
    Product *galaxyNote = [[Product alloc] initWithProductName:@"Galaxy Note" andUrl:@"https://www.cnet.com/products/samsung-galaxy-note-7-preview/" andImageName:@"Samsung"];
    Product *galaxyTab = [[Product alloc] initWithProductName:@"Galaxy Tab" andUrl:@"https://www.cnet.com/products/samsung-galaxy-tab-e/" andImageName:@"Samsung"];
    Company *samsung = [[Company alloc] initWithCompanyName:@"Samsung mobile devices" andLogo:[UIImage imageNamed:@"Samsung.png"]];
    [samsung.products addObjectsFromArray:@[galaxyS4, galaxyNote, galaxyTab]];
    
    Product *lumia1520 = [[Product alloc] initWithProductName:@"Lumia 1520" andUrl:@"https://www.microsoft.com/en-us/mobile/phone/lumia1520/" andImageName:@"Nokia2.jpg"];
    Product *lumia650 = [[Product alloc] initWithProductName:@"Lumia 650" andUrl:@"https://www.microsoft.com/en-us/mobile/es/lumia650/" andImageName:@"Nokia2.jpg"];
    Product *n1 = [[Product alloc] initWithProductName:@"N1" andUrl:@"https://www.cnet.com/products/nokia-n1/" andImageName:@"Nokia2.jpg"];
    Company *nokia = [[Company alloc] initWithCompanyName:@"Nokia mobile devices" andLogo:[UIImage imageNamed:@"Nokia2.jpg"]];
    [nokia.products addObjectsFromArray:@[lumia1520, lumia650, n1]];
    
    Product *motoZ = [[Product alloc] initWithProductName:@"Moto Z Droid" andUrl:@"https://www.motorola.com/us/products/moto-z-droid-edition" andImageName:@"motorola2.jpg"];
    Product *motoXPure = [[Product alloc] initWithProductName:@"Moto X Pure Edition" andUrl:@"https://www.motorola.com/us/products/moto-x-pure-edition" andImageName:@"motorola2.jpg"];
    Product *xoomTab = [[Product alloc] initWithProductName:@"XOOM Tablet" andUrl:@"https://www.cnet.com/products/motorola-with-wi-fi/" andImageName:@"motorola2.jpg"];
    Company *motorola = [[Company alloc] initWithCompanyName:@"Motorola mobile devices" andLogo:[UIImage imageNamed:@"motorola2.jpg"]];
    [motorola.products addObjectsFromArray:@[motoZ, motoXPure, xoomTab]];
    
    self.companyList = [[NSMutableArray alloc] initWithObjects:apple, samsung, nokia, motorola, nil];

}

@end
