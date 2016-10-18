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
    func getHomesByStatus(isForSale: Bool, moc: NSManagedObjectContext) -> [Home]{
        let request: NSFetchRequest<Home> = Home.fetchRequest()
        request.predicate = NSPredicate(format: "isForSale = %@", isForSale as CVarArg)
        
        do{
            let homes = try moc.fetch(request)
            return homes
        }
        catch{
            fatalError("Error in getting list of homes")
        }
    }
}
