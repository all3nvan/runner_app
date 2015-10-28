//
//  CoreLocationController.h
//  Runner
//
//  Created by abc on 10/27/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol CoreLocationControllerDelegate

@required
-(void) locationUpdate:(CLLocation*) location;
-(void) locationError:(NSError*) error;

@end

@interface CoreLocationController : NSObject <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *speedManager;
@property (nonatomic, assign) id speedDelegate;

@end
