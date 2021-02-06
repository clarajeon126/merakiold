//
//  PostTableViewCell.swift
//  Meraki
//
//  Created by Clara Jeon on 2/4/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHeadlineLabel: UILabel!
    @IBOutlet weak var titleOfPostLabel: UILabel!
    @IBOutlet weak var contentOfPostLabel: UILabel!
    @IBOutlet weak var imageOfContent: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
