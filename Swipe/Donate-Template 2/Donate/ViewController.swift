//
//  ViewController.swift
//  Donate
//
//  Created by Ziad TAMIM on 6/7/15.
//  Copyright (c) 2015 TAMIN LAB. All rights reserved.
//

import UIKit

class ViewController: UITableViewController,UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var expireDateTextField: UITextField!
    @IBOutlet weak var cvcTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet var textFields: [UITextField]!
    
    // MARK: - Text field delegate 
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        return true
    }
    
   // let intamount: Int = Int(self.amountTextField.text!)! -
    // MARK: Actions
    
    @IBAction func donate(sender: AnyObject) {
        
        // Initiate the card
        var stripCard = STPCard()
        
        // Split the expiration date to extract Month & Year
        if self.expireDateTextField.text.isEmpty == false {
            let expirationDate = self.expireDateTextField.text.componentsSeparatedByString("/")
            let expMonth = Int(expirationDate[0])
            let expYear = Int(expirationDate[1])
            
            // Send the card info to Strip to get the token
            stripCard.number = self.cardNumberTextField.text
            stripCard.cvc = self.cvcTextField.text
            stripCard.expMonth = expMonth
            stripCard.expYear = expYear
        }
        
        var underlyingError: NSError?
        stripCard.validateCardReturningError(&underlyingError)
        if underlyingError != nil {
            self.spinner.stopAnimating()
            self.handleError(underlyingError!)
            return
        }
    
    }
    

}

