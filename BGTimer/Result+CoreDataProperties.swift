//
//  Result+CoreDataProperties.swift
//  BoardTimer
//
//  Created by 최대식 on 2021/03/05.
//
//

import Foundation
import CoreData


extension Result {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Result> {
        return NSFetchRequest<Result>(entityName: "Result")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: [String]
    @NSManaged public var place: [Int16]
    @NSManaged public var timeConsumed: Int16
    @NSManaged public var date: Date
    @NSManaged public var winner: String

}

extension Result : Identifiable {

}
