//
//  EventCardView.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import Foundation
import SwiftUI

struct EventCardView: View {
    
    @EnvironmentObject var eventViewModel: EventViewModel
    let event: EventEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            if let imageName = event.imageName, let image = UIImage(named: imageName) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                } else {
                    Color.gray
                        .frame(height: 200)
                }
            
            Text(event.name ?? "")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10)
            
            Text(event.location ?? "")
                .foregroundColor(.secondary)
            
            Text(event.details ?? "")
                .font(.body)
                .padding(.top, 5)
            
            Text(event.organizer ?? "")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top, 5)
            
            Text(dateFormatter.string(from: event.date ?? Date()))
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top, 5)
            Button(action: {
                eventViewModel.deleteEvent(event)
            }) {
                Text("Delete")
                    .foregroundColor(.red)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.red, lineWidth: 1)
                    )
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}
