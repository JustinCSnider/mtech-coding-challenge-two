//
//  MealTableViewController.swift
//  mtech-coding-challenge-two
//
//  Created by Justin Snider on 5/16/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let meals = Meal.loadFromFile() else { return }
        
        MealController.shared.meals = meals
        MealController.shared.daysTracked = Array(meals.keys)
    }
    
    //========================================
    //MARK: - Table View Delegate Methods
    //========================================
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return MealController.shared.daysTracked.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return MealController.shared.daysTracked[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let currentMeals = MealController.shared.meals[MealController.shared.daysTracked[section]] else { return 0 }
        return currentMeals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as? MealTableViewCell else { return UITableViewCell() }
        
        guard let currentMeal = MealController.shared.meals[MealController.shared.daysTracked[indexPath.section]]?[indexPath.row] else { return UITableViewCell()}
        
        cell.nameLabel.text = currentMeal.name
        cell.caloriesLabel.text = String(currentMeal.calories)
        
        switch currentMeal.rating {
        case 1:
            cell.ratingLabel.text = "Gross"
        case 2:
            cell.ratingLabel.text = "Bad"
        case 3:
            cell.ratingLabel.text = "Decent"
        case 4:
            cell.ratingLabel.text = "Good"
        case 5:
            cell.ratingLabel.text = "Delicious"
        default:
            break
        }
        
        return cell
    }
    
    //========================================
    //MARK: - Navigation
    //========================================
    
    @IBAction func unwindSegueForMealTableView(segue: UIStoryboardSegue) {
        if let source = segue.source as? CreateMealViewController {
            guard let calories = Int(source.caloriesTextField.text ?? "") else { return }
            var name: String
            var dateConsumed: Date
            var rating: Int
            
            name = source.nameTextField.text ?? ""
            
            dateConsumed = source.datePicker.date
            
            switch source.ratingSegmentedControl.selectedSegmentIndex {
            case 0:
                rating = 1
            case 1:
                rating = 2
            case 2:
                rating = 3
            case 3:
                rating = 4
            case 4:
                rating = 5
            default:
                rating = 3
            }
            
            MealController.shared.createMeal(name: name, calories: calories, dateConsumed: dateConsumed, rating: rating)
            Meal.saveToFIle(meals: MealController.shared.meals)
            tableView.reloadData()
        }
    }
    
}
