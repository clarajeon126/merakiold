//
//  FullBlockCustomView.swift
//  Meraki
//
//  Created by Clara Jeon on 1/31/21.
//

import UIKit

class FullBlockCustomView: UIView {


    @IBOutlet weak var stemIdentifier: UILabel!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    init(image: UIImage, labelIdentifier: String, mainTitle: String, subTitle: String, type: Int){
        
        let width = Double(UIScreen.main.bounds.width)
        
        let fourFiveOfWidth = width * 0.45
        let nineFiveOfWidth = width * 0.95
        
        //3 separate types of blocks
        if type == 1 {
            super.init(frame: CGRect(x: 0, y: 0, width: fourFiveOfWidth, height: fourFiveOfWidth))
        }
        else if type == 2{
            super.init(frame: CGRect(x: 0, y: 300, width: nineFiveOfWidth, height: fourFiveOfWidth))
        }
        else if type == 3{
            super.init(frame: CGRect(x: 0, y: 0, width: fourFiveOfWidth, height: nineFiveOfWidth))
        }
        else {
            super.init(frame: CGRect(x: 0, y: 0, width: nineFiveOfWidth, height: nineFiveOfWidth))
        }
        
        commonInit()
        
        stemIdentifier.text = labelIdentifier
        mainTitleLabel.text = mainTitle
        subTitleLabel.text = subTitle
        imageView.image = image

    }
        
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        commonInit()
    }

    func commonInit(){
        let viewFromXib = Bundle.main.loadNibNamed("FullBlock", owner: self, options: nil)![0] as! UIView
            
        viewFromXib.frame = self.bounds
        viewFromXib.layer.cornerRadius = 10
        addSubview(viewFromXib)
    }
}
