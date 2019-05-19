//
//  MealController.swift
//  mtech-coding-challenge-two
//
//  Created by Justin Snider on 5/16/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import Foundation

struct MealController {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    static var shared = MealController()
    
    var daysTracked: [String] = []
    var meals: [String : [Meal]] = [:]
    
    //========================================
    //MARK: - Meal Methods
    //========================================
    
    mutating func createMeal(name: String, calories: Int, dateConsumed: Date, rating: Int) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let dateConsumedString = dateFormatter.string(from: dateConsumed)
        
        guard let newMeal = Meal(name: name, calories: calories, dateConsumedString: dateConsumedString, rating: rating) else { return }
        
        guard let currentMeals = meals[newMeal.dateConsumedString] else {
            daysTracked.append(newMeal.dateConsumedString)
            meals.updateValue([newMeal], forKey: newMeal.dateConsumedString)
            return
        }
        var unwrappedCurrentMeals = currentMeals
        
        unwrappedCurrentMeals.append(newMeal)
        
        meals.updateValue(unwrappedCurrentMeals, forKey: newMeal.dateConsumedString)
    }
}
