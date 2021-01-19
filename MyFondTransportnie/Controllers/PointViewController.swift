//
//  PointViewController.swift
//  MyFondTransportnie
//
//  Created by Mac on 08.01.2021.
//

import UIKit

class PointViewController: UIViewController {

    var currentTrip: Trip?
    
    @IBOutlet var textFields: [UITextField]!
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
    }
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView?.backgroundColor = .white
        addButton.layer.cornerRadius = 6
        tableView.backgroundColor = .white
        currentTrip = (self.tabBarController as! TabBarController).currentTrip
        
    }
}

extension PointViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTrip?.point?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pointCell") as! PointViewCell
        let currentPoint = currentTrip?.point?.allObjects as? [Point]
        cell.cityTF.text = currentPoint![indexPath.row].sity
        cell.streetTF.text = currentPoint![indexPath.row].street
        cell.descriptionTF.text = currentPoint![indexPath.row].target_ru
        cell.numberTF.text = currentPoint![indexPath.row].no
        
        cell.cityTF.textColor = .black
        cell.streetTF.textColor = .black
        cell.descriptionTF.textColor = .black
        cell.numberTF.textColor = .black
        
        return cell
    }
}
