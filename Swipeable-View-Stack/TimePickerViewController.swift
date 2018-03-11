//
//  TimePickerViewController.swift
//  Swipeable-View-Stack
//
//  Created by Piotrek on 10.03.2018.
//  Copyright © 2018 Piotr Knapczyk. All rights reserved.


import UIKit

class TimePickerViewController: UIViewController {

    var dataset: Dataset?
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        datePicker.minimumDate = Date()+1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let dest = segue.destination as? ViewController {
            if let dataset = dataset {
                dataset.changeStatus(newStatus: true, examDate: datePicker.date)
                dest.dataset = dataset
            }
            self.navigationController?.popToRootViewController(animated: false)
            
        }
    }

}
