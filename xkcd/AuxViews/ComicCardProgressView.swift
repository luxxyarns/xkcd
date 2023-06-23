//
//  ComicView.swift
//  xkcd
//
//  Created by Marco Nissen on 21.06.23.
//

import SwiftUI

struct ComicCardProgressView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Loading ...")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            
            Spacer()
            HStack {
                Spacer()
                ProgressView()
                Spacer()

            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
        
    }
}

struct ComicCardProgressView_Previews: PreviewProvider {
    @ObservedObject static var comicManager = ComicManager.shared
    
    static var previews: some View {
        
        ComicCardProgressView()
            .previewLayout(.sizeThatFits)
            .padding()
            .environmentObject(comicManager)
        
    }
}
