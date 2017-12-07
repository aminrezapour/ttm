//
//  ProfileTableViewCell.swift
//  Twitter07
//
//  Created by Amin Rezapour on 11/18/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

protocol ProfileCellDelegate {
    func featureButtonWasPressed(for cell: ProfileTableViewCell)
}

class ProfileTableViewCell: UITableViewCell {
   
    @IBOutlet weak var featuredButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    var delegate : ProfileCellDelegate?
    var user : User?
    
    func setupCell(with user: User) {
        self.user = user
        self.nameLabel.text = user.name
        
        self.profileImage.image = UIImage(named: user.photo)
        self.profileImage.layer.cornerRadius = 30.0
        self.profileImage.clipsToBounds = true
        
        if user.featured {
            self.featuredButton.setImage(UIImage(named: "star-fill"), for: .normal)
        } else {
            self.featuredButton.setImage(UIImage(named: "star-empty"), for: .normal)
        }
        
    }

    @IBAction func featuredButtonPressed(_ sender: Any) {
        self.delegate?.featureButtonWasPressed(for: self)
    }

}
