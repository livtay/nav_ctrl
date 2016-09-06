//
//  ManagedCompany+CoreDataProperties.h
//  NavCtrl
//
//  Created by Olivia Taylor on 9/1/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ManagedCompany.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManagedCompany (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *companyId;
@property (nullable, nonatomic, retain) NSString *companyLogo;
@property (nullable, nonatomic, retain) NSString *companyName;
@property (nullable, nonatomic, retain) NSString *stockSymbol;
@property (nullable, nonatomic, retain) NSSet<ManagedProduct *> *products;

@end

@interface ManagedCompany (CoreDataGeneratedAccessors)

- (void)addProductsObject:(ManagedProduct *)value;
- (void)removeProductsObject:(ManagedProduct *)value;
- (void)addProducts:(NSSet<ManagedProduct *> *)values;
- (void)removeProducts:(NSSet<ManagedProduct *> *)values;

@end

NS_ASSUME_NONNULL_END
