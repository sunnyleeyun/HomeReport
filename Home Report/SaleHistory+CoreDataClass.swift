//
//  SaleHistory+CoreDataClass.swift
//  Home Report
//
//  Created by Andi Setiyadi on 8/31/16.
//  Copyright © 2016 devhubs. All rights reserved.
//

import Foundation
import CoreData


public class SaleHistory: NSManagedObject {
    
    func getSoldHistory(home: Home, moc: NSManagedObjectContext) -> [SaleHistory]{
        let soldHistoryRequest: NSFetchRequest<SaleHistory> = SaleHistory.fetchRequest()
        soldHistoryRequest.predicate = NSPredicate(format: "home = %@", home)
        do{
            let soldHistory = try moc.fetch(soldHistoryRequest)
            return soldHistory
        }
        catch{
            fatalError("Error in getting sold history")
        }
    }

}
