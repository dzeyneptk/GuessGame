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
    private var fromTextField = ""
    private var randomString = ""
    private var data = [CellData]()
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        configureTableView()
        self.data = [CellData.init(guess: "", placeOfDigits: "")]
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
}

// MARK: - UITextFieldDelegate
extension MainVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
          nextField.becomeFirstResponder()
       } else {
          fromTextField = textFieldMain.text ?? ""
          textField.resignFirstResponder()
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
