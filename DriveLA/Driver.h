//
//  Driver.h
//  DriveLA
//
//  Created by Jack Okerman on 5/7/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Driver : NSManagedObject

@property (nonatomic, retain) NSString * addressCity;
@property (nonatomic, retain) NSString * addressState;
@property (nonatomic, retain) NSString * addressStreet;
@property (nonatomic, retain) NSString * addressZipcode;
@property (nonatomic, retain) NSDate * driversLicenseExpirationDate;
@property (nonatomic, retain) NSString * driversLicenseNumber;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * insuranceCompany;
@property (nonatomic, retain) NSString * insurancePhone;
@property (nonatomic, retain) NSString * insurancePolicyNumber;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * licensePlateNumber;
@property (nonatomic, retain) NSString * middleInitial;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * suffix;
@property (nonatomic, retain) NSString * vehicleColor;
@property (nonatomic, retain) NSString * vehicleMake;
@property (nonatomic, retain) NSString * vehicleModel;
@property (nonatomic, retain) NSDate * vehicleYear;
@property (nonatomic, retain) NSData * accidents;

- (NSString *) getFullName;
- (NSString *) getAddress;
- (BOOL) driversLicenseAdded;
- (BOOL) insuranceInfoAdded;
- (BOOL) vehicleInfoAdded;
- (BOOL) allDocumentsAdded;

@end
