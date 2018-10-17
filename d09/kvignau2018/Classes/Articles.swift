//
//  Articles+CoreDataClass.swift
//  kvignau2018
//
//  Created by Kevin VIGNAU on 10/11/18.
//
//

import Foundation
import CoreData


public class Articles: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Articles> {
        return NSFetchRequest<Articles>(entityName: "Articles")
    }
    
    @NSManaged public var titre: String?
    @NSManaged public var content: String?
    @NSManaged public var langue: String?
    @NSManaged public var image: NSData?
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var updateAt: NSDate?
    override public var description: String {
        if let title = titre, let val = content, let lang = langue {
            return title + " : " + val + " -> langue: " + lang
        }
        return "Article empty"
    }
}
