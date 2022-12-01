//
//  MapVC.swift
//  FoursquareClone
//
//  Created by Ozan Çiçek on 27.11.2022.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var MAPviEW: MKMapView!
    
    

    var locationManager = CLLocationManager()
    var choosenLatitude = ""
    var choosenLongitude = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.done, target: self, action: #selector(save))
        
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "<Back", style: UIBarButtonItem.Style.done, target: self, action: #selector(back))
        
        MAPviEW.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation))
        recognizer.minimumPressDuration = 2
        MAPviEW.addGestureRecognizer(recognizer)
        


    }
    
    
    @objc func chooseLocation(gestureRecognizer: UIGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            let touches = gestureRecognizer.location(in: self.MAPviEW)
            let coordinates = self.MAPviEW.convert(touches, toCoordinateFrom: self.MAPviEW)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            
            self.MAPviEW.addAnnotation(annotation)
            
            self.choosenLatitude = String(coordinates.latitude)
            self.choosenLongitude = String(coordinates.longitude)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //locationManager.stopUpdatingLocation()
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: location, span: span)
        MAPviEW.setRegion(region, animated: true)
    }
    
    @objc func save(){
        //code
    }
        
    @objc func back(){
        self.dismiss(animated: true)
    }
    


}
