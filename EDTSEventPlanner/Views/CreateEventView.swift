//
//  CreateEventView.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import SwiftUI

struct CreateEventView: View {
    @EnvironmentObject var language: LanguageViewModel
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
                            Text("title_create_event_header".localized(language.getLanguage()))
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(Color.customPrimary)
                                .padding(.top)
                            Spacer()
                        }
                        List {
                            Section(header: Text("label_name".localized(language.getLanguage()) + "*")) {
                                TextField("label_name".localized(language.getLanguage()), text: $eventName)
                            }
                            .listRowInsets(EdgeInsets(top: 15, leading: 10, bottom: 5, trailing: 10))
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customBackground.opacity(0.8), lineWidth: 6)
                                    .background(Color.customPrimary)
                            )

                            Section(header: Text("label_location".localized(language.getLanguage()) + "*")) {
                                TextField("label_location".localized(language.getLanguage()), text: $eventLocation)
                            }
                            .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customBackground.opacity(0.8), lineWidth: 6)
                                    .background(Color.customPrimary)
                            )
                            
                            Section(header: Text("label_details".localized(language.getLanguage()))) {
                                TextField("label_details".localized(language.getLanguage()), text: $eventDetails)
                            }
                            .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customBackground.opacity(0.8), lineWidth: 6)
                                    .background(Color.customPrimary)
                            )
                            
                            Section(header: Text("label_organizer".localized(language.getLanguage()) + "*")) {
                                TextField("label_organizer".localized(language.getLanguage()), text: $eventOrganizer)
                            }
                            .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customBackground.opacity(0.8), lineWidth: 6)
                                    .background(Color.customPrimary)
                            )
                            
                            Section(header: Text("label_date".localized(language.getLanguage()) + "*")) {
                                DatePicker("label_create_event_date".localized(language.getLanguage()), selection: $eventDate, displayedComponents: [.date])
                            }
                            .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customBackground.opacity(0.8), lineWidth: 6)
                                    .background(Color.customPrimary)
                            )
                            
                            Section(header: Text("label_image".localized(language.getLanguage()))) {
                                VStack{
                                    
                                    if let image = eventImage {
                                        Button(action: {
                                            isShowingImagePicker = true
                                        }) {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFit()
                                        }
                                        .sheet(isPresented: $isShowingImagePicker) {
                                            ImagePickerView(image: $eventImage)
                                        }
                                        
                                    }
                                    else{
                                        HStack{
                                            Button(action: {
                                                isShowingImagePicker = true
                                            }) {
                                                Text("label_create_event_image".localized(language.getLanguage()))
                                            }
                                            .sheet(isPresented: $isShowingImagePicker) {
                                                ImagePickerView(image: $eventImage)
                                            }
                                            Spacer()
                                        }
                                    }
                                    
                                }
                            }
                            .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customBackground.opacity(0.8), lineWidth: 6)
                                    .background(Color.customPrimary)
                            )
                        }.listStyle(.insetGrouped)

                        Text("label_create_event_warning".localized(language.getLanguage()))
                            .foregroundColor(Color.customSecondary)
                            .padding(0)
                            .font(.system(size: 15))
                        
                        Button {
                            isNavigate = true
                            eventViewmodel.addEvent(name: eventName, location: eventLocation, details: eventDetails, organizer: eventOrganizer, date: eventDate, image: eventImage)
                            
                            
                        } label: {
                            Text("button_create_event_create".localized(language.getLanguage()))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(!(eventName.isEmpty || eventLocation.isEmpty || eventOrganizer.isEmpty) ? Color.customButton : Color.customDisabledButton)
                                        .shadow(color: Color.customDarkBackground, radius: 3, x: 2, y: 2)
                                )
                                .padding(.horizontal)
                        }.disabled(eventName.isEmpty || eventLocation.isEmpty || eventOrganizer.isEmpty)
                        
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
            .environmentObject(LanguageViewModel())
    }
}
