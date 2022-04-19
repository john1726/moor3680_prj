//
//  FirstTabViewController.swift
//  moor3680_finalproject
//
//  Created by R Moore on 2022-04-16.
//

import UIKit

class TableViewCell:UITableViewCell{
//    @IBOutlet weak var cellImageView: UIView!

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
}

class FirstTabViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let simpleTableIdentifier = "table_identifier"
    var tableData = [Patient]() // the data source
    let segueID = "DetailViewSegue"

           // tells the table view that the data comes from tableData
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return tableData.count
    }
           // tells the table view what should be displayed at the  selected row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // here, we try to re-use a cell, for efficiency
        var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier,
                                                 for: indexPath) as? TableViewCell
        if (cell == nil) {
            cell = TableViewCell(
                style: UITableViewCell.CellStyle.default,
                reuseIdentifier: simpleTableIdentifier)
        }
        
        cell?.cellImageView.image = tableData[indexPath.row].getPhoto()
        cell?.cellLabel.text = tableData[indexPath.row].getName()
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
         tableView.deselectRow(at: indexPath, animated: true)
         performSegue(withIdentifier: segueID,
                                    sender: tableData[indexPath.row])
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
    
 // initialize the data source
 func createData(){
    let person1 = Patient(name: "Brigitte Bardot",
                          photo: UIImage(named: "bardot.jpg")!,
                          diagnosis: "lower back pain",
                          treatment: "massage lower back",
                          medication: "aspirin")
    tableData.append(person1)
             
    let person2 = Patient(name: "Alain Delon",
                          photo: UIImage(named: "delon.jpg")!,
                          diagnosis: "sore neck from working on computers",
                          treatment: "physiotherapy",
                          medication: "corticosteriod")
    tableData.append(person2)
  }// createData

             
 override func viewDidLoad() {
    super.viewDidLoad()
    createData()
  }

}
