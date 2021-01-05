//
//  Gus.swift
//  MyFondTransportnie
//
//  Created by Mac on 25.12.2020.
//

import Foundation
import SwiftyGif

extension ViewController {
        
    enum GusState {
        case show
        case hide
    }

    func gus(setState: GusState){
        switch setState {
        case .hide:
            
            for v in view.subviews {
                if v.tag == 99 {
                    v.removeFromSuperview()
                }
            }
            
        case .show:
            do {
                let gif = try UIImage(gifName: "crack.gif")
                let imageview = UIImageView(gifImage: gif, loopCount: 999)
                imageview.frame = view.bounds
                imageview.frame = CGRect(x: view.frame.width/2 - 150, y: view.frame.height/2 - 240, width: 300, height: 400)
                imageview.tag = 99
                tableView.tableFooterView = UIView()
                tableView.addSubview(imageview)
                break
            } catch {
                print(error)
            }
        }
    }
    
    func showAthorizeAlert(somethingIncorrect: Bool = false){
        let alertController = UIAlertController(title: "Авторизируйся", message: nil, preferredStyle: .alert)
        
        //Create lable for AlertController, SETUP
        let label = UILabel(frame: CGRect(x: 0, y: 40, width: 270, height:18))
        label.textAlignment = .center
        label.textColor = .red
        label.font = label.font.withSize(12)
        
        // Add lable to alert
        alertController.view.addSubview(label)
        label.isHidden = true
        
        // Add textFields
        alertController.addTextField { (nameTextField) in
            nameTextField.placeholder = "name"
        }
        alertController.addTextField { (passTextField) in
            passTextField.placeholder = "pass"
            passTextField.isSecureTextEntry = true
        }
        
        if somethingIncorrect {
            label.text = "Логин или пароль неверный"
            label.isHidden = false
        }
        
        alertController.addAction(UIAlertAction(title: "Login", style: .default, handler: {(action) in
            print("loginAction")
            let login = alertController.textFields![0].text
            let pass = alertController.textFields![1].text
            
            if login == "" || pass == ""{
                label.text = "Пустое имя или пароль не канают!"
                label.isHidden = false
                self.present(alertController, animated: true, completion: nil)
                
            } else if !self.isValidInput(firstInput: login!, secondInput: pass!) {
                label.text = "Только анг. символы и цыфры"
                label.isHidden = false
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                ModelController.authFromAPI( login: login!, pass: pass!)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func isValidInput(firstInput:String, secondInput: String) -> Bool {
        let RegEx = "^[^а-яА-Я]+$"
        let test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        
        return test.evaluate(with: firstInput) && test.evaluate(with: secondInput)
    }
    
    func showCustomAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAutonomikModeAlert(){
        let alertController = UIAlertController(title: "Приложение в автономном режиме", message: "Когда сервер станет доступен данные обновятся", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ОК", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    

}
