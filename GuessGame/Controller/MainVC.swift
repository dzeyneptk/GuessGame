//
//  ViewController.swift
//  GuessGame
//
//  Created by zeynep tokcan on 24.07.2020.
//  Copyright © 2020 zeynep tokcan. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    struct CellData {
        let guess : String?
        let placeOfDigits : String?
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var textFieldMain: UITextField!
    @IBOutlet weak var tableViewGuess: UITableView!
    @IBOutlet weak var labelPrevious: UILabel!
    @IBOutlet weak var buttonNewGame: UIButton!
    
    // MARK: - Private variables
    private var randomString = ""
    private var data = [CellData]()
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        configureTableView()
    }
    
    // MARK: - IBAction Functions
    @IBAction func newGameClicked(_ sender: Any) {
        randomString = RandomNumber().fourDigitNumber
        print(randomString)
    }
    
    // MARK: - Private Functions
    private func configureTextField() {
        self.textFieldMain.delegate = self
        self.textFieldMain.tag = 0
    }
    
    private func configureTableView(){
        self.tableViewGuess.delegate = self
        self.tableViewGuess.dataSource = self
        self.tableViewGuess.tableHeaderView = labelPrevious
        self.tableViewGuess.backgroundColor = UIColor.clear
        self.tableViewGuess.register(CustomCell.self, forCellReuseIdentifier: "custom")
    }
    
    private func checkDigits(number: String?) -> String {
        var placeDigit = ""
        for number in 0 ..< (randomString.count) {
            if (randomString.contains(Array(textFieldMain.text ?? "")[number])) {
                if (Array(randomString)[number] == Array(textFieldMain.text ?? "")[number]) {
                    placeDigit += "+"
                }
                else {
                    placeDigit += "-"
                }
            }
        }
        return placeDigit
    }
}

// MARK: - UITextFieldDelegate
extension MainVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            self.data = [CellData.init(guess: textFieldMain.text ?? "", placeOfDigits: checkDigits(number: textFieldMain.text ?? ""))]
            textField.resignFirstResponder()
            self.tableViewGuess.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
        }
        return false
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableViewGuess.dequeueReusableCell(withIdentifier: "custom") as! CustomCell
        cell.guess = data[indexPath.row].guess
        cell.placesOfDigits = data[indexPath.row].placeOfDigits
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = UIColor.clear
        return cell
    }
}
