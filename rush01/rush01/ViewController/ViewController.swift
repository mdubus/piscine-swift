//
//  ViewController.swift
//  rush01
//
//  Created by Morgane DUBUS on 4/6/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var transportTypeBar: UISegmentedControl!
    var locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    var departure: CLLocationCoordinate2D?
    var arrival: CLLocationCoordinate2D?
    var transportType:MKDirectionsTransportType = .automobile
    var directionRequest: MKDirectionsRequest!
    
    // Setup
    func setupLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        mapView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transportTypeBar.isHidden = true
        self.setupLocation()
    }
    
    // Zoom on specific location
    func zoomOnLocation(location:CLLocationCoordinate2D) {
        var mapRegion = MKCoordinateRegion()
        mapRegion.center = location
        mapRegion.span.latitudeDelta = 0.01;
        mapRegion.span.longitudeDelta = 0.01;
        mapView.setRegion(mapRegion, animated: true)
    }
    
    @IBAction func changeTransportType(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            print("auto")
            self.transportType = .automobile
        case 1:
            print("walk")
            self.transportType = .walking
        default:
            print("default")
            self.transportType = .automobile
        }
        if (arrival != nil)
        {
            traceRoute()
        }
    }
    
    func manageError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func traceRoute () {
        directionRequest.transportType = transportType
        let directions = MKDirections(request: self.directionRequest)
        
        directions.calculate { response, error in
            
            guard let response = response else {
                if let error = error {
                    self.manageError("T'es trop ambitieux mon coco")
                }
                return
            }
            
            print(response)
            let route = response.routes[0]
            self.mapView.removeOverlays(self.mapView.overlays)
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)

            var rect = route.polyline.boundingMapRect
            rect.size.height *= 1.2
            rect.size.width *= 1.2
            rect.origin.x -= (rect.size.width * 0.1)
            rect.origin.y -= (rect.size.height * 0.1)
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        switch transportType {
        case .automobile:
            renderer.strokeColor = .blue
        case .walking:
            renderer.strokeColor = .green
        default:
            renderer.strokeColor = .gray
        }
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    func setPath () {
        transportTypeBar.isHidden = false
        guard let departPoint  = departure else {return}
        guard let arrivalPoint = arrival else {return}
        let sourcePlacemark = MKPlacemark(coordinate: departPoint)
        let destinationPlacemark = MKPlacemark(coordinate: arrivalPoint)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Départ"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Arrivée"
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        
        self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        
        traceRoute()
    }
    
    func setPin () {
        transportTypeBar.isHidden = true
        let annotation = MKPointAnnotation()
        annotation.coordinate = departure!
        mapView.addAnnotation(annotation)
        zoomOnLocation(location: departure!)
    }
    
    func setLocations() {
        self.mapView.removeOverlays(self.mapView.overlays)
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        if (self.arrival == nil) {
            setPin()
        }
        else {
            setPath()
        }
    }
    @IBAction func changeMapStyle(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 1:
            mapView.mapType = MKMapType.satellite
        case 2:
            mapView.mapType = MKMapType.hybrid
        default:
            mapView.mapType = MKMapType.standard
        }
    }
    
    @IBAction func unwindSegue(segue:UIStoryboardSegue){
        locationManager.stopUpdatingLocation()
        setLocations()
        print("unwind segue")
        print("Arrival : \(arrival)")
        print("Departure : \(departure)")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "locationSegue"{
            let controller = segue.destination as! SearchViewController
            
            controller.locationManager = locationManager
        }
    }
    
     // Get user's location and zoom on it
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        zoomOnLocation(location: locValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


