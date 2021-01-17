//
//  PointViewController.swift
//  MyFondTransportnie
//
//  Created by Mac on 08.01.2021.
//

import UIKit

class PointViewController: UIViewController {

    
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
        
    }
}

extension PointViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pointCell") as! PointViewCell
        
        return cell
    }
}
