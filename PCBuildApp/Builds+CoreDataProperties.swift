//
//  Builds+CoreDataProperties.swift
//  PCBuildApp
//
//  This file extends the build class int terms of
//  defining all properties which will be saved to
//  core data.
//
//  Created by GusMando on 11/8/20.
//  Copyright © 2020 Agustin Gomez. All rights reserved.
//

import Foundation
import CoreData

//Extending on the Builds class
extension Builds
{
    //Function used for fetching the Builds core dtat object
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Builds>
    {
        return NSFetchRequest<Builds>(entityName: "Builds")
    }
    
    //Vars defining each build entity
    @NSManaged public var desc: String?
    @NSManaged public var name: String?
    @NSManaged public var pic: NSData?
    @NSManaged public var stor: String?
    @NSManaged public var graph: String?
    @NSManaged public var cpu: String?
    @NSManaged public var moth: String?
    @NSManaged public var mem: String?
    @NSManaged public var psu: String?
    @NSManaged public var os: String?
    @NSManaged public var cas: String?
    @NSManaged public var comp: String?

}
