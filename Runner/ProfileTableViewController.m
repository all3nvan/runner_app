//
//  ProfileTableViewController.m
//  Runner
//
//  Created by Jay Brandin on 12/2/15.
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
    
    SWRevealViewController *revealViewController = self.revealViewController;
    
    [self.menuButton setTarget: revealViewController];
    [self.menuButton setAction: @selector( revealToggle:)];
    [self.view addGestureRecognizer:revealViewController.panGestureRecognizer];
    
    if(![PFUser currentUser]){
        [self userNotLoggedIn];
    }
    else{
        profileAttributes = [[NSArray alloc] init];
        [self populateProfileData];
    }
}

-(void) userNotLoggedIn{
    UIAlertController* invalidUser = [UIAlertController alertControllerWithTitle:@"Error" message:@"Not logged in as a valid user." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [invalidUser dismissViewControllerAnimated:YES completion:nil];
                         }];
    [invalidUser addAction:ok];
    [self presentViewController:invalidUser animated:YES completion:nil];
}

- (void) populateProfileData {
    PFQuery *query = [PFQuery queryWithClassName:@"Run"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSMutableArray *runs = [[NSMutableArray alloc] init];
            
            for (PFObject *object in objects) {
                [runs addObject:object];
            }
            
            NSDate *joinDate = [[PFUser currentUser] createdAt];
            
            long numberOfRuns = 0;
            float calBurned = 0.0;
            float totalDistance = 0.0;
            float duration = 0.0;
            float topSpeed = 0.0;
            
            numberOfRuns = runs.count;
            
            for(int i = 0; i < runs.count; i++) {
                PFObject *currentRun = [runs objectAtIndex:i];
                
                float currentSpeed = ([[currentRun objectForKey:@"distance"] floatValue] / [[currentRun objectForKey:@"duration"] floatValue]);
                
                if(topSpeed < currentSpeed) {
                    topSpeed = currentSpeed;
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
            
            
            //here, speed is converted from meters per second into appropriate metric per HOUR...
            static float const metersInKM = 1000.0;
            static float const metersInMile = 1609.344;
            NSString *unit = @"meters";
            
            if([[NSUserDefaults standardUserDefaults] boolForKey:@"isMetric"] == YES) {
                totalDistance = totalDistance / metersInKM;
                topSpeed = (topSpeed * 60.0 * 60.0) / metersInKM;
                unit = @"kilometers";
            }
            else {
                totalDistance = totalDistance / metersInMile;
                topSpeed = (topSpeed * 60.0 * 60.0) / metersInMile;
                unit = @"miles";
            }
        

            NSMutableArray *profileData = [[NSMutableArray alloc] init];
            [profileData addObject:[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"Join Date:"], [NSString stringWithFormat:@"%@", joinDate], nil]];
            [profileData addObject:[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"Number of Runs:"], [NSString stringWithFormat:@"%ld", numberOfRuns], nil]];
            [profileData addObject:[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"Total Distance Ran:"], [NSString stringWithFormat:@"%.2f %@", totalDistance, unit], nil]];
            [profileData addObject:[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"Average Distance Per Run:"], [NSString stringWithFormat:@"%.2f %@", (totalDistance / numberOfRuns), unit], nil]];
            [profileData addObject:[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"Top Average Speed:"], [NSString stringWithFormat:@"%.2f %@ per hour", topSpeed, unit], nil]];
            [profileData addObject:[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"Total Calories Burned:"], [NSString stringWithFormat:@"%.2f kcals", calBurned], nil]];
            [profileData addObject:[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"Average Calories Burned:"], [NSString stringWithFormat:@"%.2f kcals per run", (calBurned / numberOfRuns)], nil]];
            profileAttributes = [[NSArray alloc] initWithArray:profileData];
            
            [self.tableView reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return profileAttributes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell" forIndexPath:indexPath];
    
    NSArray *rowData = [[NSArray alloc] initWithArray:[profileAttributes objectAtIndex:indexPath.row]];
    
    cell.attributeLabel.text = [[rowData objectAtIndex:0] description];
    cell.valueLabel.text = [[rowData objectAtIndex:1] description];
    
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
