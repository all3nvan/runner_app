//
//  CalorieCalculator.h
//  Runner
//
//  Created by Stuart Millner on 11/12/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalorieCalculator : NSObject

@property double caloriesBurned;

-(id) calculateWithWeight: (float)weight andDistance:(float)distance andAverageSpeed:(float)avgspeed;

-(NSString*) comparisonForCaloriesBurned;
@end
