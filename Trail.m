//

//  Trail.m

//  Runner

//

//  Created by Stuart Millner on 11/28/15.

//  Copyright © 2015 Group9. All rights reserved.

//



#import "Trail.h"



@implementation Trail





-(id) init

{
    
    self.locations = [[NSMutableArray alloc] init];
    
    return self;
    
}



-(id)initWithName:(NSString*) name andRun:(PFObject*) run andLocations:(NSArray *)locations

{
    
    self.trailName = name;
    
    [self updateInformationWithRun:run];
    
    [self calculateCoordinatesUsingLocations:locations];
    
    return self;
    
}



-(id) initializeWithTrailFromParse:(PFObject*) trail

{
    
    self.trailName = trail[@"trailName"];
    
    self.runID = trail[@"runID"];
    
    self.distance = [trail[@"distance"] doubleValue];
    
    self.latitude = [trail[@"latitude"] floatValue];
    
    self.longitude = [trail[@"longitude"]floatValue];
    
    [self initializeLocationsFromRun:self.runID];
    
    return self;
    
}



-(void) initializeLocationsFromRun:(NSString*) runID

{
    
    self.locations = [[NSMutableArray alloc] init];
    
    PFQuery* locationQuery = [PFQuery queryWithClassName:@"Location"];
    
    [locationQuery whereKey:@"run" equalTo:runID];
    
    [locationQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        [self.locations addObjectsFromArray:objects];
        
    }];
    
}

-(void) calculateCoordinatesUsingLocations:(NSArray*) locations

{
    
    float averageLatitude = 0;
    
    float averageLongitude =0;
    
    for (PFObject* nextLocation in locations)
        
    {
        
        averageLatitude += [[nextLocation objectForKey:@"latitude"] floatValue];
        
        averageLongitude += [[nextLocation objectForKey:@"longitude"] floatValue];
        
    }
    
    averageLatitude /= locations.count;
    
    averageLongitude /= locations.count;
    
    self.latitude = averageLatitude;
    
    self.longitude = averageLongitude;
    
}



-(void) updateInformationWithRun:(PFObject*) run

{
    
    self.runID = [run objectId];
    
    self.distance = [[run objectForKey:@"distance"] floatValue];
    
}



-(BOOL) saveTrailToParse

{
    
    if (self.trailName != nil && self.runID != nil && self.distance > 0 && CLLocationCoordinate2DIsValid(CLLocationCoordinate2DMake(self.latitude, self.longitude)))
        
    {
        
        PFObject *trail = [PFObject objectWithClassName:@"trail"];
        
        trail[@"trailName"] = self.trailName;
        
        trail[@"runID"] = self.runID;
        
        trail[@"distance"]= @(self.distance);
        
        trail[@"latitude"] = @(self.latitude);
        
        trail[@"longitude"] = @(self.longitude);
        
        [trail saveInBackground];
        
        return true;
        
    }
    
    else
        
    {
        
        return false;
        
    }
    
    
    
}



-(BOOL) doesRunMatchThisTrail:(Run*) runToCheck

{
    
    
    
    
    
    NSArray* sortedTrailLocations = [self.locations sortedArrayUsingComparator:^NSComparisonResult(id a, id b)
                                     
                                     {
                                         
                                         double firstLatitude = [(CLLocation*) a coordinate].latitude;
                                         
                                         double firstLongitude =[(CLLocation*) a coordinate].longitude;
                                         
                                         double secondLatutde = [(CLLocation*) b coordinate].latitude;
                                         
                                         double secondLongitude = [(CLLocation*) b coordinate].longitude;
                                         
                                         
                                         
                                         if (firstLatitude > secondLatutde || (firstLatitude == secondLatutde && firstLongitude > secondLongitude))
                                             
                                         {
                                             
                                             return NSOrderedDescending;
                                             
                                         }
                                         
                                         else
                                             
                                         {
                                             
                                             return NSOrderedAscending;
                                             
                                         }
                                         
                                     }];
    
    
    
    for (CLLocation* runLocation in runToCheck.locations)
        
    {
        
        NSRange searchRange = NSMakeRange(0, sortedTrailLocations.count);
        
        NSUInteger findIndex = [sortedTrailLocations indexOfObject:runLocation inSortedRange:searchRange options:NSBinarySearchingFirstEqual usingComparator:^(id object1, id object2)
                                
                                {
                                    
                                    CLLocation* firstLocation = (CLLocation*) object1;
                                    
                                    CLLocation* secondLocation = (CLLocation*) object2;
                                    
                                    if ([firstLocation distanceFromLocation:secondLocation] < 1)
                                        
                                    {
                                        
                                        return NSOrderedSame;
                                        
                                    }else
                                        
                                    {
                                        
                                        if ([firstLocation coordinate].latitude > [secondLocation coordinate].latitude || ([firstLocation coordinate].latitude == [secondLocation coordinate].latitude && [firstLocation coordinate].longitude > [secondLocation coordinate].longitude))
                                            
                                        {
                                            
                                            return NSOrderedDescending;
                                            
                                        }
                                        
                                        else
                                            
                                        {
                                            
                                            return NSOrderedAscending;
                                            
                                        }
                                        
                                        
                                        
                                    }
                                    
                                }];
        
        
        
        if (findIndex >= sortedTrailLocations.count)
            
        {
            
            return false;
            
        }
        
    }
    
    return true;
    
}







@end

