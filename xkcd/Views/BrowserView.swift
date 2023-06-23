//
//  BrowserView.swift
//  xkcd
//
//  Created by Marco Nissen on 21.06.23.
//

import SwiftUI

struct BrowserView: View {
    @EnvironmentObject var comicManager: ComicManager
    @State var isShowingPopupEnterID = false
    @State var isShowingPopupSearch = false
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        NavigationView {
            if horizontalSizeClass == .compact {
                if comicManager.isOnline == false {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("You are currently 'offline', i.e. you cannot access the internet to browse comics. However, if you have selected comics as favorites, you can still read them")
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding()
                    .navigationBarItems(trailing: statusView)
                    .navigationTitle("Comics")
                } else {
                    VStack {
                        LoadingComicView()
                            .environmentObject(comicManager)
                        NavigationComicView(isShowingPopupEnterID: $isShowingPopupEnterID,
                                            isShowingPopupSearch: $isShowingPopupSearch)
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
                    .navigationBarItems(trailing: statusView)
                    .navigationTitle("Comics")
                }
            } else {
                NavigationComicView(isShowingPopupEnterID: $isShowingPopupEnterID,
                                    isShowingPopupSearch: $isShowingPopupSearch)
                .environmentObject(comicManager)
                LoadingComicView()
                    .environmentObject(comicManager)
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
                    .navigationBarItems(trailing: statusView)
                    .navigationSplitViewStyle(.balanced)
                
            }
            
        }
    }
        
    var statusView: some View {
        Group {
            if comicManager.isOnline {
                Image(systemName: "network")
                    .foregroundColor(.green)
            } else {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
            }
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
