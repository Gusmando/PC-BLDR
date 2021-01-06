//
//  BuildTableCell.swift
//  PCBuildApp
//
//  This class utiilized to define an individual cell on the BuildTable,
//  enabling the referencing the information on each cell within the table
//  view itself.
//
//  Created by GusMando on 11/7/20.
//  Copyright © 2020 Agustin Gomez. All rights reserved.
//
import UIKit

class buildTableCell: UITableViewCell
{
    //Class vars pertain to UI elements
    @IBOutlet weak var buildIM: UIImageView!
    @IBOutlet weak var buildName: UILabel!
    @IBOutlet weak var buildDesc: UILabel!
    
    //Default table cell behavior
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    //Default table cell behavior
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
