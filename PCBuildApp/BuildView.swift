//
//  BuildView.swift
//  PCBuildApp
//
//  This class drives the Build List view for each user-created
//  build and ensures that core data is updated upon the changing
//  of any text fields.
//
//  Created by GusMando on 11/8/20.
//  Copyright © 2020 Agustin Gomez. All rights reserved.
//

import UIKit
class BuildView: UIViewController
{
    
    //UI elements for each text field for build info
    //as well as an image for each build
    @IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var storage: UITextField!
    @IBOutlet weak var graphics: UITextField!
    @IBOutlet weak var processor: UITextField!
    @IBOutlet weak var motherboard: UITextField!
    @IBOutlet weak var ram: UITextField!
    @IBOutlet weak var power: UITextField!
    @IBOutlet weak var operating: UITextField!
    @IBOutlet weak var cse: UITextField!
    @IBOutlet weak var navBar: UINavigationItem!
    var currBuild:Builds?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Setting all fields to the currBuild information
        //which should update depending on which build was
        //selected on Build List View
        navBar.title = currBuild!.name
        storage.text = currBuild!.stor
        graphics.text = currBuild!.graph
        processor.text = currBuild!.cpu
        motherboard.text = currBuild!.moth
        ram.text = currBuild!.mem
        power.text = currBuild!.psu
        operating.text = currBuild!.os
        cse.text = currBuild!.cas
        picView.image = UIImage(data: currBuild!.pic! as Data)
    }
    
    //Function when moving away from the current build
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent
        {
            //Copies the information from the
            //text fields to the core data object
            currBuild!.stor = storage.text!
            currBuild!.graph = graphics.text!
            currBuild!.cpu = processor.text!
            currBuild!.moth = motherboard.text!
            currBuild!.mem = ram.text!
            currBuild!.psu = power.text!
            currBuild!.os = operating.text!
            currBuild!.cas = cse.text!
        }
    }
}
