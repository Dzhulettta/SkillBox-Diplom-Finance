//
//  CheckInViewController2.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 24.11.2020.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore

class CheckInViewController2: UIViewController{
    var enterOrRegictration = 0 // 0-регистрация, 1-вход
    
    @IBAction func next(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var notRememberPassOutlet: UIButton!
    @IBOutlet weak var nameSmall: UILabel!
    
    @IBOutlet weak var or: UILabel!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
    
    @IBOutlet weak var del: UIButton!
    
    @IBOutlet weak var viewSmall: UIView!
    @IBOutlet weak var passSmall: UILabel!
    @IBOutlet weak var avtorisTextField: UILabel!
    
    @IBOutlet weak var enterForFacebookOutlet: UIButton!
    @IBAction func cleanName(_ sender: Any) {
        if avtorisTextField.text == "Регистрация"{
            nameTextField.text = ""
        } else {
            emailTextField.text = ""
        }
    }
    
    @IBAction func cleanEmail(_ sender: Any) {
        if avtorisTextField.text == "Регистрация"{
            emailTextField.text = ""
        } else {
            passTextField.text = ""
        }
    }
    
    @IBAction func cleanPass(_ sender: Any) {
        if avtorisTextField.text == "Регистрация"{
            passTextField.text = ""
        }
    }
    @IBOutlet weak var emailSmall: UILabel!
    @IBOutlet weak var enterButtonOutler: UIButton!
    @IBAction func enterButtonAction(_ sender: Any) {
    }
    
    func registration(){
        nameSmall.isHidden = false
        passSmall.isHidden = false
        emailSmall.isHidden = false
        nameTextField.isHidden = false
        nameTextField.isEnabled = true
        del.isHidden = false
        viewSmall.isHidden = false
        avtorisTextField.text = "Регистрация"
        registrationButton.isHidden = true
        registrationButton.setTitle("Вход", for: .normal)
        notRememberPassOutlet.isHidden = true
        or.isHidden = true
        enterForFacebookOutlet.isHidden = true
        enterButtonOutler.setTitle("Зарегестрироваться", for: .normal)
    }
    func enter(){
        nameSmall.isHidden = true
        nameTextField.isHidden = true
        nameTextField.isEnabled = true
        del.isHidden = true
        viewSmall.isHidden = true
        avtorisTextField.text = "Авторизация"
        registrationButton.setTitle("Регистрация", for: .normal)
        notRememberPassOutlet.isHidden = false
        or.isHidden = false
        enterForFacebookOutlet.isHidden = false
        enterButtonOutler.setTitle("Войти", for: .normal)
    }
    @IBAction func registrationButtonAction(_ sender: Any) {
        //регистрация
        registration()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        emailTextField.delegate = self
        passTextField.delegate = self
        
        let enterOrRegictrationChoose = enterOrRegictration
        if enterOrRegictrationChoose == 0{
            registration()
        } else {
            enter()
        }
    }
    func alertMistake() {
        let alertController = UIAlertController(title: "Заполните все поля", message: .none, preferredStyle: .alert)
        let alertAction1 = UIAlertAction(title: "Ок", style: .default) { (alert) in
        }
        alertController.addAction(alertAction1)
        present(alertController, animated: true, completion:  nil)
    }
}
extension CheckInViewController2: UITextFieldDelegate{
    func textFieldShouldResult(_ textFiel: UITextField) -> Bool{
        let name = nameTextField.text!
        let emall = emailTextField.text!
        let pass = passTextField.text!
        if avtorisTextField.text == "Регистрация"{
            if (!name.isEmpty && !emall.isEmpty && !pass.isEmpty){
                //enterButton.isEnabled = false
                Auth.auth().createUser(withEmail: emall, password: pass) { (result, error) in
                    if error == nil{
                        if let result = result{
                            print("Выходит: \(result.user.uid)")
                        }
                    }
                }
            } else {
                alertMistake()
            }
        } else {
            if (!emall.isEmpty && !pass.isEmpty){
                
            } else {
                alertMistake()
            }
        }
        return true
    }
    
}
