//
//  Driver.m
//  DriveLA
//
//  Created by Jack Okerman on 4/12/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "Driver.h"


@implementation Driver

@dynamic driversLicenseExpirationDate;
@dynamic driversLicenseNumber;
@dynamic email;
@dynamic firstName;
@dynamic lastName;
@dynamic middleInitial;
@dynamic phone;
@dynamic suffix;

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

@end
