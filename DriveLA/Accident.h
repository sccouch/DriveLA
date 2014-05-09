//
//  Accident.h
//  DriveLA
//
//  Created by Jack Okerman on 5/6/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Accident : NSObject <NSCoding>

@property NSString *name;
@property NSString *streetAddress;
@property NSString *city;
@property NSString *state;
@property NSString *zipcode;
@property NSString *email;
@property NSString *driverPhone;
@property NSString *insuranceCompany;
@property NSString *policyNumber;
@property NSString *make;
@property NSString *model;
@property NSString *plateNumber;
@property NSString *insurancePhone;

@property NSString *date;

@end
