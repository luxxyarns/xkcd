//
//  NavigationComicView.swift
//  xkcd
//
//  Created by Marco Nissen on 23.06.23.
//

import SwiftUI

struct NavigationComicView: View {
    @EnvironmentObject var comicManager: ComicManager
    @Binding var isShowingPopupEnterID: Bool
    @Binding var isShowingPopupSearch: Bool
    var body: some View {
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
}
 
