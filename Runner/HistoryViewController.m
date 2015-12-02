//
//  HistoryViewController.m
//  Runner
//
//  Created by abc on 11/28/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "HistoryViewController.h"
#import "SWRevealViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController
{
    NSArray *runHistory;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    
    [self.menuButton setTarget: revealViewController];
    [self.menuButton setAction: @selector( revealToggle:)];
    [self.view addGestureRecognizer:revealViewController.panGestureRecognizer];
    

    self.runHistoryTable.delegate = self;
    self.runHistoryTable.dataSource = self;
    
    [self getRunHistory];
}

- (void) getRunHistory {
    PFQuery *query = [PFQuery queryWithClassName:@"Run"];
    [[query whereKey:@"user" equalTo:[PFUser currentUser]] orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSMutableArray *runs = [[NSMutableArray alloc] init];
            
            for (PFObject *object in objects) {
                [runs addObject:object];
            }
            
            runHistory = [[NSArray alloc] initWithArray:runs];
            [_runHistoryTable reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return runHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"runHistoryCell" forIndexPath:indexPath];
    
    PFObject *currentRun = [runHistory objectAtIndex:indexPath.row];
    
    UILabel *date = (UILabel*)[cell viewWithTag:1];
    date.text = currentRun.createdAt.description;
    
    UILabel *distance = (UILabel*)[cell viewWithTag:2];
    distance.text = [[[currentRun objectForKey:@"distance"] description] stringByAppendingString:@" meters"];
    
    UILabel *duration = (UILabel*)[cell viewWithTag:3];
    duration.text = [[[currentRun objectForKey:@"duration"] description] stringByAppendingString:@" seconds"];
    
    UILabel *calories = (UILabel*)[cell viewWithTag:4];
    calories.text = [[currentRun objectForKey:@"caloriesBurned"] description];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
//    selectedContact = (Contact*)[contactArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"historySegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    MapViewController* mvc = [segue destinationViewController];
//    
//    mvc.contactData = selectedContact;
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
