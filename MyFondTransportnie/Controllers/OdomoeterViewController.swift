//
//  OdomoeterViewController.swift
//  MyFondTransportnie
//
//  Created by Mac on 02.01.2021.
//

import UIKit

class OdomoeterViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func addStartImageAction(_ sender: UIButton) {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func addEndImageAction(_ sender: UIButton) {
    }
    
    @IBOutlet var addPhotoBttn: [UIButton]!
    @IBOutlet weak var startImage: UIImageView!
    @IBOutlet weak var finishImage: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        addPhotoBttn.forEach {$0.layer.cornerRadius = 6}
        // Do any additional setup after loading the view.
    }
    

}

extension OdomoeterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        print(info)
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        startImage.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
}
