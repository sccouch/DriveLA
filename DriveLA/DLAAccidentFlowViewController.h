//
//  DLAAccidentFlowViewController.h
//  DriveLA
//
//  Created by Sam Couch on 4/16/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLAAccidentFlowViewController : UIViewController

typedef enum {
    accidentFlowVehiclesInvolved,
    accidentFlowYourVehicle,
    accidentFlowAnotherVehicle,
    accidentFlowOtherVehiclesDamaged,
    accidentFlowWitnesses,
    accidentFlowPictures
} accidentFlowState;

@property accidentFlowState state;

@end
