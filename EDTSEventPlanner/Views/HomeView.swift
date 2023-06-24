//
//  HomeView.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @EnvironmentObject var language: LanguageViewModel
    @EnvironmentObject var eventViewmodel: EventViewModel
    @State private var selectedSortIndex: Int = 0
    var displayOptions: [String] = ["label_home_sort_by_made","label_home_sort_by_name","label_home_sort_by_date"]
    var options: [String] = ["id","name","date"]
    
    var body: some View {
        NavigationView {
            GeometryReader{geometry in
                ZStack{
                    VStack{
                        HStack{
                            
                            NavigationLink(destination: ProfileView()) {
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(Color.customPrimary)

                            }
                            Spacer()
                            
                            Text("title_home_header".localized(language.getLanguage()))
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(Color.customPrimary)
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            PullDownView(selectedIndex: $selectedSortIndex, options: displayOptions) { index in
                                eventViewmodel.sortEntities(option: options[index])
                            }
                        }
                        .padding()
                        .frame(height: geometry.size.height / 10)
                        .background(Color.customBackground)
                        
                            if(eventViewmodel.eventEntities.count != 0){
                                ScrollView {

                                LazyVStack(spacing: 16) {
                                    
                                    ForEach(eventViewmodel.eventEntities, id: \.id) { eventEntity in
                                        EventCardView(event: eventEntity)
                                    }
                                }
                                .padding()
                            }
                            }
                            else{
                                Spacer()
                                Text("label_home_empty_event".localized(language.getLanguage()))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.customSecondary)
                                Spacer()
                            }
                        
                        
                    }
                    VStack{
                        
                        Spacer()
                        
                        HStack{
                            Spacer()
                            NavigationLink(destination: CreateEventView()) {
                                HStack{
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(Color.customPrimary)
                                        .font(.system(size: 30))

                                        
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color.customButton)
                                        .shadow(color: Color.customDarkBackground, radius: 3, x: 2, y: 1)

                                )
                                
                            }
                            .padding()
                        }
                        .frame(height: geometry.size.height / 10)
                    }
                }
                
            }
        }
        .navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(EventViewModel())
            .environmentObject(LanguageViewModel())
            .environmentObject(AuthViewModel())
    }
}
