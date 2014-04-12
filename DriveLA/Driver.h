//
//  Driver.h
//  DriveLA
//
//  Created by Jack Okerman on 4/12/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Driver : NSManagedObject

@property (nonatomic, retain) NSDate * driversLicenseExpirationDate;
@property (nonatomic, retain) NSString * driversLicenseNumber;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * middleInitial;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * suffix;

- (NSString *) getFullName;

@end
