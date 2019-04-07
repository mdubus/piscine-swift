//
//  SearchViewController.swift
//  rush01
//
//  Created by Morgane DUBUS on 4/6/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController{
    
    @IBOutlet weak var switchArrow: UIButton!
    @IBOutlet weak var arrivalTextField: UITextField!
    @IBOutlet weak var departureTextField: UITextField!
    let geoCoder = CLGeocoder()
    var arrival: CLLocationCoordinate2D?
    var departure: CLLocationCoordinate2D?
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LocationManager \(String(describing: locationManager))")
        toggleVisibility(true)
    }
    
    func manageError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func itineraryButton(_ sender: UIButton) {
            toggleVisibility(false)
            sender.setTitle("Destination", for: .normal)
            sender.setTitleColor(.black, for: .normal)
    }
    
    func toggleVisibility(_ isHidden: Bool){
        
        arrivalTextField.isHidden = isHidden
        switchArrow.isHidden = isHidden
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func useCurrentLocation(_ sender: UIButton) {
        guard let location = self.locationManager?.location else {self.manageError("Votre position ne s'est pas encore mise à jour"); return}
        self.geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if ((error) != nil) {
                self.manageError("Adresse incorrecte")
            }
            guard let marks = placemarks?[0] else { self.manageError("No location found"); return }
            guard let addressName = marks.name else {self.manageError("No address found"); return}
            guard let postalCode = marks.postalCode else {self.manageError("No postalCode found"); return}
            guard let locality = marks.locality else {self.manageError("No locality found"); return}
            print(marks)
            print("name : ",addressName)
            print("postalCode : ",postalCode)
            print("locality : ",locality)
            self.departureTextField.text = "\(addressName) \(postalCode) \(locality)"
        }
    }
    
    @IBAction func swapDirections(_ sender: UIButton) {
        let tmp: String?
        
        tmp = arrivalTextField.text
        arrivalTextField.text = departureTextField.text
        departureTextField.text = tmp
    }
    
    func getCoordinates(_ address: String, _ completion: @escaping (CLLocationCoordinate2D) -> Void)
    {
        self.geoCoder.geocodeAddressString(address) { (placemarks, error) in
            if ((error) != nil) {
                self.manageError("Adresse incorrecte")
            }
            guard let marks = placemarks?[0] else { self.manageError("No location found"); return }
            guard let coord = marks.location?.coordinate else {self.manageError("No specific location found"); return }
            completion(coord)
        }
    }
    
    func searchUserPath(_ sender: Any) {
        getCoordinates(arrivalTextField.text!, {
            coord in
            self.arrival = coord
            self.getCoordinates(self.departureTextField.text!, {
                coord in
                self.departure = coord
                self.performSegue(withIdentifier: "searchData", sender: sender)
            })
        })
    }
    
    func showUserAddress(_ sender: Any) {
        getCoordinates(departureTextField.text!, {
            coord in
            self.departure = coord
            self.performSegue(withIdentifier: "searchData", sender: sender)
        })
    }
    
    @IBAction func goButton(_ sender: Any) {
            guard let departure = departureTextField.text?.trimmingCharacters(in: .whitespaces), departure.isEmpty == false else { self.manageError("departure missing"); return }
        
        let arrival = arrivalTextField.text?.trimmingCharacters(in: .whitespaces)
        if (arrival!.isEmpty) {
            showUserAddress(sender)
        }
        else {
            searchUserPath(sender)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "searchData") {
            guard let vc = segue.destination as? ViewController else { self.manageError("view controller missing"); return}
            vc.arrival = self.arrival
            vc.departure = self.departure
        }
    }
}
