//
//  DLAAppDelegate.h
//  DriveLA
//
//  Created by Sam Couch on 3/31/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
