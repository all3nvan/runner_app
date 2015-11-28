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

-(id) initWithRunDetailsOfWeight: (float)weight andDistance:(float)distance andAverageSpeed:(float)avgspeed isImperial:(BOOL) isImperial;

-(id) initWithCaloriesBurned:(double)caloriesBurned;
-(NSString*) comparisonForCaloriesBurned;
+(NSDictionary*) foodComparisons;
@end
