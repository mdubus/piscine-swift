
//
//  ViewController.swift
//  d06
//
//  Created by Morgane DUBUS on 3/9/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//
import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var dynamicAnimator = UIDynamicAnimator()
    var gravity = UIGravityBehavior()
    var collision = UICollisionBehavior()
    var dynamicBehavior = UIDynamicBehavior()
    var itemBehaviour = UIDynamicItemBehavior()
    var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior(items: [])
        collision = UICollisionBehavior(items: [])
        itemBehaviour = UIDynamicItemBehavior(items: [])
        
        gravity.magnitude = 2
        collision.translatesReferenceBoundsIntoBoundary = true
        
        dynamicAnimator.addBehavior(gravity)
        dynamicAnimator.addBehavior(collision)
        dynamicAnimator.addBehavior(itemBehaviour)
        
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: handleAccelerometer)
        }
    }
    func handleAccelerometer(data: CMAccelerometerData?, error: Error?) {
        guard let d = data else { return }
        print(d.acceleration.x)
        print(d.acceleration.y)
        self.view.center = CGPoint(x: d.acceleration.x, y: d.acceleration.y)
    }
    
    func addEffects(item: UIView) {
        gravity.addItem(item)
        collision.addItem(item)
        itemBehaviour.addItem(item)
        itemBehaviour.elasticity = 0.6
    }
    
    func removeEffects(item: UIView) {
        gravity.removeItem(item)
        collision.removeItem(item)
        itemBehaviour.removeItem(item)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer)
    {
        guard let item = sender.view else {print("Error"); return}
        switch (sender.state) {
        case .began :
            break
        case  .changed :
            removeEffects(item:item)
            
            item.center = sender.location(in: item.superview)
            dynamicAnimator.updateItem(usingCurrentState: item)
            
            addEffects(item:item)
        case .ended :
            break
        case .possible, .cancelled, .failed:
            print("Error") ; return
        }
    }
    
    
    @objc func handlePinch(sender: UIPinchGestureRecognizer){
        guard let item = sender.view else {print("Error"); return}
        switch(sender.state) {
        case .began:
            break;
        case .changed :
            removeEffects(item:item)
            
            item.layer.bounds.size.width *= sender.scale
            item.layer.bounds.size.height *= sender.scale
            if (item.layer.cornerRadius != 0) {
                item.layer.cornerRadius *= sender.scale
            }
            sender.scale = 1.0
            
            addEffects(item:item)
        case .ended :
            break;
        case .possible, .cancelled, .failed:
            print("Error") ; return
        }
    }
    
    @objc func handleRotation(sender: UIRotationGestureRecognizer) {
        guard let item = sender.view else {print("Error"); return}
        switch(sender.state) {
        case .began:
            break
        case .changed :
            removeEffects(item:item)
            
            item.transform = CGAffineTransform.init(rotationAngle: sender.rotation)
            
            addEffects(item:item)
        case .ended :
            break
        case .possible, .cancelled, .failed:
            print("Error") ; return
        }
    }
    
    
    func addGestures(item: UIView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(sender:)))
        item.addGestureRecognizer(panGesture)
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.handlePinch(sender:)))
        item.addGestureRecognizer(pinchGesture)
        let rotationGestion = UIRotationGestureRecognizer(target: self, action: #selector(ViewController.handleRotation(sender:)))
        item.addGestureRecognizer(rotationGestion)
    }
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        let frame = CGRect(x: location.x - (DIMENSION / 2), y: location.y - (DIMENSION / 2), width:DIMENSION, height:DIMENSION)
        let item = ShapeView(frame: frame)
        item.isUserInteractionEnabled = true
        item.clipsToBounds = true
        view.addSubview(item)
        
        addEffects(item:item)
        addGestures(item: item)
    }
}


