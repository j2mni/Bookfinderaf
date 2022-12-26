//
//  BookCell.swift
//  BookFinderWithAlamoFire
//
//  Created by lsy on 2022/11/03.
//

import UIKit

class BookCell: UITableViewCell {
    
    @IBOutlet weak var sw: UISwitch!
    @IBOutlet weak var Button: UIButton!
    @IBOutlet weak var thumnail: UIImageView!
    @IBOutlet weak var lbllabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
