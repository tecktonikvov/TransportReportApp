//
//  PointViewController.swift
//  MyFondTransportnie
//
//  Created by Mac on 08.01.2021.
//

import UIKit

class PointViewController: UIViewController {

    var currentTrip: Trip?
    var currentPoints: [Point]?
    var indexOfParkingCell: Int?
    
    @IBOutlet var addButtonCollection: [UIButton]!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView?.backgroundColor = .white
        addButtonCollection.forEach({$0.layer.cornerRadius = 6}) 

        currentTrip = (self.tabBarController as! TabBarController).currentTrip
        currentPoints = currentTrip?.point?.allObjects as? [Point]
        
        currentPoints?.sort(by: { $0.sort_number < $1.sort_number })
        
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.backgroundColor = .white
        view.backgroundColor = .white
        registerForKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //self.tabBarController?.navigationItem.rightBarButtonItem = nil
        removeKeyboardNotifications()
        saveUserInputWhenSwitchTabBarController()
    }
    
 //MARK: - Add points actions
    @IBAction func addButtonPressed(_ sender: UIButton) {
        guard let newPoint = DataManager.createNewEntity(entityName: "Point") as? Point else { return }
        newPoint.type = "point"
        currentPoints?.append(newPoint)
        updateSortIndexesForCurrentPoints()
        tableView.reloadData()
    }
    
    @IBAction func addParkingButtonPressed(_ sender: UIButton) {
        guard let newPoint = DataManager.createNewEntity(entityName: "Point") as? Point else { return }
        newPoint.type = "parking"
        newPoint.city = "Николаев / Nikolaev"
        newPoint.street = "Чкалова / Chkalova"
        newPoint.no = "25a"
        currentPoints?.append(newPoint)
        updateSortIndexesForCurrentPoints()
        tableView.reloadData()
    }
    
    @IBAction func addFondButtonPressed(_ sender: UIButton) {
        guard let newPoint = DataManager.createNewEntity(entityName: "Point") as? Point else { return }
        newPoint.type = "fond"
        newPoint.city = "Николаев / Nikolaev"
        newPoint.street = "Соборная / Sobornaya"
        newPoint.no = "12б"
        currentPoints?.append(newPoint)
        updateSortIndexesForCurrentPoints()
        tableView.reloadData()
    }
    
//MARK: - Private functions
    private func saveUserInputWhenSwitchTabBarController(){
        for cell in tableView.visibleCells{
            let pointcell = cell as! PointViewCell
            currentPoints![cell.tag].city = pointcell.sityTF.text
            currentPoints![cell.tag].street = pointcell.streetTF.text
            currentPoints![cell.tag].no = pointcell.numberTF.text
            currentPoints![cell.tag].target_de = pointcell.targetDeTF.text
            currentPoints![cell.tag].target_ru = pointcell.targetRuTF.text
        }
        //updateSortIndexesForCurrentPoints()
        print(currentPoints)
        (self.tabBarController as! TabBarController).newPointList = currentPoints
    }
    
    private func updateSortIndexesForCurrentPoints(){
        var i: Int16 = 0
        for point in currentPoints! { 
            point.sort_number = i
            print("++++++++++")
            print(point.street!+String(point.sort_number))

            i += 1
        }
    }
//MARK: - Keyboard show/hide
    func registerForKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
      //If content is not was moved then move view frame to keyboard height
        if self.view.frame.origin.y == 0{
            let userInfo = notification.userInfo
        //Get kb frame size value
            let kbSize = ((userInfo?[UIResponder.keyboardFrameEndUserInfoKey])! as! NSValue).cgRectValue
        //Get tabBar frame size value
            let tabBarSize = self.tabBarController?.tabBar.frame.size
            self.view.frame.origin.y -= kbSize.height - tabBarSize!.height
        }
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
}


//MARK: - Extensions
extension PointViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate, UITextViewDelegate, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentPoints?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pointCell") as! PointViewCell
        cell.tag = indexPath.row
        
        cell.targetRuHeightConstraint.constant = 50
        cell.targetDeHeightConstraint.constant = 50
        cell.targetRuTF.isHidden = false
        cell.targetDeTF.isHidden = false
        
    // We don`t need some fields if point is "parking". We will fill them in as default
        if currentPoints![indexPath.row].type == "parking" {
            cell.targetRuTF.isHidden = true
            cell.targetDeTF.isHidden = true
            cell.targetRuHeightConstraint.constant = 0
            cell.targetDeHeightConstraint.constant = 0
            cell.gpsButton.isEnabled = false
        }
        
    // If point does not have a String, make a placeholder for the UITextView
        cell.targetDeTF.text = "Цель поездки DE"
        cell.targetDeTF.textColor = .lightGray
        cell.targetRuTF.text = "Цель поездки RU"
        cell.targetRuTF.textColor = .lightGray
        
        cell.sityTF.text = currentPoints![indexPath.row].city
        cell.streetTF.text = currentPoints![indexPath.row].street
        cell.numberTF.text = currentPoints![indexPath.row].no
        
        if let targetDe = currentPoints![indexPath.row].target_de {
            cell.targetDeTF.text = targetDe
            cell.targetDeTF.textColor = .black
        }
        if let targetRu = currentPoints![indexPath.row].target_ru {
            cell.targetRuTF.text = targetRu
            cell.targetRuTF.textColor = .black
        }
           
        cell.sityTF.textColor = .black
        cell.streetTF.textColor = .black
        cell.numberTF.textColor = .black
        
        return cell
    }

//MARK: - Override to support rearranging the table view.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {return true}
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let elementToMove = currentPoints![fromIndexPath.row]
        currentPoints!.remove(at: fromIndexPath.row)
        currentPoints!.insert(elementToMove, at: to.row)
        updateSortIndexesForCurrentPoints()
    }
        
//MARK: - Swipe to delete
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {return true}
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            currentPoints?.remove(at: indexPath.row)
            updateSortIndexesForCurrentPoints()
            tableView.reloadData()
        }
    }
    
//MARK: - Long hold drag and drop
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
           if session.localDragSession != nil {
               return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
           }
           return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
       }

       func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
       }
    
//MARK: - TextView Delegate
//This solution solves the problem of displaying placeholder in UITextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
//This solution solves the problem of displaying placeholder in UITextView
    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            if textView.tag == 1 {
//                textView.text = "Цель поездки RU"
//            } else {
//                textView.text = "Цель поездки DE"
//            }
//            textView.textColor = UIColor.lightGray
//        }
        
//Update currentTrip from user inputValues
        //currentTrip[]
//Get the indexpath of the cell in which the textfield is located
    }
    
  // Dissmiss keyboard on "Done" button prssed
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }

    
//MARK: - TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
