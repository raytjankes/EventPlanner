//
//  PullDownView.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import SwiftUI

struct PullDownView: View {
    @EnvironmentObject var language: LanguageViewModel
    @Binding var selectedIndex: Int
    let options: [String]
    
    // Custom action depending on the choice picked
    let optionSelected: (Int) -> Void
    
    var body: some View {
        Menu{
            ForEach(options.indices, id: \.self) { index in
                Button(role: .none, action: {
                    selectedIndex = index
                    optionSelected(selectedIndex)
                }) {
                    Text(options[index].localized(language.getLanguage()))
                }.frame(maxWidth: .infinity)
            }

            } label: {
                 Image(systemName: "ellipsis.circle")
                    .font(.system(size: 40))
                    .foregroundColor(Color.customPrimary)
            }
    }
}

struct PullDownView_Previews: PreviewProvider {
    @State static var selectedIndex = 0

    static var previews: some View {
        PullDownView(selectedIndex: $selectedIndex, options: ["one", "two", "three"]) { option in
            print("Selected option: \(option)")
        }
        .environmentObject(LanguageViewModel())
    }
}

