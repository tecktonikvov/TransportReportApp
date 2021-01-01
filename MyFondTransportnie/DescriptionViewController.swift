//
//  DescriptionViewController.swift
//  MyFondTransportnie
//
//  Created by Mac on 25.12.2020.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    

 
    @IBOutlet weak var addITView: UIView!
    @IBOutlet weak var addItHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pickerConstrait: NSLayoutConstraint!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pickDateSW: UISwitch!
    @IBOutlet weak var addItSW: UISwitch!
    @IBOutlet weak var selectItPicker: UIPickerView!
    @IBOutlet weak var addTransSW: UISwitch!
    @IBOutlet weak var selectTransPicker: UIPickerView!
    @IBOutlet weak var addSomeOneSW: UISwitch!
    @IBOutlet weak var seleckSomeOnePicker: UIPickerView!
    @IBOutlet weak var addUndefinedItButtn: UIButton!
    @IBOutlet weak var addUndefinedTransButton: UIButton!
    @IBOutlet weak var addUndefinedSomeOneButton: UIButton!
    
    @IBAction func dateSW(_ sender: UISwitch) {
        if pickDateSW.isOn {
            print("dsfsdf")
            pickerConstrait.constant = 100
            view.updateConstraints()
            
        } else {
            pickerConstrait.constant = 0
            view.updateConstraints()

        }
    }
    
    @IBAction func addItSwAction(_ sender: Any) {
        if addItSW.isOn {
            addItHeightConstraint.constant = 140
        } else {
            //addItHeightConstraint.constant = 0
            UIView.animate(withDuration: 1) {
                self.addITView.frame.size.height = 0
            }
            //addITView.isHidden = true
            self.scrollView.layoutIfNeeded()
        }
    }
    @IBAction func addUndefinedItAction(_ sender: UIButton) {
    }
    
    @IBAction func addUndefinedTransAction(_ sender: UIButton) {
    }
    
    @IBAction func addUndefinedSomeOneAction(_ sender: UIButton) {
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+300)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: 375, height: 1200)
        pickDateSW.isOn = false
        
        //datePicker.isHidden = true
        //datePicker.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 0)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
