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
            UIView.animateWithDuration(0.35, delay: delay, options: .CurveEaseOut, animations: {
                armor.center.x -= self.view.bounds.width
                }, completion: nil)
            delay+=0.1
            
            let clearSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ArmorBuilderVC.swipedView(_:)))
            clearSwipe.direction = .Right
            armor.addGestureRecognizer(clearSwipe)
            armor.userInteractionEnabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func swipedView(sender: UISwipeGestureRecognizer){
        let senderTag = sender.view!.tag
        let clearedLabel = sender.view!.viewWithTag((senderTag + 6))
        
        UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseOut, animations: {
            for (var i = senderTag + 5; i > senderTag; i -= 1) {
                let currentLabel = sender.view!.viewWithTag(i)
                currentLabel!.hidden = true
            }
            sender.view!.center.x += (self.view.bounds.width / 1.25)
            }, completion: nil)
        
        UIView.animateWithDuration(0.4, delay: 0.35, options: .CurveEaseOut, animations: {
            clearedLabel!.hidden = false
            clearedLabel!.alpha = 1.0
            sender.view!.center.x -= (self.view.bounds.width / 1.25)
            }, completion: {
                (finished: Bool) -> Void in
                
                // 'Cleared' text fade out
                UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveLinear, animations: {
                    clearedLabel!.alpha = 0
                    }, completion: nil)
        })
    }
}
