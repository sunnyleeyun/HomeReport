//
//  Condo+CoreDataProperties.swift
//  Home Report
//
//  Created by Sunny on 2016/10/13.
//  Copyright © 2016年 devhubs. All rights reserved.
//

import Foundation
import CoreData


extension Condo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Condo> {
        return NSFetchRequest<Condo>(entityName: "Condo");
    }

    @NSManaged public var unitsPerBuilding: Int16

}
