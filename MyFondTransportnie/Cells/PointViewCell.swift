//
//  PointViewCell.swift
//  MyFondTransportnie
//
//  Created by Mac on 08.01.2021.
//

import UIKit

class PointViewCell: UITableViewCell {

    @IBOutlet weak var sityTF: UITextField!
    
    @IBOutlet weak var targetRuHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var numberTF: UITextField!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var gpsButton: UIButton!
    @IBOutlet weak var targetRuTF: UITextView!
    @IBOutlet weak var targetDeTF: UITextView!
    
    @IBOutlet weak var targetDeHeightConstraint: NSLayoutConstraint!
    @IBAction func gpsButtnPressed(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gpsButton.layer.cornerRadius = 6
        targetRuTF.layer.cornerRadius = 6
        numberTF.attributedPlaceholder = NSAttributedString(string: "№ Дома",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        streetTF.attributedPlaceholder = NSAttributedString(string: "Улица",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        sityTF.attributedPlaceholder = NSAttributedString(string: "Город",
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

