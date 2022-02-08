//
//  ViewController.swift
//  location
//
//  Created by Ankit Rana on 08/02/22.




//# Xcode
//## Build generated
//build/
//DerivedData/
//## Various settings
//*.pbxuser
//xcuserdata/

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var lat : Double?
    var long :Double?
    var currentLocation: CLLocation!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()
                self.locationManager.requestWhenInUseAuthorization()
                if CLLocationManager.locationServicesEnabled() {
                    locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    locationManager.startUpdatingLocation()
                   
                }

    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
         let authStatus = manager.authorizationStatus
        if authStatus == .authorizedWhenInUse {
            currentLocation = locationManager.location
            self.lat = currentLocation.coordinate.latitude
            print(self.lat!)
            self.long = currentLocation.coordinate.longitude
            print(self.long!)
            locationManager.stopUpdatingLocation()
         }
        else if authStatus == .authorizedAlways
        {
            currentLocation = locationManager.location
            self.lat = currentLocation.coordinate.latitude
            print(self.lat!)
            self.long = currentLocation.coordinate.longitude
            print(self.long!)
            locationManager.stopUpdatingLocation()
        }
        else
        {
            print("Error")
        }
     }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          let userLocation:CLLocation = locations[0] as CLLocation
          let geocoder =  CLGeocoder()
          geocoder.reverseGeocodeLocation(userLocation) { (Placemarks , error) in
              if error != nil
              {
                  print("error in reverseGeocodeLocation ")
              }
              
              let placemark = Placemarks! as [CLPlacemark]
              
              if (placemark.count>0)
              {
                  let placemark = Placemarks![0]
                  let subthouhfair = placemark.subThoroughfare ?? ""
                  let throughfair = placemark.thoroughfare ?? ""
                  let sublocality = placemark.subLocality ?? ""
                  let localcity = placemark.locality ?? ""
                  let subadmistrativearea = placemark.subAdministrativeArea ?? ""
                  let  administrativearea =  placemark.administrativeArea ?? ""
                  let country = placemark.country ?? ""
                  let postalcode = placemark.postalCode ?? ""
                  let add  = "\(subthouhfair) \(throughfair) \(sublocality) \(localcity) \(subadmistrativearea) \(administrativearea) \(country) \(postalcode) "
                 print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\(add)")
              } }}
}

