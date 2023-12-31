//
//  EventViewModel.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import Foundation
import SwiftUI
import CoreData

class EventViewModel: ObservableObject {
    
    @Published var eventEntities : [EventEntity] = []
    @Published var orderedEvents : [EventEntity] = []
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name:"EventsContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
            else{
                print("Successfully load Core Data")
            }
        }
        fetchEvents()
      }
    
    private func fetchEvents() {
        let request = NSFetchRequest<EventEntity>(entityName: "EventEntity")
        
        do{
            eventEntities = try container.viewContext.fetch(request)
            orderedEvents  = eventEntities
            print("amount of events")
            print(eventEntities.count)
        }
        catch let error {
            print("Error fetching \(error)")
        }
    }
    
    func addEvent(name: String, location: String, details: String?, organizer: String, date: Date, image: UIImage?) {
        
        print("Start adding")
        
        var imageName: String?
        
        // Save image
        if let image = image {
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                return
            }
            
            let imageFileName = UUID().uuidString + ".jpg" // Set file extension
            let imagePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imageFileName)
            
            do {
                try imageData.write(to: imagePath)
                imageName = imageFileName
            } catch {
                print("Failed to save image: \(error)")
            }
        }
        
        let context = container.viewContext
        
        // Create a new EventEntity object
        if let eventEntity = NSEntityDescription.insertNewObject(forEntityName: "EventEntity", into: context) as? EventEntity {
            eventEntity.id = UUID()
            eventEntity.name = name
            eventEntity.location = location
            eventEntity.details = details ?? ""
            eventEntity.organizer = organizer
            eventEntity.date = date
            eventEntity.imageName = imageName ?? nil
            
            // Save the context
            do {
                try context.save()
                fetchEvents()
                print("Successfully save the new event")
            } catch {
                print("Failed to save the new event: \(error)")
            }
        }
    }

    func deleteEvent(_ event: EventEntity) {
        
       let context = container.viewContext
       context.delete(event)

       do {
           try context.save()
           fetchEvents()
       } catch {
           print("Error deleting event: \(error)")
       }
   }

    func sortEntities(option: String) {
        switch option {
        case "name":
            eventEntities.sort { ($0.name ?? "") < ($1.name ?? "") }
        case "date":
            eventEntities.sort { ($0.date ?? Date()) < ($1.date ?? Date()) }
        default:
            eventEntities = orderedEvents
        }
    }

}
