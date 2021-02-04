//
//  OpportunityViewController.swift
//  Meraki
//
//  Created by Clara Jeon on 1/27/21.
//

import UIKit

//Designables for conveinience in storyboard
@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
class OpportunityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let fullBlock = FullBlockCustomView(image: UIImage(named: "robot")!, labelIdentifier: "Engineering", mainTitle: "Robotics Summer Camp", subTitle: "Join other females in stem and learn about the Design Process, Engineering Process, and the Business model", type: 2)
        
        fullBlock.layer.cornerRadius = 20
        
        view.addSubview(fullBlock)
        
    }

}
