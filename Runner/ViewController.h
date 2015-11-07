//
//  ViewController.h
//  Runner
//
//  Created by Allen Van on 10/19/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "CoreLocationController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "Run.h"
#import "LoginViewController.h"
@interface ViewController : UIViewController <UIActionSheetDelegate, CLLocationManagerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>{
    CoreLocationController* CLController;
    IBOutlet UILabel *locationLabel;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *startRun;

@property NSDate *startTime;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@property (strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, retain) CoreLocationController* CLController;

@property int seconds;
@property float distance;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) NSTimer* timer;

@property Run* run;

@property (weak, nonatomic) IBOutlet UILabel *distLabel;
@property (weak, nonatomic) IBOutlet UILabel *paceLabel;

@property (strong, nonatomic) UIColor *color;

@end

