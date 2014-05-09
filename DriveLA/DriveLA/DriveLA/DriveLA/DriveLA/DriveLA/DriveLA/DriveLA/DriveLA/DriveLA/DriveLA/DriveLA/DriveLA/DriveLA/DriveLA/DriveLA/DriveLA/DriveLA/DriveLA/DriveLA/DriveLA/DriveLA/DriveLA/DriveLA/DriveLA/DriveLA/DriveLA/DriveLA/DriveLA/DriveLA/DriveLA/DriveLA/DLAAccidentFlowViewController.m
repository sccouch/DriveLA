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
        case accidentFlowAskCall911:
            self.state = accidentFlowCall911;
            [self reloadData];
            break;
        
        case accidentFlowCall911:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:12125551212"]];
            [self performSegueWithIdentifier:@"AccidentEntry" sender:self];
            break;
            
        case accidentFlowAskCallNonEmergency:
            self.state = accidentFlowCallNonEmergency;
            [self reloadData];
            break;
            
        case accidentFlowCallNonEmergency:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:12125551212"]];
            [self performSegueWithIdentifier:@"AccidentEntry" sender:self];
            break;
            
        default:
            break;
    }
    
}

- (IBAction)rightButtonPressed:(id)sender {
    switch (self.state) {
        case accidentFlowAskCall911:
            self.state = accidentFlowAskCallNonEmergency;
            [self reloadData];
            break;
            
        case accidentFlowCall911:
            self.state = accidentFlowAskCallNonEmergency;
            [self reloadData];
            break;
            
        case accidentFlowAskCallNonEmergency:
            [self performSegueWithIdentifier:@"AccidentEntry" sender:self];
            break;
            
        case accidentFlowCallNonEmergency:
            [self performSegueWithIdentifier:@"AccidentEntry" sender:self];
            break;
            
        default:
            break;
    }
}

- (void)reloadData {
    switch (self.state) {
        case accidentFlowAskCall911:
            self.questionLabel.text = @"Is anybody hurt or any driver intoxicated?";
            [self.leftButton setTitle:@"Yes" forState:UIControlStateNormal];
            [self.rightButton setTitle:@"No" forState:UIControlStateNormal];
            break;
            
        case accidentFlowCall911:
            self.questionLabel.text = @"It is recommended that you call 911.";
            [self.leftButton setTitle:@"Call 911" forState:UIControlStateNormal];
            //[self.leftButton sizeToFit];
            [self.rightButton setTitle:@"Ok" forState:UIControlStateNormal];
            break;
        
        case accidentFlowAskCallNonEmergency:
            self.questionLabel.text = @"Was there a hit and run, an unlicensed driver, or damage to city property?";
            [self.leftButton setTitle:@"Yes" forState:UIControlStateNormal];
            [self.rightButton setTitle:@"No" forState:UIControlStateNormal];
            break;
            
        case accidentFlowCallNonEmergency:
            self.questionLabel.text = @"It is recommended that you call the LAPD non-emergency number to file a police report.";
            [self.leftButton setTitle:@"Call LAPD" forState:UIControlStateNormal];
            //[self.leftButton sizeToFit];
            [self.rightButton setTitle:@"Ok" forState:UIControlStateNormal];
            break;
            
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
    self.state = accidentFlowAskCall911;
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
