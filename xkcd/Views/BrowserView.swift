//
//  BrowserView.swift
//  xkcd
//
//  Created by Marco Nissen on 21.06.23.
//

import SwiftUI

struct BrowserView: View {
    @EnvironmentObject var comicManager: ComicManager
    @State private var isShowingPopupEnterID = false
    @State private var isShowingPopupSearch = false
    
    var body: some View {
        NavigationView {
            VStack {
                if let comic = comicManager.currentComic {
                    ComicCardView(comic: comic)
                        .environmentObject(comicManager)
                } else {
                    ProgressView()
                }
                NavigationButtonListView {
                    comicManager.previous()
                } nextAction: {
                    comicManager.next()
                } enterIDAction: {
                    isShowingPopupEnterID = true
                } searchAction: {
                    isShowingPopupSearch = true
                } favoriteAction: {
                    comicManager.toggleFavorite()
                } safariAction: {
                    if let comic = comicManager.currentComic,
                         let url = comic.explainURL {
                        UIApplication.shared.open(url)
                    }
                }
                .environmentObject(comicManager)
                
            }
            
            .sheet(isPresented: $isShowingPopupEnterID) {
                ComicIDPopupView(isShowingPopup: $isShowingPopupEnterID, confirmAction: { comicID in
                    if let value = Int(comicID) {
                        comicManager.updateComic(newID: value)
                    }
                })
            }
            
            .sheet(isPresented: $isShowingPopupSearch) {
                SearchPopupView(isShowingPopup: $isShowingPopupSearch, searchAction: { _ in
                    
                })
            }
            .navigationTitle("Comics")

        }
    }
    
}

struct BrowserView_Previews: PreviewProvider {
    @ObservedObject static var comicManager = ComicManager.shared
    
    static var previews: some View {
        BrowserView()
            .environmentObject(comicManager)

    }
}
