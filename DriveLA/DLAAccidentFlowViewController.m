//
//  DLAAccidentFlowViewController.m
//  DriveLA
//
//  Created by Sam Couch on 4/16/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "DLAAccidentFlowViewController.h"

@interface DLAAccidentFlowViewController ()
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *centerButton;

@end

@implementation DLAAccidentFlowViewController
- (IBAction)leftButtonPressed:(id)sender {
    switch (self.state) {
        case accidentFlowVehiclesInvolved:
            self.state = accidentFlowYourVehicle;
            // yes or no
            [self reloadData];
            break;
        
        case accidentFlowYourVehicle:
            self.state = accidentFlowAnotherVehicle;
            [self reloadData];
            break;
            
        case accidentFlowAnotherVehicle:
            self.state = accidentFlowOtherVehiclesDamaged;
            [self reloadData];
            break;
            
        case accidentFlowOtherVehiclesDamaged:
            self.state = accidentFlowWitnesses;
            [self reloadData];
            break;
            
        case accidentFlowWitnesses:
            self.state = accidentFlowPictures;
            [self reloadData];
            break;
            
        case accidentFlowPictures:
            break;
            
        default:
            break;
    }
    
}

- (IBAction)rightButtonPressed:(id)sender {
    switch (self.state) {
        case accidentFlowVehiclesInvolved:
            self.state = accidentFlowYourVehicle;
            [self reloadData];
            break;
            
        default:
            break;
    }
}

- (void)reloadData {
    switch (self.state) {
        case accidentFlowVehiclesInvolved:
            self.questionLabel.text = @"How many vehicles were involved?";
            [self.leftButton setTitle:@"1" forState:UIControlStateNormal];
            [self.rightButton setTitle:@"2+" forState:UIControlStateNormal];
            break;
        
        case accidentFlowYourVehicle:{
            [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.questionLabel setText:@"Was your vehicle damaged?"];
                [self.leftButton setTitle:@"Yes" forState:UIControlStateNormal];
                [self.rightButton setTitle:@"No" forState:UIControlStateNormal];
            } completion:nil];
            
            break;
        }
            
        case accidentFlowAnotherVehicle:{
            [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.questionLabel setText:@"Was another vehicle damaged?"];
                [self.leftButton setTitle:@"Yes" forState:UIControlStateNormal];
                [self.rightButton setTitle:@"No" forState:UIControlStateNormal];
            } completion:nil];
            
            break;
        }
            
        case accidentFlowOtherVehiclesDamaged:{
            [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.questionLabel setText:@"How many other vehicles were damaged?"];
                [self.centerButton setHidden:NO];
                [self.centerButton setTitle:@"2" forState:UIControlStateNormal];
                [self.leftButton setTitle:@"3+" forState:UIControlStateNormal];
                [self.rightButton setTitle:@"1" forState:UIControlStateNormal];
            } completion:nil];
            
            break;
        }
            
        case accidentFlowWitnesses:{
            [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.questionLabel setText:@"Are there any witnesses?"];
                [self.centerButton setHidden:YES];
                [self.leftButton setTitle:@"No" forState:UIControlStateNormal];
                [self.rightButton setTitle:@"Yes" forState:UIControlStateNormal];
            } completion:nil];
            
            break;
        }
            

        default:
            break;
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.state = accidentFlowVehiclesInvolved;
    [self reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
