//
//  Patient.swift
//  moor3680_finalproject
//
//  Created by R Moore on 2022-04-16.
//

import UIKit
import Foundation
import os.log

class WalkingPath: Codable {

    var name: String
    var photo: UIImage?
    var diagnosis: String
    var treatment: String
    var medication: String
    var address: String
    var appointmentData = [Date]()

    init(name: String, photo: UIImage, diagnosis: String, treatment: String, medication: String, address: String){
        self.name = name
        self.photo = photo
        self.diagnosis = diagnosis
        self.treatment = treatment
        self.medication = medication
        self.address = address
        self.appointmentData = [Date]()
    }

    func getAddress() -> String{
       return self.address
    }
    
    func getName() -> String{
       return self.name
    }
            
    func getImage() -> UIImage {
       return self.photo!
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
    
    func getAppointmentData() -> Array<Date> {
       return self.appointmentData
    }
    
    func setAppointment(appointment: Date) {
        self.appointmentData.append(appointment)
    }
    
    // MARK: Codable functions
    
    public enum CodingKeys: String, CodingKey {
        case name
        case photo // we want to encode the photo property
        case diagnosis
        case treatment
        case medication
        case address
        //case appointmentData
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // decoding the image property of the object
        let imageData = try container.decode(Data.self, forKey: .photo)
        self.photo = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(imageData) as? UIImage
        
        // decoding the name property
        let nameData = try container.decode(Data.self, forKey: .name)
        self.name = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(nameData) as? String ?? "no patient name"
        
        let diagnosisData = try container.decode(Data.self, forKey: .diagnosis)
        self.diagnosis = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(diagnosisData) as? String ?? "no diagnosis"
        
        let treatmentData = try container.decode(Data.self, forKey: .treatment)
        self.treatment = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(treatmentData) as? String ?? "no treatment"
        
        let medicationData = try container.decode(Data.self, forKey: .medication)
        self.medication = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(medicationData) as? String ?? "no medication"
        
        //let appointments = try container.decode([Date].self, forKey: .appointmentData)
        //self.appointmentData = try (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(appointments) as? Array<Date>)!
        
        let addressData = try container.decode(Data.self, forKey: .address)
        self.address = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(addressData) as? String ?? "no address"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let imageData = try NSKeyedArchiver.archivedData(withRootObject: photo ??
            UIImage(named: "question-mark.jpg")!, requiringSecureCoding: true)
        try container.encode(imageData, forKey: .photo)
        
        let nameData = try NSKeyedArchiver.archivedData(withRootObject: name,
                                                        requiringSecureCoding: true)
        try container.encode(nameData, forKey: .name)


        let diagnosisData = try NSKeyedArchiver.archivedData(withRootObject: diagnosis,
                                                        requiringSecureCoding: true)
        try container.encode(diagnosisData, forKey: .diagnosis)
        
        let treatmentData = try NSKeyedArchiver.archivedData(withRootObject: treatment,
                                                        requiringSecureCoding: true)
        try container.encode(treatmentData, forKey: .treatment)
        
        let medicationData = try NSKeyedArchiver.archivedData(withRootObject: medication,
                                                        requiringSecureCoding: true)
        try container.encode(medicationData, forKey: .medication)
        
        let addressData = try NSKeyedArchiver.archivedData(withRootObject: address,
                                                        requiringSecureCoding: true)
        try container.encode(addressData, forKey: .address)
        
    }
}
