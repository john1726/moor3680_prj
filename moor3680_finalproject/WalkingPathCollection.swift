//
//  PatientCollection.swift
//  moor3680_finalproject
//
//  Created by R Moore on 2022-04-29.
//

import Foundation
import UIKit

class WalkingPathCollection : Codable {
    static var collection = [Patient]() // a deck is an array of cards
    static var current:Int = 0 // the current card on the deck (to be shown in the scene)
    
    // computed property to get the url to the dictionary
    static var fileURL : URL {
        let documentDirectoryURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return documentDirectoryURL.appendingPathComponent("CP669FinalProjectRMooreCodable.file")
    }
    
    init(){ // init is automatically called when you make an instance of the collection
        // You implement this function
        // Make a Patient objects and append them to your collection
        // repeat as many times as you need, your collection should contain at least three cards
        //PatientCollection.collection = PatientCollection.populateCollection()
    }
    
    // return the current card
    static func currentPatient()->Patient{
        // find the correct currentPatient to return, you implement this function
        let currentCard = collection[current]
        return currentCard
    }
    
    static func setCurrentIndex(to index: Int) { // you may need this function for
        // relaunching the app
        current = index
    }
    
    // other helper functions you may need when relaunching the app
    // return the index of the current card in the deck
    static func getCurrentIndex() -> Int {
        return current
    }// getCurrentIndex
    
    // save person to the file (permanent)
    static func saveCollection() throws {
        print("saveCollection")
        let jsonEncoder = JSONEncoder()
        var jsonData = Data()
        do {
            jsonData = try jsonEncoder.encode(collection)
            print(jsonData)
        }
        catch {
            print("cannot encode")
        }
        do {
            try jsonData.write(to: fileURL, options: [])
        } catch {
            print("cannot write")
        }
        print("saveCollection Complete")
    } // savePerson
    
    // When app restarts, load the saved collection (it the object exists)
    static func loadCollection() throws -> Array<Patient> // return Patient collection
    {
        print("loadCollection")
        let jsonDecoder = JSONDecoder()
        var collection = [Patient]()
        var data = Data()
        do {
            data = try Data(contentsOf: fileURL)
        } catch {
            print("cannot read the archive")
        }
        do{
            collection = try jsonDecoder.decode(Array<Patient>.self, from: data)
        } catch {
            print("cannot decode the collection from the archive")
        }
        if collection.count == 0 {
            collection = populateCollection()
        }
        
        print("loadCollection Complete")
        
        return collection
    }
    
    // App loads default values here if the coleciton is empty
    static func populateCollection() -> Array<Patient> {
        var collection = [Patient]()
        
        let Patient1 = Patient(name:"Brigit Bardot", photo: UIImage(named:"bardot.jpg")!, diagnosis: "back pain", treatment: "see Chriopractor", medication: "Ibuprofen", address: "446 Dovercourt Ave, Ottawa")
        let Patient2 = Patient(name:"Alain Delon", photo: UIImage(named:"delon.jpg")!, diagnosis: "sore neck", treatment: "see Massage Therapis", medication: "Tylenol", address: "62 Havenhurst Cres, Ottawa")
        let Patient3 = Patient(name:"Nathalie Delon", photo: UIImage(named:"nathalie.jpg")!, diagnosis: "sore feet", treatment: "see Podiatrist", medication: "Aspirin", address: "107 Belleview Dr, Ottawa")
        let Patient4 = Patient(name:"Roger Vadim", photo: UIImage(named:"roger.jpg")!, diagnosis: "Ear ache", treatment: "see GP", medication: "Amoxocilin", address: "5-1137 Merivale Rd, Ottawa")
    
        collection.append(Patient1)
        collection.append(Patient2)
        collection.append(Patient3)
        collection.append(Patient4)
        
        return collection
    }
}
