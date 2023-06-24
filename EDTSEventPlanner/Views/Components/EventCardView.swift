//
//  EventCardView.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import Foundation
import SwiftUI

struct EventCardView: View {
    @EnvironmentObject var language: LanguageViewModel
    @EnvironmentObject var eventViewModel: EventViewModel
    let event: EventEntity
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                if let imageName = event.imageName {
                    let imagePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imageName)
                    if let imageData = try? Data(contentsOf: imagePath), let image = UIImage(data: imageData) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                    } else {
                        Color.gray
                            .frame(height: 200)
                    }
                } else {
                    Color.gray
                        .frame(height: 200)
                }
                
                Text(event.name ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                
                Text("label_card_at".localized(language.getLanguage()) + " " + (event.location ?? ""))
                    .foregroundColor(.secondary)
                
                Text(event.details ?? "")
                    .font(.body)
                    .padding(.top, 5)
                
                Text("label_card_by".localized(language.getLanguage()) + " " + (event.organizer ?? ""))
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
                
                Text(dateFormatter.string(from: event.date ?? Date()))
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
            }
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        eventViewModel.deleteEvent(event)
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                            .padding(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.red, lineWidth: 1)
                            )
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.customDarkBackground, radius: 5, x: 0, y: 2)
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}
