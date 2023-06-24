//
//  CreateEventView.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import SwiftUI

struct CreateEventView: View {
    
    @EnvironmentObject var eventViewmodel: EventViewModel
    @State var isNavigate: Bool = false
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
            GeometryReader{geometry in
                ZStack{
                    VStack{
                        HStack{
                            NavigationLink(destination: HomeView()) {
                                Image(systemName: "arrowshape.backward.fill")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color.customPrimary)
                            }.padding()
                            Spacer()
                        }
                        .padding(.bottom)
                        .background(Color.customBackground)
                        Spacer()
                    }
                    
                    VStack{
                        HStack{
                            Spacer()
                            Text("Create Event")
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(Color.customPrimary)
                                .padding(.top)
                            Spacer()
                        }
                        List {
                            Section(header: Text("Name")) {
                                TextField("Name", text: $eventName)
                            }
                            .listRowInsets(EdgeInsets(top: 15, leading: 10, bottom: 5, trailing: 10))
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customBackground.opacity(0.8), lineWidth: 6)
                                    .background(Color.customPrimary)
                            )

                            Section(header: Text("Location")) {
                                TextField("Location", text: $eventLocation)
                            }
                            .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customBackground.opacity(0.8), lineWidth: 6)
                                    .background(Color.customPrimary)
                            )
                            
                            Section(header: Text("Description")) {
                                TextField("Details", text: $eventDetails)
                            }
                            .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customBackground.opacity(0.8), lineWidth: 6)
                                    .background(Color.customPrimary)
                            )
                            
                            Section(header: Text("Organizer")) {
                                TextField("Organizer", text: $eventOrganizer)
                            }
                            .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customBackground.opacity(0.8), lineWidth: 6)
                                    .background(Color.customPrimary)
                            )
                            
                            Section(header: Text("Date")) {
                                DatePicker("Selected date", selection: $eventDate, displayedComponents: [.date])
                            }
                            .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customBackground.opacity(0.8), lineWidth: 6)
                                    .background(Color.customPrimary)
                            )
                            
                            Section(header: Text("Image")) {
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
                            .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customBackground.opacity(0.8), lineWidth: 6)
                                    .background(Color.customPrimary)
                            )
                        }.listStyle(.insetGrouped)

                        
                        Button {
                            print("Tapped")
                            isNavigate = true
                            eventViewmodel.addEvent(name: eventName, location: eventLocation, details: eventDetails, organizer: eventOrganizer, date: eventDate, image: eventImage)
                            
                            
                        } label: {
                            Text("Save event")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color.customButton)
                                        .shadow(color: Color.customDarkBackground, radius: 3, x: 2, y: 2)
                                )
                                .padding(.horizontal)
                        }
                        
                        Spacer()
                        
                        if isNavigate {
                            NavigationLink(destination: HomeView(), isActive: self.$isNavigate) {
                                EmptyView()
                            }
                            .hidden()
                        }
                        
                    }
                }
            }
            
        }.navigationBarHidden(true)
    }
}

struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView()
            .environmentObject(EventViewModel())
    }
}
