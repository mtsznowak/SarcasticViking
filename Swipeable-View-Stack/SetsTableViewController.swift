//
//  SetsTableViewController.swift
//  Swipeable-View-Stack
//
//  Created by Piotrek on 10.03.2018.
//  Copyright © 2018 Piotr Knapczyk. All rights reserved.

import UIKit

class SetsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var datasets: [Dataset] = [Dataset(fileName: "Język nordycki"), Dataset(fileName: "Harold wiking"), Dataset(fileName: "Sprawdzan z ortogafji"), Dataset(fileName: "Pytania o wikingów")]
    
    func activeDatasets() -> [Dataset] {
        return datasets.filter({ dataset -> Bool in return dataset.status })
    }
    func inactiveDatasets() -> [Dataset] {
        return datasets.filter({ dataset -> Bool in return !dataset.status })
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return activeDatasets().count
        }else if section == 1 {
            return inactiveDatasets().count
        }else {
            fatalError()
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "activeCellReuseID", for: indexPath) as! SetsTableViewCell
            
            let dataset = activeDatasets()[indexPath.row]
            let date = dataset.examDate
            if let date = date {
                var formatter = DateComponentsFormatter()
                formatter.allowedUnits = [.day, .hour]
                formatter.unitsStyle = .short
                let timeLeft = formatter.string(from: Date(), to: date)
                cell.timeLeft.text = timeLeft
                if (date.timeIntervalSince(Date())>60*60*24*3){
                    cell.timeLeft.textColor = UIColor.green
                    cell.timeLeft.layer.borderColor = UIColor.green.cgColor
                }else {
                    cell.timeLeft.textColor = UIColor.red
                    cell.timeLeft.layer.borderColor = UIColor.red.cgColor
                    

                }
            }
            
            cell.name.text = dataset.name
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "notActiveCellReuseID", for: indexPath)
        cell.textLabel?.text = inactiveDatasets()[indexPath.row].name
        cell.detailTextLabel?.text = "\(inactiveDatasets()[indexPath.row].cards.count) cards"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
 
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Active"
        case 1:
            return "Avaliable"
        default:
            return nil
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let dest = segue.destination as? TimePickerViewController {
            let indexPath = self.tableView.indexPathForSelectedRow
            if let indexPath = indexPath {
                dest.dataset = inactiveDatasets()[indexPath.row]
            }
            
        }
        
        if let dest = segue.destination as? ViewController {
            let indexPath = self.tableView.indexPathForSelectedRow
            if let indexPath = indexPath {
                dest.dataset = activeDatasets()[indexPath.row]
            }
        }

        
    }
}
