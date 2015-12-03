//

//  TrailTableViewController.swift

//  Runner

//

//  Created by Stuart Millner on 12/2/15.

//  Copyright © 2015 Group9. All rights reserved.

//



import UIKit


class TrailTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    
    
    var trails = [PFObject]()
    
    let locationManager = CLLocationManager()
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.distanceFilter = 100;
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        PFQuery(className: "trail").findObjectsInBackgroundWithBlock({ (objects:[PFObject]?, error:NSError?) -> Void in
            
            for nextTrail in objects!
                
            {
                
                self.trails.append(nextTrail)
                
            }
            
            self.tableView.reloadData()
            
        })
        
        // Do any additional setup after loading the view.
        let revealViewController = self.revealViewController;
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.tableView.reloadData()
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    // MARK: - Table view data source
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        // #warning Incomplete implementation, return the number of sections
        
        return 1
        
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        
        return trails.count
        
    }
    
    
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("trailcell", forIndexPath: indexPath) as! TrailTableViewCell
        
        
        
        let currentTrail = trails[indexPath.row]
        
        
        
        cell.title.text = currentTrail["trailName"] as! String
        
        cell.trailLength.text = NSString(format: "Length: %.2f", currentTrail["distance"] as! Float) as String
        
        
        
        let coordinateOfTrail = CLLocation(latitude: currentTrail["latitude"] as! Double, longitude: currentTrail["longitude"] as! Double)
        
        
        
        cell.distanceToTrail.text = NSString(format: "%.2f away", coordinateOfTrail.distanceFromLocation(locationManager.location!)) as String
        
        
        
        let query = PFQuery(className: "Run")
        
        do
            
        {
            
            let run = try query.getObjectWithId(currentTrail["runID"] as! String)
            
            
            
            let thumbnail = run["image"] as! PFFile
            
            
            
            let imageData = try thumbnail.getData()
            
            cell.imageView?.image = UIImage(data:imageData)
            
        }
            
        catch
            
        {
            
            
            
        }
        
        
        
        
        
        
        
        return cell
        
    }
    
    
    
    
    
    /*
    
    // Override to support conditional editing of the table view.
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    
    // Return false if you do not want the specified item to be editable.
    
    return true
    
    }
    
    */
    
    
    
    /*
    
    // Override to support editing the table view.
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
    if editingStyle == .Delete {
    
    // Delete the row from the data source
    
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    
    } else if editingStyle == .Insert {
    
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    
    }
    
    }
    
    */
    
    
    
    /*
    
    // Override to support rearranging the table view.
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    
    
    }
    
    */
    
    
    
    /*
    
    // Override to support conditional rearranging of the table view.
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    
    // Return false if you do not want the item to be re-orderable.
    
    return true
    
    }
    
    */
    
    
    
    /*
    
    // MARK: - Navigation
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    // Get the new view controller using segue.destinationViewController.
    
    // Pass the selected object to the new view controller.
    
    }
    
    */
    
    
    
}

