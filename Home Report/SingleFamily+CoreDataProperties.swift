//
//  SingleFamily+CoreDataProperties.swift
//  Home Report
//
//  Created by Sunny on 2016/10/13.
//  Copyright © 2016年 devhubs. All rights reserved.
//

import Foundation
import CoreData


extension SingleFamily {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SingleFamily> {
        return NSFetchRequest<SingleFamily>(entityName: "SingleFamily");
    }

    @NSManaged public var lotSize: Int16

}
