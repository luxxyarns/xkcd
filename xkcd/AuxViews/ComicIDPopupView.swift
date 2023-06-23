//
//  ComicIDPopupView.swift
//  xkcd
//
//  Created by Marco Nissen on 21.06.23.
//

import SwiftUI

struct ComicIDPopupView: View {
    @Binding var isShowingPopup: Bool
    @State private var comicID: String = ""
    
    var confirmAction: (String) -> Void
    
    var body: some View {
        VStack {
            Text("Enter Comic ID")
                .font(.title)
            
            TextField("Comic ID", text: $comicID)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Button("Cancel") {
                    isShowingPopup = false
                }
                .padding()
                
                Button("Confirm") {
                    confirmAction(comicID)
                    isShowingPopup = false
                }
                .padding()
                .disabled(comicID.isEmpty)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10) 
        .padding()
        
    }
}
