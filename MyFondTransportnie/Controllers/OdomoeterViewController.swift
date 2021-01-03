//
//  OdomoeterViewController.swift
//  MyFondTransportnie
//
//  Created by Mac on 02.01.2021.
//

import UIKit
import Photos

class OdomoeterViewController: UIViewController {
    
    @IBOutlet var addPhotoBttn: [UIButton]!
    @IBOutlet weak var startImage: UIImageView!
    @IBOutlet weak var finishImage: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var pickStartImageBegin = false
    var pickEndImageBegin = false

    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = ["public.image"]
        addPhotoBttn.forEach {$0.layer.cornerRadius = 6}
        setImage()
        datePicker.setValue(UIColor.black, forKeyPath: "textColor")
        datePicker.setValue(false, forKeyPath: "highlightsToday")
        print(datePicker)


        
    }
    
    @IBAction func addStartImageAction(_ sender: UIButton) {
        pickStartImageBegin = true
        pickEndImageBegin = false
        showActionSheet()
    }
    
    @IBAction func addEndImageAction(_ sender: UIButton) {
        pickStartImageBegin = false
        pickEndImageBegin = true
        showActionSheet()
    }
    
    func setImage(){
        let images = [startImage, finishImage]
        let image = #imageLiteral(resourceName: "defaultOdometer")
        
        images.forEach { $0?.image = image
                        $0?.backgroundColor = #colorLiteral(red: 0.9202490482, green: 0.9202490482, blue: 0.9202490482, alpha: 1)
                        $0?.layer.cornerRadius = 12
        }
//
//        startImage.image = image
//        startImage.backgroundColor = #colorLiteral(red: 0.9202490482, green: 0.9202490482, blue: 0.9202490482, alpha: 1)
//        startImage.layer.cornerRadius = 12
    }
}


extension OdomoeterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        print(info)
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        if pickStartImageBegin {
            startImage.image = image
        } else if pickEndImageBegin {
            finishImage.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
    
    func showActionSheet(){
        
        let myActionSheet = UIAlertController(title: "", message: "Источник", preferredStyle: UIAlertController.Style.actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        let imageFromGalleryAction = UIAlertAction(title: "Выбрать из галереи", style: UIAlertAction.Style.default) { [self] action in
            imagePicker.sourceType = .photoLibrary
  
            present(imagePicker, animated: true, completion: nil)
        }
        let imageFromCameraAction = UIAlertAction(title: "Сделать фото", style: UIAlertAction.Style.default) { [self] action in
            imagePicker.sourceType = .camera
            
            present(imagePicker, animated: true, completion: nil)
        }
        
        myActionSheet.addAction(imageFromGalleryAction)
        myActionSheet.addAction(imageFromCameraAction)
        myActionSheet.addAction(cancelAction)
        
        self.present(myActionSheet, animated: true, completion: nil)
    }
}
