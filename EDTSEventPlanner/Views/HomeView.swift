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
                            
                            NavigationLink(destination: ProfileView()) {
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 40))
                                    .padding()
                                    .foregroundColor(Color.customPrimary)
                                    .padding(.bottom)

                            }
                            Spacer()
                            
                            Text("Your Plans")
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(Color.customPrimary)
                                .padding(.bottom)
                            
                            Spacer()
                            
                            PullDownView(selectedIndex: $selectedSortIndex, options: displayOptions) { index in
                                eventViewmodel.sortEntities(option: options[index])
                            }
                        }
                        .frame(height: geometry.size.height / 10)
                        .background(Color.customBackground)
                        
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
                                HStack{
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(Color.customPrimary)
                                        .font(.system(size: 30))

                                        
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color.customButton)

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
    }
}
