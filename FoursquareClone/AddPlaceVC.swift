//
//  AddPlaceVC.swift
//  FoursquareClone
//
//  Created by Ozan Çiçek on 27.11.2022.
//

import UIKit

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var addPlacesLabel: UILabel!
    
    @IBOutlet weak var placeNameText: UITextField!
    
    @IBOutlet weak var placeTypeText: UITextField!
    
    @IBOutlet weak var descriptionText: UITextField!
    
    @IBOutlet weak var placeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Next", style: UIBarButtonItem.Style.done, target: self, action: #selector(nextTo))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.done, target: self, action: #selector(backTo))
        
        placeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
    
      
    }
    
    
    @objc func chooseImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info [.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    

    
    @objc func nextTo(){
        
        if placeNameText.text != "" && placeTypeText.text != "" && descriptionText.text != "" {
            
            if let choosenImage = placeImageView.image{
                
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeImage = choosenImage
                placeModel.placeDescription = descriptionText.text!
                placeModel.placeType = placeTypeText.text!
                placeModel.placeName = placeNameText.text!
                
            }
            
            self.performSegue(withIdentifier: "toMapVC", sender: nil)
        }else {
            
            let alert = UIAlertController(title: "Error", message: "Empty Title Box or No Image", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
            self.present(alert, animated: true)
            
        }
     
    }
    
    
    
    
    
    @objc func backTo(){
        self.dismiss(animated: true)
    }
    
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
