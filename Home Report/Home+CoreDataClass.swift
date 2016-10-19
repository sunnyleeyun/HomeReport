//
//  Home+CoreDataClass.swift
//  Home Report
//
//  Created by Andi Setiyadi on 8/31/16.
//  Copyright © 2016 devhubs. All rights reserved.
//

import Foundation
import CoreData


public class Home: NSManagedObject {

    func getHomesByStatus(request: NSFetchRequest<Home>, moc: NSManagedObjectContext) -> [Home] {
        do {
            let homes = try moc.fetch(request)
            return homes
        }
        catch {
            fatalError("Error in getting list of homes")
        }
    }
}
