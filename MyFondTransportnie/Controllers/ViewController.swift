//
//  ViewController.swift
//  MyFondTransportnie
//
//  Created by Mac on 08.12.2020.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    let CDM = CoreDataManager()
    static let shared = ViewController()
    
    enum VCState {
        case nonAuthorise
        case fetchengData
        case normal
        case fatalError(String)
        case autonomicMode
        case refreshing
    }
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var logoutButn: UIBarButtonItem!
    
    var trips = [Trip]() {
        didSet {
            trips.sort(by: { Int($0.odometer_start!)! > Int($1.odometer_start!)! })
            tableView.reloadData()
            //print("Variable trips in \(#file) was update, current count: \(trips.count)")
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

//MARK: @IBActions
    @IBAction func logoutAction(_ sender: Any) {
        UserSettings.userModel = nil
        trips = [Trip]()
        tableView.reloadData()
        setState(state: .nonAuthorise)
    }
    
    @IBAction func refreshControllAction(_ sender: Any) {
        setState(state: .refreshing)
    }
    
 //MARK: VC function
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
            self.refreshControl?.endRefreshing()
            gus(setState: .hide)
            self.logoutButn.isEnabled = true
            
        case .autonomicMode:
            self.refreshControl?.endRefreshing()
            gus(setState: .hide)
            navBar.title = "Поездки (автономно)"
            showAutonomikModeAlert()
            
        case .refreshing:
            ModelController.getTripsFromAPI()
            
            break
        case .fatalError(let massage):
            showCustomAlert(title: "Ну ничего, страшного", message: massage)
            break
            
        }
    }
//MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTrip" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let tripToSend = trips[indexPath.row]
            let descVC = segue.destination as! TabBarController
            descVC.currentTrip = tripToSend
        }
    }
    
// MARK: TableView Delagate & DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell") as! TripTableViewCell
        let trip = trips[indexPath.row]
        cell.benzLabel.text = ""
        cell.lpgLabel.text = ""
        let indexUp = indexPath.row + 1
        
        cell.startRangeLabel.text = trip.odometer_start
        cell.endRangeLabel.text = trip.odometer_end
        
        if indexPath.row != trips.count - 1{
            if cell.startRangeLabel.text != trips[indexUp].odometer_end {
                cell.backgroundColor = #colorLiteral(red: 1, green: 0.8984109074, blue: 0.8925564463, alpha: 1)
            } else {
                cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
        cell.nameLabel.text = trip.persons
        cell.dateLabel.text  = trip.date
        cell.timeLabel.text  = trip.time
        
        if trip.gas == "1" {
            cell.lpgLabel.text = "G"
        }
        if trip.gasoline == "1" {
            cell.benzLabel.text = "B"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}




