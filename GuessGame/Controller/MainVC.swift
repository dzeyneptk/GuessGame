//
//  ViewController.swift
//  GuessGame
//
//  Created by zeynep tokcan on 24.07.2020.
//  Copyright © 2020 zeynep tokcan. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var textFieldMain: UITextField!
    @IBOutlet weak var tableViewGuess: UITableView!
    @IBOutlet weak var labelPrevious: UILabel!
    @IBOutlet weak var buttonNewGame: UIButton!
    
    // MARK: - Private variables
    private var fromTextField = ""
    private var randomString = ""
    
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
        self.tableViewGuess.backgroundColor = UIColor.white
        self.tableViewGuess.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
