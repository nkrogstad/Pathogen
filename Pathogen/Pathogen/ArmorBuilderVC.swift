//
//  ArmorBuilderVC.swift
//  Pathogen
//
//  Created by Nick Krogstad on 7/31/16.
//  Copyright © 2016 Pathogen. All rights reserved.
//

import UIKit

class ArmorBuilderVC: UIViewController {
    
    // MARK: Properties
    @IBOutlet var armorBackgrounds : [UIView]!
    var delay : Double = 1.0
    let swipe_clear = UISwipeGestureRecognizer()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        for armor in armorBackgrounds {
            armor.center.x += view.bounds.width
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for armor in armorBackgrounds {
            UIView.animateWithDuration(0.5, delay: delay, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                armor.center.x -= self.view.bounds.width
                }, completion: nil)
            delay+=0.2
            swipe_clear.addTarget(self, action: "swipedView")
            armor.addGestureRecognizer(swipe_clear)
            armor.userInteractionEnabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func swipedView(){
        let tapAlert = UIAlertController(title: "Swiped", message: "You just swiped the swipe view", preferredStyle: UIAlertControllerStyle.Alert)
        tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
        self.presentViewController(tapAlert, animated: true, completion: nil)
    }
}
