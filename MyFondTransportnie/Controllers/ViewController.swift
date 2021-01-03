//
//  ViewController.swift
//  MyFondTransportnie
//
//  Created by Mac on 08.12.2020.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let CDM = CoreDataManager()
    static let shared = ViewController()
    
    enum VCState {
        case nonAuthorise
        case fetchengData
        case normal
        case fatalError(String)
        case autonomicMode
    }
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var logoutButn: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var users = [User]() {
        didSet{
            //print(users)
        }
    }
    
    var trips = [Trip]() {
        didSet {
            trips.sort(by: { Int($0.odometer_start!)! > Int($1.odometer_start!)! })
            tableView.reloadData()
            print("Variable trips in \(#file) was update, current count: \(trips.count)")
        }
    }
    
    var state: VCState {
        get{
            return self.state
        }
        set(v){
            self.setState(state: v)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.vc = self
        ModelController.vc = self
        setState(state: .nonAuthorise)
        //CoreDataStack.sharedInstance.applicationDocumentsDirectory() // выводит в консоль директорию CoreData
        tableView.backgroundColor = .white
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        UserSettings.userModel = nil
        trips = [Trip]()
        tableView.reloadData()
        setState(state: .nonAuthorise)
    }
    
    func setState(state: VCState){
        switch state{
        case .nonAuthorise:
            if UserSettings.userModel?.userName == nil {
                showAthorizeAlert()
            } else {
                setState(state: .fetchengData)
            }
            logoutButn.isEnabled = false
            
        case .fetchengData:
            gus(setState: .show)
            ModelController.getTripsFromAPI()
            //ModelController.getUsersFromAPI()

        case .normal:
            gus(setState: .hide)
            self.logoutButn.isEnabled = true

        case .autonomicMode:
            gus(setState: .hide)
            navBar.title = "Поездки(автономно)"
            showAutonomikModeAlert()
            
            break
        case .fatalError(let massage):
            showCustomAlert(title: "Ну ничего, страшного", message: massage)
            break
            
        }
    }
}

extension  ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell") as! TripTableViewCell
        let trip = trips[indexPath.row]
        cell.benzLabel.text = ""
        cell.lpgLabel.text = ""
        let indexUp = indexPath.row + 1
        
        cell.nameLabel.text = prepareAbbrevString(trip: trip)
        cell.startRangeLabel.text = trip.odometer_start
        cell.endRangeLabel.text = trip.odometer_end

        if indexPath.row != trips.count - 1{
            if cell.startRangeLabel.text != trips[indexUp].odometer_end {
                cell.backgroundColor = #colorLiteral(red: 1, green: 0.8984109074, blue: 0.8925564463, alpha: 1)
            } else {
                cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
        
        cell.dateLabel.text  = trip.date
        cell.timeLabel.text  = trip.time
        
        if trip.refull == "1" {
            if trip.fuel == "1" { // This is A-95
                cell.benzLabel.text = "A-95"
            } else {
                cell.lpgLabel.text = "LPG"
            }
        }

        return cell
    }
}




