//
//  PlacesVC.swift
//  FoursquareClone
//
//  Created by Ozan Çiçek on 27.11.2022.
//

import UIKit
import Parse

class PlacesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: UIBarButtonItem.Style.done, target: self, action: #selector(logOutClicked))
    }
    
    @objc func addButtonClicked(){
        //segue
    }
    
    @objc func logOutClicked(){
        PFUser.logOutInBackground{(error) in
            if error == nil {
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }else {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton =  UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            }
        }
    }
    


}
