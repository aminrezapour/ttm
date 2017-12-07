//
//  SecondViewController.swift
//  Twitter07
//
//  Created by Amin Rezapour on 11/4/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController, UITextFieldDelegate {
    
    var seedData : SeedData?

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var featuredView: UIView!
    @IBOutlet weak var timeTextField: UITextField!
    
    @IBAction func glassHourButton(_ sender: Any) {
        let newTime = timeTextField.text!
        
        self.pastTableViewController.tweets = self.seedData!.sortedPastTweets(time: newTime)
        self.pastTableViewController.tableView.reloadData()
        
        self.futureTableViewController.tweets = self.seedData!.sortedFutureTweets(time: newTime)
        self.futureTableViewController.tableView.reloadData()
    }
    
    
    private lazy var pastTableViewController: PastTableViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate Table View Controller
        var tableViewController = storyboard.instantiateViewController(withIdentifier: "PastTableViewControllerStoryboardID") as! PastTableViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: tableViewController)
        
        //Seed Data
        tableViewController.tweets = self.seedData!.sortedFeaturedPastTweets(time: seedData!.time)
        
        return tableViewController
    }()
    
    private lazy var futureTableViewController: FutureTableViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var tableViewController = storyboard.instantiateViewController(withIdentifier: "FutureTableViewControllerStoryboardID") as! FutureTableViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: tableViewController)
        
        //Seed Data
        tableViewController.tweets = self.seedData!.sortedFeaturedFutureTweets(time: seedData!.time)
        
        return tableViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tbc = tabBarController as? MainTabBarController
        seedData = tbc?.seedData
        
        timeTextField.text = seedData?.time
        
        setupView()
    }

    private func setupView() {
        setupSegmentedControl()
        
        updateView()
    }
    
    private func setupSegmentedControl() {
        
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Past", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Future", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        
    }
    
    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }
    
    private func updateView() {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: futureTableViewController)
            add(asChildViewController: pastTableViewController)
        } else {
            remove(asChildViewController: pastTableViewController)
            add(asChildViewController: futureTableViewController)
        }
        
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller (we don't implement this)
        //flag here because my storyboard, this view controller is not embedded inside a Navigation Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        self.featuredView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = self.featuredView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
        
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        //Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        //Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        //Notify Child View Controller
        viewController.removeFromParentViewController()
        
    }
    
    // Textfield Delegate
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

