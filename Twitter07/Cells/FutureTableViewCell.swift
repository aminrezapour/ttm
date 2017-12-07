//
//  FutureTableViewCell.swift
//  Twitter07
//
//  Created by Amin Rezapour on 11/18/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class FutureTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var featuredImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
    var tweet : Tweet?
    
    func setupCell(with tweet: Tweet) {
        self.tweet = tweet
        
        self.nameLabel.text = tweet.user.name
        self.dateLabel.text = tweet.time
        self.tweetTextLabel.text = tweet.text
        
        self.profileImage.image = UIImage(named: tweet.user.photo)
        self.profileImage.layer.cornerRadius = 30.0
        self.profileImage.clipsToBounds = true
        
        if tweet.user.featured  {
            self.featuredImage.image = UIImage(named: "star-fill")
        } else {
            self.featuredImage.image = UIImage(named: "star-empty")
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
