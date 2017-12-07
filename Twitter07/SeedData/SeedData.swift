//
//  SeedData.swift
//  Twitter07
//
//  Created by Amin Rezapour on 11/15/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(dateFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}

class SeedData {
    
    var users : [User] = []
    var tweets : [Tweet] = []
    var time : String = Date().toString(dateFormat: "yyyy-MM-dd HH:mm")
    
    init() {
        self.users = createUsers(number: 10)
        self.tweets = generateTweets(numberPast: 30, numberFuture: 6, users: users)
    }
    
    func allTweets() -> [Tweet] {
        return self.tweets
    }
    
    func allUsers() -> [User] {
        return self.users
    }
    
    func featuredUsers() -> [User]? {
        return self.users.filter { $0.featured }
    }
    
    func featuredUsersTweets(tweets: [Tweet]) -> [Tweet]? {
        return self.tweets.filter { $0.user.featured }
    }
    
    func sortedTweets(tweets: [Tweet]) -> [Tweet] {
        return tweets.sorted(by: { (tweet1: Tweet, tweet2: Tweet) -> Bool in
            return tweet1.time > tweet2.time
        })
    }
    
    func reverseSortedTweets(tweets: [Tweet]) -> [Tweet] {
        return tweets.sorted(by: { (tweet1: Tweet, tweet2: Tweet) -> Bool in
            return tweet1.time < tweet2.time
        })
    }
    
    func sortedPastTweets(time: String) -> [Tweet] {
        let past = self.tweets.filter { $0.time <= time }
        return sortedTweets(tweets: past)
    }
    
    func sortedFutureTweets(time: String) -> [Tweet] {
        let future = self.tweets.filter { $0.time >= time }
        return reverseSortedTweets(tweets: future)
    }
    
    func sortedFeaturedPastTweets(time: String) -> [Tweet] {
        let past = self.tweets.filter { $0.time <= time && $0.user.featured }
        return sortedTweets(tweets: past)
    }
    
    func sortedFeaturedFutureTweets(time: String) -> [Tweet] {
        let future = self.tweets.filter { $0.time >= time && $0.user.featured }
        return reverseSortedTweets(tweets: future)
    }
    
    func randomChar() -> String {
       
        let letters : NSString = "abcdefghijklmnopqrstuvwxyz"
        let len = UInt32(letters.length)
        let rand = arc4random_uniform(len)
        var char = letters.character(at: Int(rand))
        
        return NSString(characters: &char, length: 1) as String
    }

    func randomWord() -> String {
        
        let maxWordLength : UInt32 = 8
        let length = arc4random_uniform(maxWordLength) + 1
        var randomString = ""
        
        for _ in 1...length {
            randomString += randomChar()
        }
        
        return randomString
    }

    func randomTweetText() -> String {
        
        var randomString = ""
        
        while randomString.count < 140 {
            randomString += " " + randomWord()
        }
        
        return randomString
    }

    func randomUserName() -> String {
        
        let length = arc4random_uniform(5) + 5
        var randomString = ""
        
        for _ in 1...length {
            randomString += randomChar()
        }
        
        return randomString.capitalized
    }

    func createUsers(number: Int) -> [User] {
        
        var usersArray : [User] = []
        
        for i in 1...number {
            let aUserName = randomUserName()
            let aUser = User(name: aUserName, photo: "userimage\(i)")
            let rand = arc4random_uniform(10)
            if rand < 3 {
                aUser.featured = true
            }
            usersArray.append(aUser)
        }
        
        return usersArray
    }

    func randomDate(hours: Int) -> String? {
        let sign = hours > 0 ? 1 : -1
        let hour = arc4random_uniform(UInt32(sign * hours))
        let minute = arc4random_uniform(60)
        
        let today = Date(timeIntervalSinceNow: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.hour = sign * Int(hour)
        offsetComponents.minute = sign * Int(minute)
        
        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
        return randomDate?.toString(dateFormat: "yyyy-MM-dd HH:mm")
    }

    func generateTweets(numberPast: Int, numberFuture: Int, users: [User]) -> [Tweet] {

        let hoursPast = -5
        let hoursFuture = 1
        var tweetsArray : [Tweet] = []

        for _ in 1...numberPast {
            let aDate = randomDate(hours: hoursPast)
            let aText = randomTweetText()
            let aUser = users[Int(arc4random_uniform(UInt32(users.count)))]
            let aTweet = Tweet(text: aText, time: aDate!, user: aUser)
            tweetsArray.append(aTweet)
        }
        for _ in 1...numberFuture {
            let aDate = randomDate(hours: hoursFuture)
            let aText = randomTweetText()
            let aUser = users[Int(arc4random_uniform(UInt32(users.count)))]
            let aTweet = Tweet(text: aText, time: aDate!, user: aUser)
            tweetsArray.append(aTweet)
        }

        return tweetsArray
    }
    
}

















