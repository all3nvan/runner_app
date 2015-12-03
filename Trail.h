//

//  Trail.h

//  Runner

//

//  Created by Stuart Millner on 11/28/15.

//  Copyright © 2015 Group9. All rights reserved.

//



#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

#import <Parse/Parse.h>

#import "Run.h"

@interface Trail : NSObject



@property  NSString* trailName;

@property double distance;

@property float latitude;

@property float longitude;

@property NSMutableArray* locations;

@property NSString* runID;



-(id) initWithName:(NSString*) name andRun:(PFObject*) run andLocations:(NSArray*) locations;

-(id) initializeWithTrailFromParse:(PFObject*) trail;

-(BOOL) doesRunMatchThisTrail:(Run*) runToCheck;

-(void) updateInformationWithRun:(PFObject*) run;

-(BOOL) saveTrailToParse;

@end

