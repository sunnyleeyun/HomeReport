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
    
    var soldPredicate: NSPredicate = NSPredicate(format: "isForSale = false")
    let request: NSFetchRequest<Home> = Home.fetchRequest()
    
    typealias HomeByStatusHandler = (_ homes: [Home]) -> Void
    internal func getHomesByStatus(request: NSFetchRequest<Home>, moc: NSManagedObjectContext, completionHandler: HomeByStatusHandler){
        
        let asyncRequest = NSAsynchronousFetchRequest(fetchRequest: request) { (results: NSAsynchronousFetchResult<Home>) in
            let homes = results.finalResult!
            completionHandler(homes)
        }
        
        do {
//            let homes = try moc.fetch(request)
//            return homes
            try moc.execute(asyncRequest)
        }
        catch {
            fatalError("Error in getting list of homes")
        }
    }
    
    internal func getTotalHomeSales(moc: NSManagedObjectContext) -> String{
        request.predicate = soldPredicate
        request.resultType = .dictionaryResultType
        
        let sumExpressionDescription = NSExpressionDescription()
        sumExpressionDescription.name = "totalSales"
        sumExpressionDescription.expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "price")])
        sumExpressionDescription.expressionResultType = .doubleAttributeType
        
        request.propertiesToFetch = [sumExpressionDescription]
        
        do{
            let results = try moc.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [NSDictionary]
            let dictionary = results.first!
            let totalSales = dictionary["totalSales"] as! Double
            
            return totalSales.currencyFormatter
        }
        catch{
            fatalError("Error getting total home sales")
        }
    }
    internal func getNumberCondoSold(moc: NSManagedObjectContext) -> String{
        let typePredicate = NSPredicate(format: "homeType = 'Condo'")
        let predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [soldPredicate, typePredicate])
        
        request.resultType = .countResultType
        request.predicate = predicate
        
        var count: NSNumber!
        
        do{
            let results = try moc.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [NSNumber]
            count = results.first
        }
        catch{
            fatalError("Error counting Condo sold")
        }
        
        return count.stringValue
    }
    
    internal func getNumberSingleFamilyHomeSold(moc: NSManagedObjectContext) -> String{
        let typePredicate = NSPredicate(format: "homeType = 'Single Family'")
        let predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [soldPredicate, typePredicate])
        
        request.predicate = predicate
        
        do{
            let count = try moc.count(for: request)
            
            if count != NSNotFound{
                return String(count)
            }
            else{
                fatalError("No single family count is returned")
            }
        }
        catch{
            fatalError("Error counting single family home sold")
        }
    }
    
    internal func getHomePriceSold(priceType: String, moc: NSManagedObjectContext) -> String{
        request.predicate = soldPredicate
        request.resultType = .dictionaryResultType
        
        let sumExpressionDescription = NSExpressionDescription()
        sumExpressionDescription.name = priceType
        sumExpressionDescription.expression = NSExpression(forFunction: "\(priceType):", arguments: [NSExpression(forKeyPath: "price")])
        sumExpressionDescription.expressionResultType = .doubleAttributeType
        
        request.propertiesToFetch = [sumExpressionDescription]
        
        do{
            let results = try moc.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [NSDictionary]
            let dictionary = results.first!
            let homePrice = dictionary[priceType] as! Double
            
            return homePrice.currencyFormatter
        }
        catch{
            fatalError("Error getting \(priceType) home sales")
        }
    }
    
    internal func getAverageHomePrice(homeType: String, moc: NSManagedObjectContext) -> String{
        let typePrediceate = NSPredicate(format: "homeType = %@", homeType)
        let predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [soldPredicate, typePrediceate])
        
        request.predicate = predicate
        request.resultType = .dictionaryResultType
        
        let sumExpressionDescription = NSExpressionDescription()
        sumExpressionDescription.name = homeType
        sumExpressionDescription.expression = NSExpression(forFunction: "average:", arguments: [NSExpression(forKeyPath: "price")])
        sumExpressionDescription.expressionResultType = .doubleAttributeType
        
        request.propertiesToFetch = [sumExpressionDescription]
        do{
            let results = try moc.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [NSDictionary]
            let dictionary = results.first!
            let homePrice = dictionary[homeType] as! Double
            
            return homePrice.currencyFormatter
        }
        catch{
            fatalError("Error getting \(homeType) home sales")
        }
    }
}
