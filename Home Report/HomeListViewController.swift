//
//  HomeListViewController.swift
//  Home Report
//
//  Created by Andi Setiyadi on 9/1/16.
//  Copyright © 2016 devhubs. All rights reserved.
//

import UIKit
import CoreData

class HomeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Outlets
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: Properties
    weak var managedObjectContext: NSManagedObjectContext! {
        didSet {
            return home = Home(context: managedObjectContext)
        }
    }
    
    lazy var homes = [Home]()
    var selectedHome: Home?
    var home: Home? = nil
    var isForSale: Bool = true
    var sortDescriptor = [NSSortDescriptor]()
    var searchPredicate: NSPredicate?
    var request: NSFetchRequest<Home>?
    
    // MARK: Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        request = Home.fetchRequest()
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Segmented control
    
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        let selectedValue = sender.titleForSegment(at: sender.selectedSegmentIndex)
        isForSale = selectedValue == "For Sale" ? true : false
        loadData()
    }
    
    
    // MARK: TableView datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeListTableViewCell
        
        let currentHome = homes[indexPath.row]
        cell.configureCell(home: currentHome)
        
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueHistory" {
            let selectedIndexPath = tableView.indexPathForSelectedRow
            selectedHome = homes[selectedIndexPath!.row]
            
            let destinationController = segue.destination as! SaleHistoryViewController
            destinationController.home = selectedHome
            destinationController.managedObjectContext = managedObjectContext
        }
        else if segue.identifier == "segueToFilter" {
            sortDescriptor = []
            searchPredicate = nil
            
            let controller = segue.destination as! FilterTableViewController
            controller.delegate = self
        }
    }
    

    // MARK: Private function
    
    private func loadData() {
        var predicates = [NSPredicate]()
        
        let statusPredicate = NSPredicate(format: "isForSale = %@", isForSale as CVarArg)
        predicates.append(statusPredicate)
        
        if let additionalPredicate = searchPredicate {
            predicates.append(additionalPredicate)
        }
        
        let predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: predicates)
        
        request!.predicate = predicate
        
        if sortDescriptor.count > 0 {
            request!.sortDescriptors = sortDescriptor
        }
        
        homes = home!.getHomesByStatus(request: request!, moc: managedObjectContext)
        tableView.reloadData()
    }
}


extension HomeListViewController: FilterTableViewControllerDelegate {
    func updateHomeList(filterby: NSPredicate?, sortby: NSSortDescriptor?) {
        if let filter = filterby {
            searchPredicate = filter
        }
        if let sort = sortby {
            sortDescriptor.append(sort)
        }
    }
}
