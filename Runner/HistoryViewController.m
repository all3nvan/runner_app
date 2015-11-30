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
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
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
    
    UILabel *time = (UILabel*)[cell viewWithTag:1];
    time.text = [currentRun objectForKey:@"distance"];
    
    return cell;
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
