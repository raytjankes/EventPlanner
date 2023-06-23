//
//  CreateEventView.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import SwiftUI

struct CreateEventView: View {
    
    @EnvironmentObject var eventViewmodel: EventViewModel
    @State private var eventName = ""
    @State private var eventLocation = ""
    @State private var eventDetails = ""
    @State private var eventOrganizer = ""
    @State private var eventDate = Date()
    @State private var eventImage: UIImage? = nil
    @State private var isShowingImagePicker = false
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    NavigationLink(destination: HomeView()) {
                        Text("Back")
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                List {
                    Section(header: Text("Event Details")) {
                        TextField("Name", text: $eventName)
                        TextField("Location", text: $eventLocation)
                        TextField("Details", text: $eventDetails)
                        TextField("Organizer", text: $eventOrganizer)
                        DatePicker("Date", selection: $eventDate, displayedComponents: [.date])
                    }
                    
                    Section(header: Text("Event Image")) {
                        if let image = eventImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                        }
                        
                        Button(action: {
                            isShowingImagePicker = true
                        }) {
                            Text("Select Image")
                        }
                        .sheet(isPresented: $isShowingImagePicker) {
                            ImagePickerView(image: $eventImage)
                        }
                    }
                    NavigationLink(destination: HomeView()) {
                        Text("Save Event")
                    }
                    .onTapGesture {
                        eventViewmodel.addEvent(name: eventName, location: eventLocation, details: eventDetails, organizer: eventOrganizer, date: eventDate, image: eventImage)
                        eventName = ""
                        eventLocation = ""
                        eventDetails = ""
                        eventOrganizer = ""
                        eventDate = Date()
                        eventImage = nil
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView()
            .environmentObject(EventViewModel())
    }
}
