//
//  FirstTabViewController.swift
//  moor3680_finalproject
//
//  Created by R Moore on 2022-04-29.
//  Copyright © 2022 Karmadust. All rights reserved.
//

import UIKit

class TableViewCell:UITableViewCell{   
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
}

class FirstTabViewController: UITableViewController {
    
    let simpleTableIdentifier = "table_identifier"
    var tableData = [Patient]() // the data source
    let segueID = "DetailViewSegue"
    //@IBOutlet weak var tableView: UITableView!
    
           // tells the table view that the data comes from tableData
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return tableData.count
    }
           // tells the table view what should be displayed at the  selected row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // here, we try to re-use a cell, for efficiency
        var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier,
                                                 for: indexPath) as? TableViewCell
        if (cell == nil) {
            cell = TableViewCell(
                style: UITableViewCell.CellStyle.default,
                reuseIdentifier: simpleTableIdentifier)
        }
        
        cell?.cellImageView.image = tableData[indexPath.row].getImage()
        cell?.cellLabel.text = tableData[indexPath.row].getName()
        PatientCollection.setCurrentIndex(to: indexPath.row)
        
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
         tableView.deselectRow(at: indexPath, animated: true)
         performSegue(withIdentifier: segueID,
                                    sender: tableData[indexPath.row])
       }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            PatientCollection.collection.remove(at: indexPath.row)
            try? PatientCollection.saveCollection()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    //MARK: Prepare for  segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

       if segue.identifier == segueID {
                
          //segue to the detail (destination) VC
          let detailVC = segue.destination as! DetailViewController;

            //invoke the function in the destination VC to pass data
          detailVC.initWithPatient(patient: sender as! Patient)
        } //
    }//  prepare for segue

             
 override func viewDidLoad() {
    super.viewDidLoad()
     navigationItem.leftBarButtonItem = editButtonItem
     PatientCollection.collection = try! PatientCollection.loadCollection()
     tableData = PatientCollection.collection
  }

    @IBAction func unwindToPatientList(sender: UIStoryboardSegue) {
            print("unwindToPatientList")
            
//            if let sourceViewController = sender.source as? DetailViewController {
//                let patient = sourceViewController.getPatient()
//
//                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    // Update an existing fruit.
//                    PatientCollection.collection[selectedIndexPath.row] = patient
//                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
//                    print("unwindToPatientList::selectedIndexPath")
//                }
//                else {
//                    // Add a new fruit.
//                    let newIndexPath = IndexPath(row: PatientCollection.collection.count, section: 0)
//
//                    PatientCollection.collection.append(patient)
//                    tableView.insertRows(at: [newIndexPath], with: .automatic)
//                    print("unwindToPatientList::newIndexPath")
//                }
                
                // Save the fruit.
                //try? PatientCollection.saveCollection()
            //}
            PatientCollection.collection = try! PatientCollection.loadCollection()
            tableData = PatientCollection.collection
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    
}
