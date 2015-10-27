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

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *startRun;

@property NSDate *startTime;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@property (strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

