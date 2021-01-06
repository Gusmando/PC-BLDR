//
//  DealView.swift
//  PCBuildApp
//
//  This class will contain information regarding the part selection view
//  for slecting a part category to show deals for.
//
//  Created by GusMando on 10/31/20.
//  Copyright © 2020 Agustin Gomez. All rights reserved.
//
import UIKit
class DealView: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //This function will pass information to the deal list view utilizing
    //the activation of a segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //If any of the buttons are selected
        if(segue.identifier == "toDealList")
        {
            let butt = sender as! UIButton
            
            if let viewController: PostTableController = segue.destination as?
            PostTableController
            {
                //Creating new title based on the selected part type
                let newTit = butt.titleLabel!.text! + " Deals"
                viewController.top = newTit
                
                //Depending on the selected part type, a different set of part information will be shown
                //to the user on the deal list view
                if(butt.titleLabel!.text == "Storage")
                {
                    viewController.partType = "https://api.reddit.com/r/buildapcsales/search?q=flair:%22HDD"
                }
                else if(butt.titleLabel!.text == "Graphics")
                {
                    viewController.partType = "https://api.reddit.com/r/buildapcsales/search?q=flair:%22GPU";
                }
                else if(butt.titleLabel!.text == "Processor")
                {
                    viewController.partType = "https://api.reddit.com/r/buildapcsales/search?q=flair:%22CPU";
                }
                else if(butt.titleLabel!.text == "Mother Board")
                {
                    viewController.partType = "https://api.reddit.com/r/buildapcsales/search?q=flair:%22MOBO";
                }
                else if(butt.titleLabel!.text == "Memory")
                {
                    viewController.partType = "https://api.reddit.com/r/buildapcsales/search?q=flair:%22RAM";
                }
                else if(butt.titleLabel!.text == "Power Supply")
                {
                    viewController.partType = "https://api.reddit.com/r/buildapcsales/search?q=flair:%22PSU";
                }
                else if(butt.titleLabel!.text == "Operating System")
                {
                    viewController.partType = "https://www.reddit.com/r/buildapcsales/search/.json?q=%5BOS%5D&restrict_sr=1";
                }
                else if(butt.titleLabel!.text == "Case")
                {
                    viewController.partType = "https://api.reddit.com/r/buildapcsales/search?q=flair:%22CASE";
                }
            }
        }
    }
}
