//
//  HomeView.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @EnvironmentObject var eventViewmodel: EventViewModel
    @State private var selectedSortIndex: Int = 0
    var displayOptions: [String] = ["Order by Last Made","Order by Name","Order by Date"]
    var options: [String] = ["id","name","date"]
    var body: some View {
        NavigationView {
            GeometryReader{geometry in
                ZStack{
                    VStack{
                        HStack{
                            Text("Hello " + String((Auth.auth().currentUser?.email ?? "Stranger")!))
                                .foregroundColor(.white)
                                .padding()
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            NavigationLink(destination: ProfileView()) {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                            }
                            Spacer()
                            
                            PullDownView(selectedIndex: $selectedSortIndex, options: displayOptions) { index in
                                eventViewmodel.sortEntities(option: options[index])
                            }
                        }
                        .frame(height: geometry.size.height / 10)
                        .background(.black)
                        
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(eventViewmodel.eventEntities, id: \.id) { eventEntity in
                                    EventCardView(event: eventEntity)
                                }
                            }
                            .padding()
                        }
                        
                    }
                    VStack{
                        
                        Spacer()
                        
                        HStack{
                            Spacer()
                            NavigationLink(destination: CreateEventView()) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                            }
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
    }
}
