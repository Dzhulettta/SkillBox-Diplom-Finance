//
//  MainEnterViewController.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 17.12.2020.
//

import UIKit
//import FirebaseAuth
//import FirebaseCore

class MainEnterViewController: UIViewController {
    var enterOrRegictrationChoose: Int = 0
    @IBAction func registrationButton(_ sender: Any) {
        enterOrRegictrationChoose = 0
        if let checkInViewController2 = storyboard?.instantiateViewController(identifier: "CheckInViewController2"){
            performSegue(withIdentifier: "registration", sender: "\(enterOrRegictrationChoose)" )
        }
    }
    @IBAction func enterForNumber(_ sender: Any) {
    }
    @IBAction func enterForLogin(_ sender: Any) {
        enterOrRegictrationChoose = 1
        if let checkInViewController2 = storyboard?.instantiateViewController(identifier: "CheckInViewController2"){
            performSegue(withIdentifier: "registration", sender: "\(enterOrRegictrationChoose)" )
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "registration"{
       let vc = segue.destination as! CheckInViewController2
       let enterOrRegictration = enterOrRegictrationChoose
           vc.enterOrRegictration = enterOrRegictration
       }
   }
}

