//
//  Accident.m
//  DriveLA
//
//  Created by Jack Okerman on 5/6/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "Accident.h"


@implementation Accident

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.name = [decoder decodeObjectForKey:@"name"];
    self.streetAddress = [decoder decodeObjectForKey:@"streetAddress"];
    self.city = [decoder decodeObjectForKey:@"city"];
    self.state = [decoder decodeObjectForKey:@"state"];
    self.zipcode = [decoder decodeObjectForKey:@"zipcode"];
    self.email = [decoder decodeObjectForKey:@"email"];
    self.driverPhone = [decoder decodeObjectForKey:@"driverPhone"];
    self.insuranceCompany = [decoder decodeObjectForKey:@"insuranceCompany"];
    self.policyNumber = [decoder decodeObjectForKey:@"policyNumber"];
    self.make = [decoder decodeObjectForKey:@"make"];
    self.model = [decoder decodeObjectForKey:@"model"];
    self.plateNumber = [decoder decodeObjectForKey:@"plateNumber"];
    self.insurancePhone = [decoder decodeObjectForKey:@"insurancePhone"];
    self.crossStreets = [decoder decodeObjectForKey:@"crossStreets"];
    self.accidentDetails = [decoder decodeObjectForKey:@"accidentDetails"];

    
    self.date = [decoder decodeObjectForKey:@"date"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.streetAddress forKey:@"streetAddress"];
    [encoder encodeObject:self.city forKey:@"city"];
    [encoder encodeObject:self.state forKey:@"state"];
    [encoder encodeObject:self.zipcode forKey:@"zipcode"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.driverPhone forKey:@"driverPhone"];
    [encoder encodeObject:self.insuranceCompany forKey:@"insuranceCompany"];
    [encoder encodeObject:self.policyNumber forKey:@"policyNumber"];
    [encoder encodeObject:self.make forKey:@"make"];
    [encoder encodeObject:self.model forKey:@"model"];
    [encoder encodeObject:self.plateNumber forKey:@"plateNumber"];
    [encoder encodeObject:self.insurancePhone forKey:@"insurancePhone"];
    [encoder encodeObject:self.crossStreets forKey:@"crossStreets"];
    [encoder encodeObject:self.accidentDetails forKey:@"accidentDetails"];

    
    [encoder encodeObject:self.date forKey:@"date"];
    
}

@end
