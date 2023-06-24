//
//  PullDownView.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import SwiftUI

struct PullDownView: View {
    @Binding var selectedIndex: Int
    let options: [String]
    let optionSelected: (Int) -> Void
    
    var body: some View {
        Menu{
            ForEach(options.indices, id: \.self) { index in
                Button(role: .none, action: {
                    selectedIndex = index
                    optionSelected(selectedIndex)
                }) {
                    Text(options[index])
                }.frame(maxWidth: .infinity)
            }

            } label: {
                 Image(systemName: "ellipsis.circle")
                    .font(.system(size: 40))
                    .padding()
                    .foregroundColor(Color.customPrimary)
                    .padding(.bottom)
            }
    }
}

struct PullDownView_Previews: PreviewProvider {
    @State static var selectedIndex = 0

    static var previews: some View {
        PullDownView(selectedIndex: $selectedIndex, options: ["one", "two", "three"]) { option in
            // Custom action to be performed when an option is selected
            print("Selected option: \(option)")
        }
    }
}

