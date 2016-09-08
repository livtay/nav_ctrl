//
//  CompanyCell.h
//  NavCtrl
//
//  Created by Olivia Taylor on 9/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *cellCompanyLogo;
@property (retain, nonatomic) IBOutlet UILabel *cellCompanyName;
@property (retain, nonatomic) IBOutlet UILabel *cellCompanyStockPrice;

@end
