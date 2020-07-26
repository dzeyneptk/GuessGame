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
        randomString = RandomNumber().fourDigitNumber
    }
    
    // MARK: - IBAction Functions
    @IBAction func newGameClicked(_ sender: Any) {
        data.removeAll()
        self.tableViewGuess.reloadData()
        randomString = RandomNumber().fourDigitNumber
        print(randomString)
        textFieldMain.text = ""
        showToast(controller: self, message: AppConstant.toastMessage.start.description, seconds: 2)
    }
    
    // MARK: - Private Functions
    private func configureTextField() {
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                              target: self, action: #selector(MainVC.doneClicked))
        toolbarDone.setItems([doneButton], animated: false)
        self.textFieldMain.tag = 0
        self.textFieldMain.keyboardType = .numberPad
        self.textFieldMain.returnKeyType = .done
        self.textFieldMain.inputAccessoryView = toolbarDone
    }
    
    private func containsDuplicateChar(string: String) -> Bool {
        return !(string == string.removedDuplicates)
    }
    
    @objc private func doneClicked() {
        guard let textfield = textFieldMain.text else {return}
        if isDigitNumberSame(string: textfield) && isUserEnteredNumber() && !containsDuplicateChar(string: textfield){
            self.data.append(contentsOf: [CellData.init(guess: textfield, placeOfDigits: checkDigits(number: textfield))])
            self.tableViewGuess.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
        } else if isDigitNumberSame(string: textfield) && !isUserEnteredNumber() || !isDigitNumberSame(string: textfield) && !isUserEnteredNumber()  {
            showToast(controller: self, message: AppConstant.toastMessage.enterNumber.description, seconds: 2)
        } else if !isDigitNumberSame(string: textfield) && isUserEnteredNumber() {
            showToast(controller: self, message: AppConstant.toastMessage.enterFourDigit.description, seconds: 2)
        } else if containsDuplicateChar(string: textfield) {
            showToast(controller: self, message: AppConstant.toastMessage.duplicate.description, seconds: 2)
        }
        self.view.endEditing(true)
        textFieldMain.text = ""
    }
    
    private func configureTableView(){
        self.tableViewGuess.delegate = self
        self.tableViewGuess.dataSource = self
        self.tableViewGuess.tableHeaderView = labelPrevious
        self.tableViewGuess.backgroundColor = UIColor.clear
        self.tableViewGuess.register(CustomCell.self, forCellReuseIdentifier: AppConstant.cellType)
    }
    
    private func checkDigits(number: String?) -> String {
        var placeDigitMinus = ""
        var placeDigitPlus = ""
        guard let textfield = textFieldMain.text else {return ""}
        if (randomString.count == textfield.count) {
            for i in 0 ..< (randomString.count) {
                if (randomString.contains(Array(textfield)[i])) {
                    if (Array(randomString)[i] == Array(textfield)[i]) {
                        placeDigitPlus += AppConstant.placeDigit.plus.description
                    }
                    else {
                        placeDigitMinus += AppConstant.placeDigit.minus.description
                    }
                }
            }
            return placeDigitPlus + placeDigitMinus
        }
        return ""
    }
    
    private func isDigitNumberSame(string: String) -> Bool {
        return randomString.count == string.count
    }
    
    private func isUserEnteredNumber() -> Bool {
        guard let textfield = textFieldMain.text else {return false}
        if ((textfield.range(of: AppConstant.numbers.description, options: .regularExpression, range: nil, locale: nil)) != nil) {
            return true
        } else {
            return false
        }
    }
    
    private func showToast(controller: UIViewController, message: String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableViewGuess.dequeueReusableCell(withIdentifier: AppConstant.cellType) as! CustomCell
        cell.guess = data[indexPath.row].guess
        cell.placesOfDigits = data[indexPath.row].placeOfDigits
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        return cell
    }
}

// MARK: - REMOVE DUPLICATE CHARACTERS EXTENSION
extension RangeReplaceableCollection where Element: Hashable {
    var removedDuplicates: Self {
        var set = Set<Element>()
        return filter{ set.insert($0).inserted }
    }
}
