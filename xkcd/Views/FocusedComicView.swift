//
//  FocusedComicView.swift
//  xkcd
//
//  Created by Marco Nissen on 23.06.23.
//

import SwiftUI

struct FocusedComicView: View {
    @EnvironmentObject var comicManager: ComicManager
    @State private var isSharingSheetPresented = false
    
    let comic: ComicModel
    
    var body: some View {
        VStack {
            ComicCardView(comic: comic)
                .environmentObject(comicManager)
            
            HStack {
                Button(action: {
                    isSharingSheetPresented = true
                }) {
                    Label("Share", systemImage: "square.and.arrow.up")
                        .font(.headline)
                }
                .padding()
                .sheet(isPresented: $isSharingSheetPresented) {
                    ShareSheet(activityItems: [comic.title])
                }
                
                Spacer()
                
                Button(action: {
                    if let comic = comicManager.currentComic,
                       let url = comic.explainURL {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Label("Open in Safari", systemImage: "safari")
                        .font(.headline)
                }
                .padding()
            }
        }
    }
}
 
