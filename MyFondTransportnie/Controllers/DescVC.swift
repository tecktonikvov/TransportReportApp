//
//  DescVC.swift
//  MyFondTransportnie
//
//  Created by Mac on 26.12.2020.
//

import UIKit

class DescVC: UIViewController {
    
    var currentTrip: Trip?
    var users: [String]?
    
    @IBOutlet var viewsInAddTables: [UIView]!
    @IBOutlet var addTables: [UITableView]!
    @IBOutlet weak var heightTableViewSomeOne: NSLayoutConstraint!
    @IBOutlet weak var heightTableViewTrans: NSLayoutConstraint!
    @IBOutlet weak var heightTableViewIt: NSLayoutConstraint!
    @IBOutlet weak var tableViewItUsersAdd: UITableView!
    @IBOutlet weak var tableViewTranslatorUsersAdd: UITableView!
    @IBOutlet weak var tableViewSomeOneUsersAdd: UITableView!
    @IBOutlet weak var addITButtn: UIButton!
    
    var listOfItUsers = [String](){
        didSet{
            heightTableViewIt.constant += 44
            tableViewItUsersAdd.reloadData()
        }
    }
    
    var listOfTranslatorsUsers = [String](){
        didSet{
            heightTableViewTrans.constant += 44
            tableViewTranslatorUsersAdd.reloadData()
        }
    }
    
    var listOfSomeOneUsers = [String](){
        didSet{
            heightTableViewSomeOne.constant += 44
            tableViewSomeOneUsersAdd.reloadData()
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        heightTableViewIt.constant = 44
        heightTableViewTrans.constant = 44
        heightTableViewSomeOne.constant = 44
        viewsInAddTables.forEach {$0.layer.cornerRadius = 8}
        addTables.forEach {$0.backgroundColor = .white}
        
        if currentTrip != nil {
            findPersonFromCDM()
        }
    }

    @IBAction func addITAction(_ sender: Any) {
        showActionSheet(profesion: "IT специалисты")
    }
    
    @IBAction func addTranslatorAction(_ sender: Any) {
        showActionSheet(profesion: "Переводчики")
    }
    
    @IBAction func addSomeOneAction(_ sender: Any) {
        showActionSheet(profesion: "Все пользователи")
    }
    
    func findPersonFromCDM(){
        let CDM = CoreDataManager()
        let usersFromCD = CDM.getUsers()
        guard let currentPersonsStr = currentTrip!.persons else { return }
        
        let personsAbbrevInArr = currentPersonsStr.split(separator: " ")
        
            for person in usersFromCD {
                for abbrev in personsAbbrevInArr {
                    if person.abbrev! == abbrev {
                        if person.type == "2" { // if we found in CDM entity User with same abbrev as in trip, add tris person to the table
                            self.listOfItUsers.append(person.surname_ru! + " " + person.name_ru!)
                        } else if person.type == "3" {
                            self.listOfTranslatorsUsers.append(person.surname_ru! + " " + person.name_ru!)
                        } // type "3" - this is translators
                        
                    }
                }
            }
        
    }
    
    func showActionSheet(profesion: String){
        
        let myActionSheet = UIAlertController(title: profesion, message: "Виберите сотрудника", preferredStyle: UIAlertController.Style.actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        
        switch profesion {
        case "IT специалисты":
            let itUsers = ModelController.getUsersStringArrray(byProf: "2")
            for name in itUsers {
                let newActionByName = UIAlertAction(title: name, style: UIAlertAction.Style.default) {action in
                    if !self.listOfItUsers.contains(name) {
                        self.listOfItUsers.append(name)
                    }
                }
                myActionSheet.addAction(newActionByName)
            }

        case "Переводчики":
            let transUsers = ModelController.getUsersStringArrray(byProf: "3")
            for name in transUsers {
                let newActionByName = UIAlertAction(title: name, style: UIAlertAction.Style.default) {action in
                    if !self.listOfTranslatorsUsers.contains(name) {
                        self.listOfTranslatorsUsers.append(name)
                        print(self.listOfTranslatorsUsers)
                    }
                }
                myActionSheet.addAction(newActionByName)
            }
            
        case "Все пользователи":
            var allUsers = [String]()
            allUsers.append(contentsOf: ModelController.getUsersStringArrray(byProf: "1"))
            allUsers.append(contentsOf: ModelController.getUsersStringArrray(byProf: "4"))
            for name in allUsers {
                let newActionByName = UIAlertAction(title: name, style: UIAlertAction.Style.default) {action in
                    if !self.listOfSomeOneUsers.contains(name) {
                        self.listOfSomeOneUsers.append(name)
                    }
                }
                myActionSheet.addAction(newActionByName)
            }
            
        default:
            break
        }
        
        myActionSheet.addAction(cancelAction)

        self.present(myActionSheet, animated: true, completion: nil)
    }
}

extension DescVC: UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return listOfItUsers.count
        } else if tableView.tag == 2 {
             return listOfTranslatorsUsers.count
        } else {
            return listOfSomeOneUsers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addITCell") as! addITCell
        cell.layer.cornerRadius = 8
        if tableView.tag == 1 {
            cell.textLabel?.text = listOfItUsers[indexPath.row]
            return cell

        } else if tableView.tag == 2 {
            cell.textLabel?.text = listOfTranslatorsUsers[indexPath.row]
            return cell
            
        } else {
            cell.textLabel?.text = listOfSomeOneUsers[indexPath.row]
            return cell
        }
    }
}
