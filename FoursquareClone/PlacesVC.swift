//
//  PlacesVC.swift
//  FoursquareClone
//
//  Created by Ozan Çiçek on 27.11.2022.
//

import UIKit
import Parse

class PlacesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var placeNameArray = [String]()
    var placeIdArray = [String]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: UIBarButtonItem.Style.done, target: self, action: #selector(logOutClicked))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDatFromParse()
    }
    
    
    func getDatFromParse(){
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground{(objects, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton =  UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            }else {
                if objects != nil {
                    
                    self.placeNameArray.removeAll()
                    self.placeIdArray.removeAll()
                    
                    for object in objects! {
                        if let placeName = object.object(forKey: "name") as? String {
                            if let placeId = object.objectId as? String {
                                self.placeNameArray.append(placeName)
                                self.placeIdArray.append(placeId)
                            }
                        }
                    }
                }
                
                self.tableView.reloadData()
                
                
            }
            
        }
        
        
        
    }
    
    @objc func addButtonClicked(){
        self.performSegue(withIdentifier: "toAddPlacesVC", sender: nil)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArray[indexPath.row]
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        
          let query = PFQuery(className: "Places")
          query.whereKey("objectId", equalTo: placeIdArray[indexPath.row])
          query.findObjectsInBackground{(objects, error) in
              for object in objects! {
                  object.deleteEventually()
              }
          }

        self.placeNameArray.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    


}
