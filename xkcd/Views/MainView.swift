//
//  MainView.swift
//  xkcd
//
//  Created by Marco Nissen on 21.06.23.
//

import SwiftUI
import ImageViewerRemote
import ImageViewer

struct MainView: View {
    @EnvironmentObject var comicManager: ComicManager
    @State var showImageViewer: Bool = true
    @State var showImageURL: String = ""
    
    var body: some View {
        TabView {
            BrowserView()
                .tabItem {
                    Label("Browser", systemImage: "house")
                }
                .environmentObject(comicManager)

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .environmentObject(comicManager)

        }
        .onChange(of: comicManager.showImageViewer, perform: { newValue in
            self.showImageViewer = newValue
            self.showImageURL = comicManager.showImageURL
        })
        .overlay(ImageViewerRemote(imageURL: self.$showImageURL, viewerShown: self.$showImageViewer))

    }
}

struct MainView_Previews: PreviewProvider {
    @ObservedObject static var comicManager = ComicManager.shared
static var previews: some View {
        MainView()
        .environmentObject(comicManager)

    }
}
