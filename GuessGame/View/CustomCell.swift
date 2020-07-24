//
//  CustomCell.swift
//  GuessGame
//
//  Created by zeynep tokcan on 24.07.2020.
//  Copyright © 2020 zeynep tokcan. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    var guess : String?
    var placesOfDigits : String?
    
    var guessView : UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    var placesOfDigitsView : UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(guessView)
        self.addSubview(placesOfDigitsView)
        
        guessView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        guessView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        guessView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        placesOfDigitsView.leftAnchor.constraint(equalTo: self.guessView.rightAnchor).isActive = true
        placesOfDigitsView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        placesOfDigitsView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        placesOfDigitsView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let guess = guess {
            guessView.text = guess
        }
        if let placesOfDigits = placesOfDigits {
            placesOfDigitsView.text = placesOfDigits
        }
    }
}
