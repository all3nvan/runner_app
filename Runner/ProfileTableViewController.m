//
//  ProfileTableViewController.m
//  Runner
//
//  Created by Myke on 12/2/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "ProfileCell.h"

@interface ProfileTableViewController ()

@end

@implementation ProfileTableViewController {
    NSArray *profileAttributes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    profileAttributes = [[NSArray alloc] init];
    [self populateProfileData];
    
    
}


- (void) populateProfileData {
    
//    //join date
//    NSDate *joinDate = [[PFUser currentUser] createdAt];
//    [self.joinLabel setText:[NSString stringWithFormat:@"Join Date: %@", joinDate]];
//    
//    
//    PFQuery *query = [PFQuery queryWithClassName:@"Run"];
//    [query whereKey:@"user" equalTo:[PFUser currentUser]];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            NSMutableArray *runs = [[NSMutableArray alloc] init];
//            
//            for (PFObject *object in objects) {
//                [runs addObject:object];
//            }
//            
//            runHistory = [[NSArray alloc] initWithArray:runs];
//            
//            //number of runs
//            numberOfRuns = 0;
//            numberOfRuns = runHistory.count;
//            [self.numOfRuns setText:[NSString stringWithFormat:@"Number of Runs: %ld", numberOfRuns]];
//            
//            
//            calBurned = 0;
//            totalDistance = 0;
//            duration = 0;
//            float topSpeed = 0;
//            
//            for(int i = 0; i < runHistory.count; i++) {
//                PFObject *currentRun = [runHistory objectAtIndex:i];
//                
//                float speed = ([[currentRun objectForKey:@"distance"] floatValue] / [[currentRun objectForKey:@"duration"] floatValue]);
//                
//                if(topSpeed < speed) {
//                    topSpeed = speed;
//                }
//                
//                if([currentRun objectForKey:@"caloriesBurned"] != nil) {
//                    calBurned += [[currentRun objectForKey:@"caloriesBurned"] floatValue];
//                }
//                
//                if([currentRun objectForKey:@"caloriesBurned"] != nil) {
//                    totalDistance += [[currentRun objectForKey:@"distance"] floatValue];
//                }
//                
//                if([currentRun objectForKey:@"duration"] != nil) {
//                    duration += [[currentRun objectForKey:@"duration"] floatValue];
//                }
//            }
//            
//            [self.topSpeedLabel setText:[NSString stringWithFormat:@"Top Speed: %.2f meters per second", topSpeed]];
//            [self.avgCaloriesLabel setText:[NSString stringWithFormat:@"Average Calories Burned: %.2f per run", (calBurned /numberOfRuns)]];
//            [self.avgDistanceLabel setText:[NSString stringWithFormat:@"Average Distance: %.2f per run", (totalDistance / numberOfRuns)]];
//            [self.distanceLabel setText:[NSString stringWithFormat:@"Total Distance: %.2f meters", totalDistance]];
//            [self.totalCalories setText:[NSString stringWithFormat:@"Calories Burned: %.2f kcals", calBurned]];
//            
//            
//            
//            
//        } else {
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
