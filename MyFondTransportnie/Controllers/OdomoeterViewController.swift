//
//  OdomoeterViewController.swift
//  MyFondTransportnie
//
//  Created by Mac on 02.01.2021.
//

import UIKit
import Photos
import Kingfisher

class OdomoeterViewController: UIViewController {
    
    var currentTrip: Trip?
    
    @IBOutlet weak var startImage: UIImageView!
    @IBOutlet weak var finishImage: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var endKmTf: UITextField!
    @IBOutlet weak var startKmTf: UITextField!
    @IBOutlet var probegTfCollection: [UITextField]!
    @IBOutlet var addPhotoBttn: [UIButton]!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    var pickStartImageBegin = false
    var pickEndImageBegin = false

    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.endKmTf.delegate = self
        self.startKmTf.delegate = self
        setupController()
        getCurrentTrip()
        setOdometerImage()
        print(currentTrip)
    }
    
    func setOdometerImage(){
        let endUrlString = currentTrip?.odometer_end_img_url
        let startUrlString = currentTrip?.odometer_start_img_url
        
        let processor = DownsamplingImageProcessor(size: startImage.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 20)
        startImage.kf.indicatorType = .activity

        if startUrlString != "" {
            let startUrl = URL(string: startUrlString!)
            DispatchQueue.main.async {
                self.startImage.kf.setImage(with: startUrl,options: [.processor(processor),
                                                                .scaleFactor(UIScreen.main.scale),
                                                                .transition(.fade(1)),
                                                                .cacheOriginalImage
                                                                ])
                }
            
        } else { print("Trip id: \(String(describing: currentTrip?.id)) has no start image urlSring") }
        
        if endUrlString != "" {
            let endUrl = URL(string: endUrlString!)
            finishImage.kf.setImage(with: endUrl, options: [.processor(processor),
                                                            .scaleFactor(UIScreen.main.scale),
                                                            .transition(.fade(1)),
                                                            .cacheOriginalImage
                                                            ])
        } else { print("Trip id: \(String(describing: currentTrip?.id)) has no finish image urlSring") }
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
    
    @IBAction func tapAnyWhere(_ sender: Any) {
        view.endEditing(true)
    }
    
    func setImage(){
        let images = [startImage, finishImage]
        let image = #imageLiteral(resourceName: "defaultOdometer")
        
        images.forEach { $0?.image = image
                        $0?.backgroundColor = #colorLiteral(red: 0.9202490482, green: 0.9202490482, blue: 0.9202490482, alpha: 1)
                        $0?.layer.cornerRadius = 12
        }
    }
    
    private func setupController(){
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = ["public.image"]
        addPhotoBttn.forEach {$0.layer.cornerRadius = 6}
        setImage()
        datePicker.setValue(UIColor.black, forKeyPath: "textColor")
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.setValue(UIColor.black, forKeyPath: "textColor")
            datePicker.setValue(false, forKeyPath: "highlightsToday")
          }
        
        probegTfCollection.forEach { $0.layer.borderColor = #colorLiteral(red: 0.9202490482, green: 0.9202490482, blue: 0.9202490482, alpha: 1)
            $0.backgroundColor = .white
            $0.layer.borderWidth = 2
            $0.borderStyle = .roundedRect
            $0.layer.cornerRadius = 6
            $0.attributedPlaceholder = NSAttributedString(string: "123456",
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
        
        endKmTf.keyboardType = .numberPad
        startKmTf.keyboardType = .numberPad

    }
    
    private func getCurrentTrip(){
        let tabBarVC = (self.tabBarController as! TabBarController).viewControllers![0] as! DescVC
        guard let trip = tabBarVC.currentTrip else {return}
        self.currentTrip = trip
        unwrapCurrentTrip()
    }
    
    private func unwrapCurrentTrip(){
        startKmTf.text = currentTrip!.odometer_start
        endKmTf.text = currentTrip!.odometer_end
        
        let dateString = (currentTrip!.date)! + " " + (currentTrip!.time)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.date(from: dateString)!
        datePicker.setDate(date, animated: true)
    }
}


extension OdomoeterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        print(info)
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        let JPEGimage = image.jpegData(compressionQuality: 0.3)
        let uiImage = UIImage(data: JPEGimage!)
        if pickStartImageBegin {
            startImage.image = uiImage
        } else if pickEndImageBegin {
            finishImage.image = uiImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
    
    func showActionSheet(){
        
        let galleryIcon = #imageLiteral(resourceName: "gallery")
        let cameraIcon = #imageLiteral(resourceName: "camera")

        
        let myActionSheet = UIAlertController(title: "", message: "Источник", preferredStyle: UIAlertController.Style.actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        let imageFromGalleryAction = UIAlertAction(title: "Выбрать из галереи", style: UIAlertAction.Style.default) { [self] action in
            imagePicker.sourceType = .photoLibrary
  
            present(imagePicker, animated: true, completion: nil)
        }
        imageFromGalleryAction.setValue(galleryIcon, forKey: "image")
        
        
        let imageFromCameraAction = UIAlertAction(title: "Сделать фото", style: UIAlertAction.Style.default) { [self] action in
            imagePicker.sourceType = .camera
            
            present(imagePicker, animated: true, completion: nil)
        }
        imageFromCameraAction.setValue(cameraIcon, forKey: "image")

        
        myActionSheet.addAction(imageFromGalleryAction)
        myActionSheet.addAction(imageFromCameraAction)
        myActionSheet.addAction(cancelAction)
        
        self.present(myActionSheet, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

