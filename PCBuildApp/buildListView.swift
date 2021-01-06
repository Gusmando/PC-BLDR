//
//  buildListView.swift
//  PCBuildApp
//
//  This class will be used to manage the the table view for build and serves as
//  the main receptor of core data through utilization of the buildModel.
//
//  Created by GusMando on 11/7/20.
//  Copyright © 2020 Agustin Gomez. All rights reserved.
//

import UIKit
import CoreData
class buildListView: UIViewController, UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    @IBOutlet weak var buildTable: UITableView!
    
    //Vars used for the build model and coredata management
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var buildMod:buildModel?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Loading the build model to this view
        buildMod = buildModel(context: managedObjectContext)
    }
    
    //This function activates when the user does anything to cause
    //a segue to be utilized
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //Fetching selected build
        let selectedIndex: IndexPath = self.buildTable.indexPath(for: sender as! UITableViewCell)!
        
        //Moving to the detail view/Individual build view
        if(segue.identifier == "toDetail")
        {
            if let viewController:BuildView = segue.destination as? BuildView
            {
                //Setting the current build on the build view to the
                //selected build
                viewController.currBuild = buildMod!.fetchResults[selectedIndex.row]
            }
        }
    }
    
    //This function utilizes the model to find the count of builds
    //in core data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return buildMod!.fetchRecord()
    }
    
    //This function will be used to assign the information for each table cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //Fetching the current cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "buildCell", for: indexPath) as! buildTableCell
        cell.layer.borderWidth = 1.0
        
        //Assigning name an description for cell
        cell.buildName.text = buildMod!.fetchResults[indexPath.row].name
        cell.buildDesc.text = buildMod!.fetchResults[indexPath.row].desc
        
        //Checking if the core data results has an image and setting the
        //cell info to this image
        if let picture = buildMod?.fetchResults[indexPath.row].pic {
            cell.buildIM.image =  UIImage(data: picture  as Data)
        } else {
            cell.buildIM.image = nil
        }
        
        //Return the updated cell
        return cell
    }

    //Makes each row editible
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
       return true
    }

    //Makes each row deletable
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
   
    //Implementing the delete function.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
      
      if editingStyle == .delete
      {
          
          //Deleting the selected object from the
          //managed object context.
          buildMod!.managedObjectContext!.delete(buildMod!.fetchResults[indexPath.row])
        
          //Removing the deleted object from the fetch results
          buildMod!.fetchResults.remove(at:indexPath.row)
          
          do {
            //Saving the updated oibject context
            try buildMod!.managedObjectContext!.save()
          } catch {
              
          }
          //Reloading the table
          buildTable.reloadData()
      }
      
    }
    
    //This function will activate when the image is going to
    //appear
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        do
        {
        //Save the context when the view is coming back
        //in case of changes from the build view
        try self.buildMod!.managedObjectContext?.save()
        } catch _ {
        }
        //Relading the build table
        self.buildTable.reloadData()
    }
    
    //This function utilized when the chooser clicks the
    //+ icon and decides to add a new build
    @IBAction func addBuild(_ sender: Any)
    {
        //Alert has add and cancel buttons
        let alert = UIAlertController(title: "Add Build", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        //Text field for the name of the build
        alert.addTextField(configurationHandler:
            {
                textField in textField.placeholder = "Enter Name of Build Here"
            }
        )
        
        //Text field for the build description
        alert.addTextField(configurationHandler:
            {
                textField in textField.placeholder = "Enter Build Description"
            }
        )
        //Option to choose a picture for the build from the library
        alert.addAction(UIAlertAction(title: "Choose Pic From Library", style: .default, handler:
            {
                action in
                
                //When the name has been filled in
                if var name = alert.textFields?.first?.text
                {
                    if(name != "")
                    {
                        //Create the build object and add to model
                        let description = alert.textFields![1].text!
                        name = name.capitalized
                        self.buildMod!.addARecord(name: name, info: description)
                        self.buildTable.reloadData()
                        self.buildMod!.newestBuild = name
                        
                        //Create the Image Picker object
                        let photoPicker = UIImagePickerController ()
                        photoPicker.delegate = self
                        photoPicker.sourceType = .photoLibrary
                        //Display image selection view
                        self.present(photoPicker, animated: true, completion: nil)
                    }
                }
            }
        ))
        //Option to take a picture for the build using the camera
        alert.addAction(UIAlertAction(title: "Take a New Pic", style: .default, handler:
            {
                action in
                
                if var name = alert.textFields?.first?.text
                {
                    if(name != "")
                    {
                        //Create the build object and add to model
                        let description = alert.textFields![1].text!
                        name = name.capitalized
                        self.buildMod!.addARecord(name: name, info: description)
                        self.buildTable.reloadData()
                        self.buildMod!.newestBuild = name
                        
                        //Create the Image Picker object
                        let photoPicker = UIImagePickerController ()
                        photoPicker.delegate = self
                        photoPicker.sourceType = .camera
                        // display image selection view
                        self.present(photoPicker, animated: true, completion: nil)
                    }
                }
            }
        ))
        
        self.present(alert,animated: true,completion: nil)
        
        //Save the updated context with the new build added
        do {
            try self.buildMod!.managedObjectContext?.save()
        } catch _ {
        }
        self.buildTable.reloadData()
    }
    
    //This function utlized when the user chooses the trash
    //icon, allowing for the deletion of a searched build
    @IBAction func deleteBuild(_ sender: Any)
    {
        //Remove and cancel buttons for the alert
        let alerts = UIAlertController(title: "Remove Build", message: nil, preferredStyle: .alert)
        alerts.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alerts.addTextField(configurationHandler:
            {
                textField in textField.placeholder = "Enter Name of Build Here"
            }
        )
        
        //Upon choosing the ok button
        alerts.addAction(UIAlertAction(title: "OK", style: .default, handler:
            {
                action in
                
                //Deleting the record from the model and reloading
                //the table
                if let name = alerts.textFields?.first?.text
                {
                    self.buildMod!.deleteRecord(name: name)
                    self.buildTable.reloadData()
                }
            }
        ))
        
        self.present(alerts,animated: true)
    }
    
    //Function for showing the image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        picker .dismiss(animated: true, completion: nil)
        
        //Because this function is always used after adding a new build,
        //fetching the latest index to modify image
        let lastIndex = buildMod!.searchResults(name: buildMod!.newestBuild!)
        
        //Grabbing the build associated with the index
        if let build = buildMod?.fetchResults[lastIndex], let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            //Grabs image which was selected
            build.pic = image.pngData()! as NSData
            
            //Setting the model image to the selected image
            do {
                try buildMod!.managedObjectContext!.save()
                //Reloading the table
                self.buildTable.reloadData()
            } catch {
                print("Error while saving the new image")
            }
            
        }
        
     }
    
}
