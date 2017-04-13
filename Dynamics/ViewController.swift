//
//  ViewController.swift
//  Dynamics
//
//  Created by Pierre Binon on 2017-04-13.
//  Copyright © 2017 Pierre Binon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let square = UIView (frame: CGRect (x: 100, y: 100, width: 100, height: 100))
        square.backgroundColor = UIColor.gray
        view.addSubview (square)
        
        let barrier = UIView (frame: CGRect (x: 0, y: 300, width: 130, height: 20))
        barrier.backgroundColor = UIColor.red
        view.addSubview (barrier)
        
        animator = UIDynamicAnimator (referenceView: view)
        gravity = UIGravityBehavior (items: [square])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior (items: [square])
        
        //Add a boundary that has the same frame as the barrier
        collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath (rect: barrier.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

