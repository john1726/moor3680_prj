//
//  SecondTabViewController.swift
//  moor3680_finalproject
//
//  Created by R Moore on 2022-04-16.
//

import UIKit
import CalendarKit
import EventKit

class SecondTabViewController: DayViewController {
    private let eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Second tab view created")
        // Do any additional setup after loading the view.        // The app must have access to the user's calendar to show the events on the timeline
        requestAccessToCalendar()
    }
    
    private func requestAccessToCalendar() {
        // Request access to the events
        eventStore.requestAccess(to: .event) { success, error in
            // Handle the response to the request.

        }
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
