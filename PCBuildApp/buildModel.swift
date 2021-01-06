//
//  buildModel.swift
//  PCBuildApp
//
//  This class contains the buildModel for holding and modifying
//  core data information.
//
//  Created by Gus Man on 11/8/20.
//  Copyright © 2020 Agustin Gomez. All rights reserved.
//

import Foundation
import CoreData
public class buildModel{
    
    let managedObjectContext:NSManagedObjectContext?
    var fetchResults = [Builds]()
    var counter = 1
    var newestBuild:String?
    
    init(context: NSManagedObjectContext)
    {
        //Getting a handler to managed object context
        managedObjectContext = context
        initCounter()
    }
    
    //This function utilized to fetch the count of
    //core data managed objects
    func fetchRecord() ->Int
    {
        //Create a new fetch request using the Builds Entity from core data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Builds")
        //Sorting the NS data information by the name of the builds
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        var x = 0
        //Execute the fetch request, and cast the results to an array of Builds objects
        fetchResults = ((try? managedObjectContext?.fetch(fetchRequest)) as? [Builds])!
        x = fetchResults.count
        
        //Return the number of entities in core data
        return x
    }
    
    //This function used for adding a record to core data
    //based on passed build name and build infoi strings
    func addARecord(name:String,info:String)
    {
        
        //Create a new entity object
        let ent = NSEntityDescription.entity(forEntityName: "Builds", in:managedObjectContext!)
        //Add to the manege object context
        let newItem = Builds(entity: ent!, insertInto: managedObjectContext!)
        
        //Setting the information fo the new item
        newItem.name = name
        newItem.desc = info
        newItem.pic = nil
        
        updateCounter()
    }
    
    //This function used to delete a record within the
    //managed object context
    func deleteRecord(name:String)
    {
        //Making the request for the object with passed in name
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Builds")
        req.predicate = NSPredicate(format:"name = %@", name)
        
        //Sending the actual request in
        if let results = try? managedObjectContext!.fetch(req) as? [NSManagedObject]
        {
            for object in results
            {
                //Deleting from the context and removing from
                //search results array
                managedObjectContext!.delete(object)
                fetchResults.remove(at: searchResults(name: name))
                try? managedObjectContext!.save()
            }
        }
    }
    
    //This function utilized for returning the count of builds
    func searchResults(name: String) -> Int
    {
        var count = 0
        for build in fetchResults
        {
            if(build.name == name)
            {
                return count
            }
            count += 1
        }
        return count
    }
    
    //This function utilized for intializing the build counter
    func initCounter()
    {
        counter = UserDefaults.init().integer(forKey: "counter")
    }
    
    //Updating the build counter
    func updateCounter()
    {
        counter += 1
        UserDefaults.init().set(counter, forKey: "counter")
        UserDefaults.init().synchronize()
    }
    
    //Returns the fetchresults list of builds
    func getRes() -> [Builds]
    {
        return fetchResults
    }
}
