//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Ozan Çiçek on 11.11.2022.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let parseObject = PFObject(className: "Fruits")
//        parseObject["name"] = "banana"
//        parseObject["calories"] = 1030;
//
//        parseObject.saveInBackground{(succes, error ) in
//            if error != nil {
//                print(error?.localizedDescription)
//            }else {
//                print("updated")
//            }
//        }
        
        let query = PFQuery(className: "Fruits")
        
        query.whereKey("name", equalTo: "banana")
        query.findObjectsInBackground{(objects, error) in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                print(objects)
            }
        }
    
        
    }


}

