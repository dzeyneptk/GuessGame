//
//  Constants.swift
//  GuessGame
//
//  Created by zeynep tokcan on 26.07.2020.
//  Copyright © 2020 zeynep tokcan. All rights reserved.
//

import Foundation
struct AppConstant{
    static let cellType = "custom"
    static let numbers = "[Z0-9]"
    enum toastMessage: String {
        case enterFourDigit = "Please enter 4 digits!"
        case enterNumber = "Please enter a number!"
        case start = "Let's start!"
        case duplicate = "Please don't enter duplicate numbers!"
        
        var description: String {
            return self.rawValue
        }
    }
    
    enum placeDigit: String {
        case plus = "+"
        case minus = "-"
        
        var description: String {
            return self.rawValue
        }
    }
}
