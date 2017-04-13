//
//  ViewController.swift
//  Dynamics
//
//  Created by Pierre Binon on 2017-04-13.
//  Copyright © 2017 Pierre Binon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var barrierArray = [UIView]()
    
    //To use with the second square created
    var firstContact = false
    
    var square: UIView!
    var snap: UISnapBehavior!
    
    
    
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Square
        //let square = UIView (frame: CGRect (x: 100, y: 0, width: 50, height: 50))
        
        square = UIView (frame: CGRect (x: 100, y: 0, width: 50, height: 50))
        square.backgroundColor = UIColor.gray
        view.addSubview (square)
        
        
        //Several obstacles
        let barrier1 = UIView (frame: CGRect (x: 0, y: 100 , width: 40, height: 40))
        barrier1.backgroundColor = UIColor.red
        barrierArray.append(barrier1)
        
        let barrier2 = UIView (frame: CGRect (x: 70, y: 150 , width: 40, height: 40))
        barrier2.backgroundColor = UIColor.red
        barrierArray.append(barrier2)
        
        let barrier3 = UIView (frame: CGRect (x: 150, y: 220 , width: 40, height: 40))
        barrier3.backgroundColor = UIColor.red
        barrierArray.append(barrier3)
        
        let barrier4 = UIView (frame: CGRect (x: 270, y: 270 , width: 40, height: 40))
        barrier4.backgroundColor = UIColor.red
        barrierArray.append(barrier4)
        
        let barrier5 = UIView (frame: CGRect (x: 220, y: 350 , width: 40, height: 40))
        barrier5.backgroundColor = UIColor.red
        barrierArray.append(barrier5)
        
        let barrier6 = UIView (frame: CGRect (x: 180, y: 400 , width: 40, height: 40))
        barrier6.backgroundColor = UIColor.red
        barrierArray.append(barrier6)
        
        let barrier7 = UIView (frame: CGRect (x: 90, y: 480 , width: 40, height: 40))
        barrier7.backgroundColor = UIColor.red
        barrierArray.append(barrier7)
        
        let barrier8 = UIView (frame: CGRect (x: 0, y: 350 , width: 40, height: 40))
        barrier8.backgroundColor = UIColor.red
        barrierArray.append(barrier8)



        
        //Add the array elements to the view
        for case let element as UIView in barrierArray {
            view.addSubview(element)
        }
        
        
        animator = UIDynamicAnimator (referenceView: view)
        gravity = UIGravityBehavior (items: [square])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior (items: [square])
        collision.collisionDelegate = self
    
        
        collision.addBoundary(withIdentifier: "barrier1" as NSCopying, for: UIBezierPath (rect: barrier1.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        
        
        
        //Adds the trail to the falling square
        var updateCount = 0
        collision.action = {
            if (updateCount % 3 == 0) {
                let outline = UIView(frame: self.square.bounds)
                outline.transform = self.square.transform
                outline.center = self.square.center
                
                outline.alpha = 0.5
                outline.backgroundColor = UIColor.clear
                outline.layer.borderColor = self.square.layer.presentation()?.backgroundColor
                outline.layer.borderWidth = 1.0
                self.view.addSubview(outline)
            }
            
            updateCount += 1
        }
        
        
        
        
        collision.addBoundary(withIdentifier: "barrier2" as NSCopying, for: UIBezierPath (rect: barrier2.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        collision.addBoundary(withIdentifier: "barrier3" as NSCopying, for: UIBezierPath (rect: barrier3.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        collision.addBoundary(withIdentifier: "barrier4" as NSCopying, for: UIBezierPath (rect: barrier4.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        collision.addBoundary(withIdentifier: "barrier5" as NSCopying, for: UIBezierPath (rect: barrier5.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        collision.addBoundary(withIdentifier: "barrier6" as NSCopying, for: UIBezierPath (rect: barrier6.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        collision.addBoundary(withIdentifier: "barrier7" as NSCopying, for: UIBezierPath (rect: barrier7.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        collision.addBoundary(withIdentifier: "barrier8" as NSCopying, for: UIBezierPath (rect: barrier8.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)


        
        
//        collision.action = {
//            print ("\(NSStringFromCGAffineTransform(square.transform)) \(NSStringFromCGPoint (square.center))")
//        }
        
        
        
        //Makes the square bouncy
        let itemBehaviour = UIDynamicItemBehavior (items: [square])
        itemBehaviour.elasticity = 0.6
        animator.addBehavior (itemBehaviour)
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
        print("Boundary contact occurred - \(String(describing: identifier))")
        
        
        //Change of color of the square
        let collidingView = item as! UIView
        collidingView.backgroundColor = UIColor.yellow
        UIView.animate(withDuration: 0.3) {
            
            collidingView.backgroundColor = UIColor.gray
        }
        
//        //Add a second square
//        if (!firstContact) {
//            firstContact = true
//            
//            let square = UIView (frame: CGRect(x: 30, y: 0, width: 50, height: 50))
//            square.backgroundColor = UIColor.gray
//            view.addSubview (square)
//            
//            collision.addItem (square)
//            gravity.addItem (square)
//            
//            let attach = UIAttachmentBehavior (item: collidingView, attachedTo: square)
//            animator.addBehavior (attach)
//        }
    }
    
    //Creates user interaction
    func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
        if (snap != nil) {
            
            animator.removeBehavior (snap)
        }
        
        let touch = touches.anyObject() as! UITouch
        snap = UISnapBehavior (item: square, snapTo: touch.location(in: view))
        animator.addBehavior (snap)
    }

}

