//
//  ViewController.m
//  Runner
//
//  Created by Allen Van on 10/19/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize CLController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLController = [[CoreLocationController alloc] init];
    CLController.speedDelegate = self;
    [CLController.speedManager startUpdatingLocation];
    
    _startRun.layer.cornerRadius = _startRun.bounds.size.width/2;
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController)
    {
        [self.menuButton setTarget: self.revealViewController];
        [self.menuButton setAction: @selector( revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    [self.locationManager requestWhenInUseAuthorization];
    self.map.showsUserLocation = YES;
    [self.map setUserTrackingMode:MKUserTrackingModeFollow animated: YES];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startRun:(id)sender {
    self.seconds = 0;
    self.distance = 0;
    if(self.timer){
        [self.timer invalidate];
        self.timer = nil;
    }
    UIButton *button = (UIButton *) sender;
    if(button.isSelected == NO){
        button.selected = YES;
        
        _startRun.backgroundColor = UIColor.redColor;
        [self.startRun setTitle:@"Stop Run" forState:UIControlStateNormal];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(eachSecond) userInfo:nil repeats:YES];
    }
    else{
        self.timer = nil;
        button.selected = NO;
        _startRun.backgroundColor = [UIColor colorWithRed: 0.0f green: 0.666667f blue: 0.0428568f alpha:1.0];
        [self.startRun setTitle:@"Start Run" forState:UIControlStateNormal];
    }
}

//******Sets label in storyboard to device location******//
-(void) locationUpdate:(CLLocation*) location {
    locationLabel.text = @(location.speed).stringValue;
}
//******Sets label to error if an error occurs******//
-(void) locationError:(NSError *)error{
    locationLabel.text = @"Speed Unavailable";
}

//******Used in timer to calculate seconds/minutes******//
-(void) eachSecond{
    self.seconds++;
    self.timeLabel.text = [NSString stringWithFormat:@"%@", [self stringifySecondCount:self.seconds usingLongFormat:NO]];
}

//******Formats the timer according to how long the run is******//
-(NSString*) stringifySecondCount:(int)seconds usingLongFormat:(BOOL)longFormat{
    int remainingSeconds = seconds;
    int hours = remainingSeconds/3600;
    remainingSeconds = remainingSeconds - hours * 3600;
    int minutes = remainingSeconds/60;
    remainingSeconds = remainingSeconds - minutes * 60;
    
    if(longFormat){
        if(hours > 0){
            return [NSString stringWithFormat:@"%ihr %imin %isec", hours, minutes, remainingSeconds];
        }
        else if(minutes > 0){
            return [NSString stringWithFormat:@"%imin %isec", minutes, remainingSeconds];
        }
        else{
            return [NSString stringWithFormat:@"%isec", remainingSeconds];
        }
    }
    else{
        if(hours > 0){
            return [NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, remainingSeconds];
        }
        else if (minutes > 0){
            return [NSString stringWithFormat:@"%02i:%02i", minutes, remainingSeconds];
        }
        else{
            return [NSString stringWithFormat:@"00:%02i", remainingSeconds];
        }
    }
}

@end
