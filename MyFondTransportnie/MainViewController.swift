////
////  ViewController.swift
////  MyFondTransportnie
////
////  Created by Mac on 08.12.2020.
////
//
//import UIKit
//import CoreData
//
//class ViewController: UIViewController {
//    
//    static var shared = ViewController()
//    
//    enum VCState {
//        case nonAuthorise
//        case fetchengData
//        case normal
//        case fatalError(String)
//        case toDefaultSettings
//    }
//    
//    @IBOutlet weak var logoutButn: UIBarButtonItem!
//    @IBOutlet weak var tableView: UITableView!
//    
//        
//    var users = [User]() {
//        didSet{
//            print(users)
//        }
//    }
//    
//    var trips = [Trip]() {
//        didSet {
//            trips.sort(by: { Int($0.odometer_start!)! > Int($1.odometer_start!)! })
//            //tableView.reloadData()
//            print(view.subviews)
//            //print(trips)
//        }
//    }
//    
//    var state: VCState {
//        get{
//            return self.state
//        }
//        set(v){
//            self.setState(state: v)
//        }
//    }
//    
//    
////    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
////            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Trip")
////            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
////            let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
////           // frc.delegate = self
////            return frc
////        }()
//    
//    func fetchTripsFromCoreData(){
//        ModelController.getTripsFromCoreData()
//    }
//        
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        do {
////                    try self.fetchedhResultController.performFetch()
////            print("COUNT FETCHED FIRST: \(String(describing: self.fetchedhResultController.sections?[0].numberOfObjects))")
////                } catch let error  {
////                    print("ERROR: \(error)")
////                }
//        
//        setState(state: .nonAuthorise)
//        CoreDataStack.sharedInstance.applicationDocumentsDirectory() // выводит в консоль директорию CoreData
//        
//    }
//    
//    @IBAction func logoutAction(_ sender: Any) {
//        UserSettings.userModel = nil
//        trips = [Trip]()
//        tableView.reloadData()
//        setState(state: .nonAuthorise)
//    }
//    
//    func setState(state: VCState){
//        switch state{
//        case .nonAuthorise:
//            if UserSettings.userModel?.userName == nil {
//                showAthorizeAlert()
//            } else {
//                setState(state: .fetchengData)
//            }
//            self.logoutButn.isEnabled = false
//            
//        case .fetchengData:
//            gus(setState: .show)
//            ModelController.getTripsFromAPI(VC: self)
//            fetchTripsFromCoreData()
//            ModelController.getUsersFromAPI(VC: self)
//            
//        case .normal:
//            gus(setState: .hide)
//            self.logoutButn.isEnabled = true
//            //print(tableView)
//
//        case .toDefaultSettings:
//            break
//        case .fatalError(let massage):
//            showCustomAlert(title: "Ну ничего, страшного", message: massage)
//            break
//            
//        }
//    }
//}
//
//extension  ViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return trips.count
//    }
//
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell") as! TripTableViewCell
//        let trip = trips[indexPath.row]
//        cell.benzLabel.text = ""
//        cell.lpgLabel.text = ""
//        let indexUp = indexPath.row + 1
//        
//        cell.nameLabel.text = prepareAbbrevString(trip: trip)
//        cell.startRangeLabel.text = trip.odometer_start
//        cell.endRangeLabel.text = trip.odometer_end
//
//        if indexPath.row != trips.count - 1{
//            if cell.startRangeLabel.text != trips[indexUp].odometer_end {
//                cell.backgroundColor = #colorLiteral(red: 1, green: 0.8984109074, blue: 0.8925564463, alpha: 1)
//            } else {
//                cell.backgroundColor = #colorLiteral(red: 0.973625228, green: 0.9854542545, blue: 1, alpha: 1)
//            }
//        }
//        
//        cell.dateLabel.text  = trip.date
//        cell.timeLabel.text  = trip.time
//        
//        if trip.refull == "1" {
//            if trip.fuel == "1" { // This is A-95
//                cell.benzLabel.text = "A-95"
//            } else {
//                cell.lpgLabel.text = "LPG"
//            }
//        }
//
//        return cell
//    }
//}
//
//
//
