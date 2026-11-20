//
//  DetailViewController.swift
//  moor3680_finalproject
//
//  Created by R Moore on 2022-04-18.
//

import UIKit

class DetailViewController: UIViewController {
    private var patient:Patient?
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailDiagnosistextView: UITextView!
    @IBOutlet weak var detailTreatmentTextView: UITextView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailMedicationTextView: UITextView!
    @IBOutlet weak var addressTextField: UITextField!
    
    func initWithPatient(patient: Patient) {
        self.patient = patient
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.image = patient?.getImage()
        nameTextField.text = patient?.getName()
        detailDiagnosistextView.text = patient?.getDiagnosis()
        detailTreatmentTextView.text = patient?.getTreatment()
        detailMedicationTextView.text = patient?.getMedication()
        addressTextField.text = patient?.getAddress()
    }
    
    func getPatient() -> Patient {
        return patient!
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
