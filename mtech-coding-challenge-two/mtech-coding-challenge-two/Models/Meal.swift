//
//  Meal.swift
//  mtech-coding-challenge-two
//
//  Created by Justin Snider on 5/16/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import Foundation

struct Meal: Codable {
    var name: String
    var calories: Int
    var dateConsumedString: String
    var rating: Int
    
    
    init?(name: String, calories: Int, dateConsumedString: String, rating: Int) {
        
        guard !name.isEmpty else {
            return nil
        }
        
        guard (rating >= 1) && (rating <= 5) else {
            return nil
        }
        
        self.name = name
        self.rating = rating
        self.calories = calories
        self.dateConsumedString = dateConsumedString
    }
    
    static func saveToFIle(meals: [String : [Meal]]) {
        let propertyListEncoder = PropertyListEncoder()
        let DocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = DocumentDirectory.appendingPathComponent("meals").appendingPathExtension("plist")
        
        let encodedMeals = try? propertyListEncoder.encode(meals)
        
        try? encodedMeals?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [String : [Meal]]? {
        let propertyListDecoder = PropertyListDecoder()
        let DocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = DocumentDirectory.appendingPathComponent("meals").appendingPathExtension("plist")
        
        if let retrievedMealData = try? Data(contentsOf: archiveURL), let decodedMeals = try? propertyListDecoder.decode(Dictionary<String, Array<Meal>>.self, from: retrievedMealData) {
            return decodedMeals
        }
        
        return nil
    }
}
