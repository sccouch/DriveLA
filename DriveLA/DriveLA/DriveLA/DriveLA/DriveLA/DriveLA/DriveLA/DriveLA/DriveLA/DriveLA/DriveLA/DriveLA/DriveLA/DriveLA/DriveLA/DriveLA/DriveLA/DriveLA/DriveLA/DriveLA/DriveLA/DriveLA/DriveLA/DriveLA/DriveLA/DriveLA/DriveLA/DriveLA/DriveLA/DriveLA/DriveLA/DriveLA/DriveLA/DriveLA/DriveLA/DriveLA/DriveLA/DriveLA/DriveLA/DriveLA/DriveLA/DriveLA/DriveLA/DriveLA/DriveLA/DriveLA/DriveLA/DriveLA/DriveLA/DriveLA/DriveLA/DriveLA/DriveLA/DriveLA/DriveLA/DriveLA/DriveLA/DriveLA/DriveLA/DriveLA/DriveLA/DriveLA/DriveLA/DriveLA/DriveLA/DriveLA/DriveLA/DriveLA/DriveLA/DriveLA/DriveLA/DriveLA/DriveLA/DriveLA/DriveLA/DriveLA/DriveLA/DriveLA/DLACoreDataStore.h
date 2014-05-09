//
//  DLACoreDataStore.h
//  DriveLA
//
//  Created by Jack Okerman on 4/7/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Driver.h"

@interface DLACoreDataStore : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (Driver *)fetchDriver;
- (void)updateDriverInfo:(NSDictionary *)info;

+ (DLACoreDataStore *)sharedStore;
@end
