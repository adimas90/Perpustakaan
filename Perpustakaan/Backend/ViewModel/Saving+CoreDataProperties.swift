//
//  Saving+CoreDataProperties.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 12/05/22.
//
//

import Foundation
import CoreData


extension Saving {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Saving> {
        return NSFetchRequest<Saving>(entityName: "Saving")
    }

    @NSManaged public var image: Data?
    @NSManaged public var username: String?
    @NSManaged public var favo: Bool
    @NSManaged public var descriptions: String?

}

extension Saving : Identifiable {

}
