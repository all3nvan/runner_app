//

//  TrailTableViewCell.swift

//  Runner

//

//  Created by Stuart Millner on 12/2/15.

//  Copyright © 2015 Group9. All rights reserved.

//



import UIKit



class TrailTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var title: UILabel!
    
    
    
    @IBOutlet weak var trailLength: UILabel!
    
    
    
    @IBOutlet weak var distanceToTrail: UILabel!
    
    
    
    @IBOutlet weak var trailImage: UIImageView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Initialization code
        
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        
        
        // Configure the view for the selected state
        
    }
    
    
    
}

