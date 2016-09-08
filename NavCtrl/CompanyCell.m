//
//  CompanyCell.m
//  NavCtrl
//
//  Created by Olivia Taylor on 9/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "CompanyCell.h"

@implementation CompanyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_cellCompanyLogo release];
    [_cellCompanyName release];
    [_cellCompanyStockPrice release];
    [super dealloc];
}
@end
