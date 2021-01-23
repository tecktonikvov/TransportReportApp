//
//  OdomoeterViewController.swift
//  MyFondTransportnie
//
//  Created by Mac on 02.01.2021.
//

import UIKit
import Photos

class OdomoeterViewController: UIViewController {
    
    var tabBar: TabBarController!
    var currentTrip: Trip?{
        didSet{
           //If isEditing Trip
            if currentTrip?.id != nil {
                KingFisher.downloadOdometerImages(currentTrip: currentTrip!, startImageView: startImage, finishImageView: finishImage) //Get image from server
                insertData() //Fill fields
            }
        }
    }

    var pickStartImageBegin = false
    var pickEndImageBegin = false

    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar = (self.tabBarController as! TabBarController)
        
        endKmTf.delegate = self
        startKmTf.delegate = self
        
        currentTrip = tabBar!.currentTrip
        setupController()
        addDoneButtonOnKeyboard()
        
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        datePicker.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        
        dateFormatter.dateFormat = "HH:mm"
        let selectedTime = dateFormatter.string(from: datePicker.date)
        
      //When we go away from this controller we must update Trip model which locate in TabBarController
        if currentTrip == nil {
            tabBar!.newTrip!.date = selectedDate
            tabBar!.newTrip!.time = selectedTime
            tabBar!.newTrip!.odometer_start = startKmTf.text!
            tabBar!.newTrip!.odometer_end = endKmTf.text!
            print(tabBar!.newTrip)
        }
    }
    
    @IBAction func addStartImageAction(_ sender: UIButton) {
        pickStartImageBegin = true
        pickEndImageBegin = false
        choiseImageSource()
    }
    
    @IBAction func addEndImageAction(_ sender: UIButton) {
        pickStartImageBegin = false
        pickEndImageBegin = true
        choiseImageSource()
    }
    
    @IBAction func tapAnyWhere(_ sender: Any) {
        view.endEditing(true)
    }
    
    private func setupController(){
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = ["public.image"]
        addPhotoBttn.forEach {$0.layer.cornerRadius = 6}
        
        let images = [startImage, finishImage]
        let image = #imageLiteral(resourceName: "defaultOdometer")
        
        images.forEach { $0?.image = image
                        $0?.backgroundColor = #colorLiteral(red: 0.9202490482, green: 0.9202490482, blue: 0.9202490482, alpha: 1)
                        $0?.layer.cornerRadius = 12
        }
    //This is need in order to hide the error.
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
    
    private func insertData(){
        endKmTf.text = currentTrip!.odometer_end
        startKmTf.text = currentTrip!.odometer_start
        
        let dateString = (currentTrip!.date)! + " " + (currentTrip!.time)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.date(from: dateString)!
        
        datePicker.setDate(date, animated: true)
    }
    
//Add to number keyboard "Done" button
    func addDoneButtonOnKeyboard(){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

            endKmTf.inputAccessoryView = doneToolbar
            startKmTf.inputAccessoryView = doneToolbar
        }
//Dissmiss keyboard when "Done" button pressed
        @objc func doneButtonAction(){
            startKmTf.resignFirstResponder()
            endKmTf.resignFirstResponder()
        }
    
    //MARK: - Outlets
        @IBOutlet weak var startImage: UIImageView!
        @IBOutlet weak var finishImage: UIImageView!
        @IBOutlet weak var datePicker: UIDatePicker!
        @IBOutlet weak var endKmTf: UITextField!
        @IBOutlet weak var startKmTf: UITextField!
        @IBOutlet var probegTfCollection: [UITextField]!
        @IBOutlet var addPhotoBttn: [UIButton]!
        @IBOutlet weak var scrollView: UIScrollView!
        @IBOutlet weak var contentView: UIView!
}

//MARK: - Extensions
extension OdomoeterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
//MARK: - ImagePickerController Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
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
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
//        picker.dismiss(animated: true, completion: nil)
//    }
  
    func choiseImageSource(){
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
    
//MARK: - TextField Delagate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

