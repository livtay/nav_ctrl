//
//  ProductCell.m
//  NavCtrl
//
//  Created by Olivia Taylor on 9/8/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_cellProductImage release];
    [_cellProductName release];
    [super dealloc];
}
@end
