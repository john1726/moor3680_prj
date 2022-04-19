//
//  Patient.swift
//  moor3680_finalproject
//
//  Created by R Moore on 2022-04-16.
//

import Foundation
import UIKit

class Patient {

    var name: String
    var photo: UIImage
    var diagnosis: String
    var treatment: String
    var medication: String

    init(name: String, photo: UIImage, diagnosis: String, treatment: String, medication: String){
        self.name = name
        self.photo = photo
        self.diagnosis = diagnosis
        self.treatment = treatment
        self.medication = medication
    }

    func getName() -> String{
       return self.name
    }
            
    func getPhoto() -> UIImage {
       return self.photo
    }
    
    func getDiagnosis() -> String{
       return self.diagnosis
    }
    
    func getTreatment() -> String{
       return self.treatment
    }
    
    func getMedication() -> String{
       return self.medication
    }
}
