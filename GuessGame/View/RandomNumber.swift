//
//  RandomNumber.swift
//  GuessGame
//
//  Created by zeynep tokcan on 24.07.2020.
//  Copyright © 2020 zeynep tokcan. All rights reserved.
//

import Foundation
class RandomNumber {
    var fourDigitNumber: String {
     var result = ""
     repeat {
         result = String(format:"%04d", arc4random_uniform(10000) )
     } while Set<Character>(result).count < 4 || Int(result)! < 1000
     return result
    }
}
