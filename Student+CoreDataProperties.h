//
//  Student+CoreDataProperties.h
//  CoreData
//
//  Created by apple on 15/10/9.
//  Copyright © 2015年 apple. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nonatomic) int16_t age;
@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) id color;
@property (nullable, nonatomic, retain) NSData *head;
@property (nullable, nonatomic, retain) NSSet< Book *> *books;

@end

NS_ASSUME_NONNULL_END
