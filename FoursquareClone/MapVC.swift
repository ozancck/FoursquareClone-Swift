//
//  MapVC.swift
//  FoursquareClone
//
//  Created by Ozan Çiçek on 27.11.2022.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    @IBOutlet weak var MAPviEW: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.done, target: self, action: #selector(save))
        
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "<Back", style: UIBarButtonItem.Style.done, target: self, action: #selector(back))
        
    }
    
    @objc func save(){
        //code
    }
        
    @objc func back(){
        self.dismiss(animated: true)
    }
    


}
