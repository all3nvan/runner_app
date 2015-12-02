//
//  SidebarTableViewController.m
//  Runner
//
//  Created by Yassir Jamal on 10/28/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "SidebarTableViewController.h"
#import "SWRevealViewController.h"
#import "ViewController.h"
#import "LoginViewController.h"
#import "ProfileViewController.h"


@interface SidebarTableViewController ()

 

@end


@implementation SidebarTableViewController {
    NSArray *menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuOptions.delegate = self;
    self.menuOptions.dataSource = self;
    menuItems = @[@"home", @"logout", @"history", @"settings", @"profile"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//******Log out current user******//
-(IBAction)logout:(id) sender{
    [PFUser logOut];
    if(![PFUser currentUser]){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
        LoginViewController* loginView = [[LoginViewController alloc]init];
        loginView.delegate = self;
        loginView.signUpController.delegate = self;
        [self presentViewController:loginView animated:YES completion:nil];
}

//******Segue to History******//
-(IBAction) showHistory:(id) sender{
    if([PFUser currentUser]){
        [self performSegueWithIdentifier:@"historySegue" sender:nil];
    }else{
        [self userNotLoggedIn];
    }
}

//******Segue to Settings******//
-(IBAction) showSettings:(id) sender{
    if([PFUser currentUser]){
        [self performSegueWithIdentifier:@"settingsSegue" sender:nil];
    }
    else{
        [self userNotLoggedIn];
    }
}

//******Segue to Home******//
-(IBAction) showHome:(id) sender{
    [self performSegueWithIdentifier:@"homeSegue" sender:nil];
}

//******Segue to Profile******//
-(IBAction) showProfile:(id) sender{
    if([PFUser currentUser]){
        [self performSegueWithIdentifier:@"profileSegue" sender:nil];
    }
    else{
        [self userNotLoggedIn];
    }
}

//******Displays an alert if a user is not logged in******//
-(void) userNotLoggedIn{
    UIAlertController* invalidUser = [UIAlertController alertControllerWithTitle:@"Error" message:@"Not logged in as a valid user." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [invalidUser dismissViewControllerAnimated:YES completion:nil];
                             LoginViewController* loginView = [[LoginViewController alloc]init];
                             loginView.delegate = self;
                             loginView.signUpController.delegate = self;
                             [self presentViewController:loginView animated:YES completion:nil];
                         }];
    [invalidUser addAction:ok];
    [self presentViewController:invalidUser animated:YES completion:nil];
}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return menuItems.count;//menuItems.count;
}

//******Handles actions for separate buttons in cells******//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UIButton *objectOfButton = (UIButton*)[cell viewWithTag:200];
    [objectOfButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *showHomeButton = (UIButton*)[cell viewWithTag: 1];
    [showHomeButton addTarget:self action:@selector(showHome) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *showSettingsButton = (UIButton*)[cell viewWithTag:2];
    [showSettingsButton addTarget:self action:@selector(showSettings) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *showHistoryButton = (UIButton*)[cell viewWithTag: 3];
    [showHistoryButton addTarget:self action:@selector(showHistory) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *showProfileButton = (UIButton*) [cell viewWithTag:4];
    [showProfileButton addTarget:self action:@selector(showProfile) forControlEvents:UIControlEventTouchUpInside];
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"profileSegue"]) {
        UINavigationController *navController = segue.destinationViewController;
        ProfileViewController *profileController = [navController childViewControllers].firstObject;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath
//                             animated:true];
    NSLog(@"%@", indexPath);

}



@end
