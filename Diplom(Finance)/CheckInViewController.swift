//
//  CheckInViewController.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 23.11.2020.
//

import UIKit
import SwiftUI

import Firebase
import FirebaseAuth


class CheckInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var recomendationLabel: UILabel!
    @IBOutlet weak var checkInOutlet: UIButton!
    @IBOutlet weak var agreeButtonOutlet: UIButton!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var fillPassOutlet: UITextField!
    @IBAction func fillPassAction(_ sender: Any) {
    }
    @IBOutlet weak var goBackOutlet: UIButton!
    
    var agreeColor = 0
    
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var numberTextFieldOutlet: UITextField!
    
    @IBAction func numberTextFieldAction(_ sender: Any) {
    }
    @IBOutlet weak var counditionsLabel: UILabel!
    
    @IBOutlet weak var cleanButtonOutlet: UIButton!
    
    @IBAction func cleanButton(_ sender: Any) {
        numberTextFieldOutlet.text = ""
    }
    
    @IBAction func goBack(_ sender: Any) {
        viewFirst() 
    }
    @IBOutlet weak var codSMS: UITextField!
    func viewFirst(){
        recomendationLabel.text = "Введите номер телефона"
        viewOne.isHidden = false
        numberLabel.isHidden = false
        agreeButtonOutlet.isHidden = false
        checkInOutlet.setTitleColor(UIColor.white, for: .normal)
        checkInOutlet.setTitle("Войти", for: .normal)
        checkInOutlet.backgroundColor = .systemBlue
        checkInOutlet.backgroundColor = .systemGray
        counditionsLabel.text = "Настоящим я даю свое согласие на обработку моих личных данных, в соответствии с Федеральным законом от 27.07.2006 года №152-ФЗ «О персональных данных» и Условиями"
        
        counditionsLabel.font = UIFont.systemFont(ofSize: 10.0)
//        counditionsLabel.trailingAnchor.constraint(equalTo: view.superview!.trailingAnchor, constant: 44).isActive = true
//        counditionsLabel.leadingAnchor.constraint(equalTo: view.superview!.leadingAnchor, constant: 15).isActive = true
      
        numberTextFieldOutlet.text = ""
        numberTextFieldOutlet.placeholder = "+7 (   )"
        numberTextFieldOutlet.isHidden = false
        view.endEditing(true)
        stack.isHidden = true
        cleanButtonOutlet.isHidden = false
        goBackOutlet.isHidden = true
        agreeButtonOutlet.backgroundColor = .white
        checkInOutlet.isEnabled = false
       
    }
    
    func viewSecond(){
        recomendationLabel.text = "Введите код из смс"
        viewOne.isHidden = true
        numberLabel.isHidden = true
        agreeButtonOutlet.isHidden = true
        checkInOutlet.setTitleColor(UIColor.systemBlue, for: .normal)
        checkInOutlet.setTitle("Отправить еще раз", for: .normal)
        checkInOutlet.backgroundColor = .white
        counditionsLabel.text = "Номер: \(numberTextFieldOutlet.text!)"
        counditionsLabel.font = UIFont.systemFont(ofSize: 15.0)
//        counditionsLabel.leadingAnchor.constraint(equalTo: view.superview!.leadingAnchor, constant: 15).isActive = true
//        counditionsLabel.trailingAnchor.constraint(equalTo: view.superview!.trailingAnchor, constant: 15).isActive = true
        numberTextFieldOutlet.isHidden = true
        numberTextFieldOutlet.placeholder = ""
        view.endEditing(true)
        stack.isHidden = false
        cleanButtonOutlet.isHidden = true
        goBackOutlet.isHidden = false
    }
    
    @IBAction func agreeButton(_ sender: Any) {
        if agreeColor == 0 && numberTextFieldOutlet.text?.count ?? 0 == 17{
            agreeButtonOutlet.layer.cornerRadius = 7.5
            agreeButtonOutlet.backgroundColor = .systemBlue
            checkInOutlet.backgroundColor = .systemBlue
            checkInOutlet.isEnabled = true
            agreeColor = 1
        } else {
            agreeButtonOutlet.backgroundColor = .white
            checkInOutlet.backgroundColor = .systemGray
            checkInOutlet.isEnabled = false
            agreeColor = 0
        }
    }
    @IBAction func checkInAction(_ sender: Any) {
        viewSecond()
            counditionsLabel.text = "Номер: \(numberTextFieldOutlet.text!)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as? UITouch{
        view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        checkInOutlet.backgroundColor = .systemGray
        checkInOutlet.isEnabled = false
        checkInOutlet.layer.cornerRadius = 24
        goBackOutlet.isHidden = true
      
        numberTextFieldOutlet.delegate = self
        codSMS.delegate = self
        numberTextFieldOutlet.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        codSMS.addTarget(self, action: #selector(editingChangedSMS), for: .editingChanged)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        if numberTextFieldOutlet.isHidden == false{
            guard let preText = numberTextFieldOutlet.text as NSString?, preText.replacingCharacters(in: range, with: string).count <= 17 else {
            return false
        }
        } else {
            guard let preTextSMS = codSMS.text as NSString?, preTextSMS.replacingCharacters(in: range, with: string).count <= 18 else {
            return false
        }
        }
        return true
    }
    
    
    // MARK: - изменяет номер телефона по шаблону
    @objc func editingChanged(){
         let pattern = "+# (###) ###-####"
         let mobile = numberTextFieldOutlet.text
        numberTextFieldOutlet.text = mobile!.applyPatternOnNumbers(pattern: pattern)
     }
    
    @objc func editingChangedSMS(){
         let pattern = "  #    #    #    # "
         let mobile = codSMS.text
        codSMS.text = mobile!.applyPatternOnNumbers(pattern: pattern)
     }
    
}
extension String{
    func applyPatternOnNumbers(pattern: String) -> String {
        let  replacmentCharacter: Character = "#"
        var pure = self.replacingOccurrences( of: "[^۰-۹0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pure.count else { return pure }
            let stringIndex = String.Index.init(encodedOffset: index)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pure.insert(patternCharacter, at: stringIndex)
        }
       return pure
    }
 }


