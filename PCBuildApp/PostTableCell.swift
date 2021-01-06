//
//  PostTableCell.swift
//  PCBuildApp
//
//  This class will be used to define a post/deal on the deal list
//  containing the title of the post as well as the url
//
//  Created by GusMando on 10/31/20.
//  Copyright © 2020 Agustin Gomez. All rights reserved.
//
import UIKit

class PostTableCell: UITableViewCell
{
    
    @IBOutlet weak var urlText: UILabel!
    @IBOutlet weak var titleText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
