//
//  DescVC.swift
//  MyFondTransportnie
//
//  Created by Mac on 26.12.2020.
//

import UIKit

class DescVC: UIViewController {
    
    enum Proffesion{
        case iT
        case perewodchik
        case someOne
    }

    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addITButtn: UIButton!
    var spisok = [String](){
        didSet{
            heightTableView.constant += 44
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        heightTableView.constant = 44
    }
    
    @IBAction func addITAction(_ sender: Any) {
        makeActionSheet(data: ["Herr","Frau","Herr"], proffesion: .iT)
    }
    
    func makeActionSheet(data: [String], proffesion: Proffesion){
        var title = String()

        switch proffesion {
        case .iT:
            title = "IT"

        case .perewodchik:
            title = "Переводчики"
            
        case .someOne:
            title = "Еще кто-то"

        }
        
        let myActionSheet = UIAlertController(title: "IT", message: "Виберите сотрудника", preferredStyle: UIAlertController.Style.actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        let undefined = UIAlertAction(title: "Ввести вручную...", style: UIAlertAction.Style.destructive) { (action) in
            
        }
        
        for name in data {
            let newActionByName = UIAlertAction(title: name, style: UIAlertAction.Style.default) {action in
                self.spisok.append(name)
            }
            myActionSheet.addAction(newActionByName)
        }
        
        myActionSheet.addAction(cancelAction)
        myActionSheet.addAction(undefined)

        self.present(myActionSheet, animated: true, completion: nil)
    }
    
}

extension DescVC: UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        spisok.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addITCell") as! addITCell
        cell.textLabel?.text = spisok[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
