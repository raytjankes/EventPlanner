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
    
    
    @Published var events: [Event] = []
    @Published var eventEntities : [EventEntity] = []
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
        self.events = generateDummyData()
      }
    
    private func fetchEvents() {
        let request = NSFetchRequest<EventEntity>(entityName: "EventEntity")
        
        do{
            eventEntities = try container.viewContext.fetch(request)
            print("amount of events")
            print(eventEntities.count)
            for event in eventEntities {
                if let imageName = event.imageName {
                    print("Image name: \(imageName)")
                } else {
                    print("No image name available")
                }
            }
        }
        catch let error {
            print("Error fetching \(error)")
        }
    }
    
    func addEvent(name: String, location: String, details: String?, organizer: String, date: Date, image: UIImage?) {
        
        print("Start adding")
        
        var imageName: String?
            
        if let image = image {
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                return
            }
            
            let imageFileName = UUID().uuidString + ".jpg" // Add file extension
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
    
    private func generateDummyData() -> [Event] {
        let event1 = Event(id: 1,
                           name: "Event 1",
                           location: "Location 1",
                           details: "Description 1",
                           organizer: "Organizer 1",
                           date: Date(),
                           imageName: nil)
        
        let event2 = Event(id: 2,
                           name: "Event 2",
                           location: "Location 2",
                           details: "Description 2",
                           organizer: "Organizer 2",
                           date: Date(),
                           imageName: nil)
        
        let event3 = Event(id: 3,
                           name: "Event 3",
                           location: "Location 3",
                           details: "Description 3",
                           organizer: "Organizer 3",
                           date: Date(),
                           imageName: nil)
        
        return [event1, event2, event3]
    }

}
