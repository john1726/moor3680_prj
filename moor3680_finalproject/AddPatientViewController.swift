//
//  AddPatientViewController.swift
//  moor3680_finalproject
//
//  Created by R Moore on 2022-04-29.
//

import UIKit

class AddPatientViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var diagnosisTextView: UITextView!
    @IBOutlet weak var treatmentTextView: UITextView!
    @IBOutlet weak var medicationTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    func configureView() {
        // Set up views if editing an existing Fruit.
        if let patient = patient {
            navigationItem.title = patient.getName()
            diagnosisTextView.text = patient.getDiagnosis()
            nameTextField.text = patient.getName()
            photoImageView.image = patient.getImage()
            treatmentTextView.text = patient.getTreatment()
            medicationTextView.text = patient.getMedication()
        }
    }
    
    /*
         This value is either passed by `FruitTableViewController` in `prepare(for:sender:)`
         or constructed as part of adding a new fruit.
     */
    var patient: Patient?
    
    func getPatient() -> Patient {
        return patient!
    }// getFruit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loaded AddPatientViewController")
        
        configureView()
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        diagnosisTextView.delegate = self
        treatmentTextView.delegate = self
        medicationTextView.delegate = self
        addressTextField.delegate = self
        
        // Enable the Save button only if the text field has a valid Fruit name.
        updateSaveButtonState()
    }

    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        //textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
     //MARK: UIImagePickerControllerDelegate
     
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         // Dismiss the picker if the user canceled.
         dismiss(animated: true, completion: nil)
     }
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         
         guard let selectedImage = info[.originalImage] as? UIImage else {
             fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
         }
         // Set photoImageView to display the selected image.
         photoImageView.image = selectedImage
         
         // Dismiss the picker.
         dismiss(animated: true, completion: nil)
     }
    
    //MARK: Navigation
    

    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddPatientMode = presentingViewController is UINavigationController
        
        if isPresentingInAddPatientMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The ViewController is not inside a navigation controller.")
        }
        
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("AddPatientViewController prepare called")
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            print("The save button was not pressed, cancelling")
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let diagnosis = diagnosisTextView.text ?? ""
        let treatment = treatmentTextView.text ?? ""
        let medication = medicationTextView.text ?? ""
        let address = addressTextField.text ?? ""
        
        // Set the fruit to be passed to TableViewController after the unwind segue.
        patient = Patient(name: name, photo: photo!, diagnosis: diagnosis, treatment: treatment, medication: medication, address: address)
        PatientCollection.collection.append(patient!)
        try? PatientCollection.saveCollection()
    }
  
 
    @IBAction func savePatient(_ sender: UIBarButtonItem) {
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let diagnosis = diagnosisTextView.text ?? ""
        let treatment = treatmentTextView.text ?? ""
        let medication = medicationTextView.text ?? ""
        let address = addressTextField.text ?? ""
        
        // Set the fruit to be passed to TableViewController after the unwind segue.
        patient = Patient(name: name, photo: photo!, diagnosis: diagnosis, treatment: treatment, medication: medication, address: address)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectPhoto(_ sender: UIButton) {
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        diagnosisTextView.resignFirstResponder()
        treatmentTextView.resignFirstResponder()
        medicationTextView.resignFirstResponder()
        
        //∂ UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        //let diagnosis = diagnosisTextView.text ?? ""
        //let treatment = treatmentTextView.text ?? ""
        //let medication = medicationTextView.text ?? ""
        saveButton.isEnabled = !text.isEmpty
        print("updateSaveButtonState")
    }
    
}

