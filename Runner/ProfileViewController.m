//
//  ProfileViewController.m
//  Runner
//
//  Created by Yassir Jamal on 11/18/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "ProfileViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController
{
    NSArray *runHistory;
    float calBurned;
    long numberOfRuns;
    float totalDistance;
    float duration;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    //    if (revealViewController)
    //    {
    [self.menuButton setTarget: revealViewController];
    [self.menuButton setAction: @selector( revealToggle:)];
    [self.view addGestureRecognizer:revealViewController.panGestureRecognizer];
    //    }
    
    [self getUsername];
    [self populateProfileData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getUsername {
    [self.welcomeLabel setText:[NSString stringWithFormat:@"Welcome, %@!", [[PFUser currentUser] username]]];
}

- (void) populateProfileData {
    
    //join date
    NSDate *joinDate = [[PFUser currentUser] createdAt];
    [self.joinLabel setText:[NSString stringWithFormat:@"Join Date: %@", joinDate]];
  
    
    PFQuery *query = [PFQuery queryWithClassName:@"Run"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSMutableArray *runs = [[NSMutableArray alloc] init];
            
            for (PFObject *object in objects) {
                [runs addObject:object];
            }
            
            runHistory = [[NSArray alloc] initWithArray:runs];
            
            //number of runs
            numberOfRuns = 0;
            numberOfRuns = runHistory.count;
            [self.numOfRuns setText:[NSString stringWithFormat:@"Number of Runs: %ld", numberOfRuns]];
            
            
            calBurned = 0;
            totalDistance = 0;
            duration = 0;
            float topSpeed = 0;
            
            for(int i = 0; i < runHistory.count; i++) {
                PFObject *currentRun = [runHistory objectAtIndex:i];
                
                float speed = ([[currentRun objectForKey:@"distance"] floatValue] / [[currentRun objectForKey:@"duration"] floatValue]);
                
                if(topSpeed < speed) {
                    topSpeed = speed;
                }
                
                if([currentRun objectForKey:@"caloriesBurned"] != nil) {
                    calBurned += [[currentRun objectForKey:@"caloriesBurned"] floatValue];
                }
                
                if([currentRun objectForKey:@"caloriesBurned"] != nil) {
                    totalDistance += [[currentRun objectForKey:@"distance"] floatValue];
                }
                
                if([currentRun objectForKey:@"duration"] != nil) {
                    duration += [[currentRun objectForKey:@"duration"] floatValue];
                }
            }
            
            [self.topSpeedLabel setText:[NSString stringWithFormat:@"Top Speed: %.2f meters per second", topSpeed]];
            [self.avgCaloriesLabel setText:[NSString stringWithFormat:@"Average Calories Burned: %.2f per run", (calBurned /numberOfRuns)]];
            [self.avgDistanceLabel setText:[NSString stringWithFormat:@"Average Distance: %.2f per run", (totalDistance / numberOfRuns)]];
            [self.distanceLabel setText:[NSString stringWithFormat:@"Total Distance: %.2f meters", totalDistance]];
            [self.totalCalories setText:[NSString stringWithFormat:@"Calories Burned: %.2f kcals", calBurned]];
            
            
            
            
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
