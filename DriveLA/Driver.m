//
//  Driver.m
//  DriveLA
//
//  Created by Jack Okerman on 4/15/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "Driver.h"

@implementation Driver

@dynamic driversLicenseExpirationDate;
@dynamic driversLicenseNumber;
@dynamic email;
@dynamic firstName;
@dynamic insuranceCompany;
@dynamic insurancePhone;
@dynamic insurancePolicyNumber;
@dynamic lastName;
@dynamic licensePlateNumber;
@dynamic middleInitial;
@dynamic phone;
@dynamic suffix;
@dynamic vehicleColor;
@dynamic vehicleMake;
@dynamic vehicleModel;
@dynamic vehicleYear;
@dynamic addressStreet;
@dynamic addressCity;
@dynamic addressState;
@dynamic addressZipcode;

- (NSString *) getFullName {
    
    NSString *fullname = @"";
    
    if (self.firstName && ![self.firstName isEqualToString:@""])
        fullname = [NSString stringWithFormat:@"%@%@", fullname, self.firstName];
    if (self.middleInitial && ![self.middleInitial isEqualToString:@""])
        fullname = [NSString stringWithFormat:@"%@ %@", fullname, self.middleInitial];
    if (self.lastName && ![self.firstName isEqualToString:@""])
        fullname = [NSString stringWithFormat:@"%@ %@", fullname, self.lastName];
    if (self.suffix && ![self.suffix isEqualToString:@""])
        fullname = [NSString stringWithFormat:@"%@ %@", fullname, self.suffix];
    
    return fullname;
}

- (NSString *) getAddress {
    
    NSString *address = @"";
    
    if (self.addressStreet && ![self.addressStreet isEqualToString:@""])
        address = [NSString stringWithFormat:@"%@%@\n", address, self.addressStreet];
    if (self.addressCity && ![self.addressCity isEqualToString:@""])
        address = [NSString stringWithFormat:@"%@%@", address, self.addressCity];
    if (self.addressState && ![self.addressState isEqualToString:@""])
        address = [NSString stringWithFormat:@"%@ %@", address, self.addressState];
    if (self.addressZipcode && ![self.addressZipcode isEqualToString:@""])
        address = [NSString stringWithFormat:@"%@ %@", address, self.addressZipcode];
    
    return address;
}

@end
