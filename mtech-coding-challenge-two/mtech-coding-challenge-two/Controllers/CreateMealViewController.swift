//
//  ViewController.swift
//  mtech-coding-challenge-two
//
//  Created by Justin Snider on 5/15/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

class CreateMealViewController: UIViewController, UITextFieldDelegate {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    var dateFormatter: DateFormatter = DateFormatter()
    
    //========================================
    //MARK: - IBOutlets
    //========================================
    
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var caloriesTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var datePickerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var ratingSegmentedControl: UISegmentedControl!
    
    //========================================
    //MARK: - IBActions
    //========================================
    
    @IBAction func currentDateTapped(_ sender: Any) {
        switch dateButton.isSelected {
        case true:
            UIView.animate(withDuration: 0.5) {
                self.dateButton.transform = .identity
                self.datePickerViewHeightConstraint.constant = 0
                
                self.view.layoutIfNeeded()
            }
            
            self.dateButton.isSelected = false
        case false:
            UIView.animate(withDuration: 0.5) {
                self.dateButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -2)
                self.datePickerViewHeightConstraint.constant = 216
                
                self.view.layoutIfNeeded()
            }
            
            self.dateButton.isSelected = true
        }
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ratingSegmentedControlChanged(_ sender: UISegmentedControl) {
        sender.isSelected = true
        
        if nameTextField.text != "" && caloriesTextField.text != "" && ratingSegmentedControl.isSelected {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }

    @IBAction func textFieldValueChanged(_ sender: UITextField) {
        if nameTextField.text != "" && caloriesTextField.text != "" && ratingSegmentedControl.isSelected {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    
    
    //========================================
    //MARK: - Text Field Delegate Methods
    //========================================
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================

    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        datePicker.maximumDate = Date()
        
        nameTextField.becomeFirstResponder()
        
        nameTextField.delegate = self
        caloriesTextField.delegate = self
        
        saveButton.isEnabled = false
        
        datePickerViewHeightConstraint.constant = 0
        datePickerView.clipsToBounds = true
        
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }
    
    override func viewDidLayoutSubviews() {
        dateLabel.addBorder(side: .Bottom, thickness: 2, color: UIColor.lightGray, leftOffset: 0, rightOffset: dateLabel.bounds.width - 90, topOffset: 0, bottomOffset: -2)
    }


}


extension UIView {
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    func addBorder(side: ViewSide, thickness: CGFloat, color: UIColor, leftOffset: CGFloat = 0, rightOffset: CGFloat = 0, topOffset: CGFloat = 0, bottomOffset: CGFloat = 0) {
        
        switch side {
        case .Top:
            // Add leftOffset to our X to get start X position.
            // Add topOffset to Y to get start Y position
            // Subtract left offset from width to negate shifting from leftOffset.
            // Subtract rightoffset from width to set end X and Width.
            let border: CALayer = _getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                                   y: 0 + topOffset,
                                                                   width: self.frame.size.width - leftOffset - rightOffset,
                                                                   height: thickness), color: color)
            self.layer.addSublayer(border)
        case .Right:
            // Subtract the rightOffset from our width + thickness to get our final x position.
            // Add topOffset to our y to get our start y position.
            // Subtract topOffset from our height, so our border doesn't extend past teh view.
            // Subtract bottomOffset from the height to get our end.
            let border: CALayer = _getOneSidedBorder(frame: CGRect(x: self.frame.size.width-thickness-rightOffset,
                                                                   y: 0 + topOffset, width: thickness,
                                                                   height: self.frame.size.height - topOffset - bottomOffset), color: color)
            self.layer.addSublayer(border)
        case .Bottom:
            // Subtract the bottomOffset from the height and the thickness to get our final y position.
            // Add a left offset to our x to get our x position.
            // Minus our rightOffset and negate the leftOffset from the width to get our endpoint for the border.
            let border: CALayer = _getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                                   y: self.frame.size.height-thickness-bottomOffset,
                                                                   width: self.frame.size.width - leftOffset - rightOffset, height: thickness), color: color)
            self.layer.addSublayer(border)
        case .Left:
            let border: CALayer = _getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                                   y: 0 + topOffset,
                                                                   width: thickness,
                                                                   height: self.frame.size.height - topOffset - bottomOffset), color: color)
            self.layer.addSublayer(border)
        }
    }
}

fileprivate func _getOneSidedBorder(frame: CGRect, color: UIColor) -> CALayer {
    let border:CALayer = CALayer()
    border.frame = frame
    border.backgroundColor = color.cgColor
    return border
}
