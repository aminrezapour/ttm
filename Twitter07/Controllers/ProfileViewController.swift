//
//  ProfileViewController.swift
//  Twitter07
//
//  Created by Amin Rezapour on 11/8/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ProfileCellDelegate {
    
    var users : [User]?
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var followersTable: UITableView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var featuredFollowersLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tbc = tabBarController as? MainTabBarController
        users = tbc?.seedData.allUsers()
        
        profilePhoto()
        numberOfFollowersUpdate()
        numberOfFeaturedFollowersUpdate()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (users?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerCellIdentifier", for: indexPath) as! ProfileTableViewCell
        
        let user = self.users![indexPath.row]
        
        cell.delegate = self
        cell.setupCell(with: user)
        
        return cell
    }
    
    // ProfileCellDelegate
    
    func featureButtonWasPressed(for cell: ProfileTableViewCell) {
        if let indexPath = self.followersTable.indexPath(for: cell) {
            let user = self.users![indexPath.row]
            user.featured = !user.featured
            self.followersTable.reloadRows(at: [indexPath], with: .none)
            self.numberOfFeaturedFollowersUpdate()
        }
        
    }

    // User Profile Update
    func profilePhoto() {
        profileImage.layer.cornerRadius = 42.0
        profileImage.clipsToBounds = true
    }
    
    func numberOfFollowersUpdate() {
        if let numberOfFollowers = self.users?.count {
            followersLabel.text = "Following \(numberOfFollowers)"
        }
    }
    
    func numberOfFeaturedFollowersUpdate() {
        if let users = self.users {
            let numberOfFeaturedFollowers = users.filter{$0.featured}.count
            featuredFollowersLabel.text = "Featured \(numberOfFeaturedFollowers)"
        }
    }

}
