//
//  DLAAccidentDetailsViewController.h
//  DriveLA
//
//  Created by Kalyn Nakano on 5/8/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "DLACoreDataStore.h"
#import "Accident.h"

@interface DLAAccidentDetailsViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) NSIndexPath *index;
@property (weak, nonatomic) Accident *accident;

@end
