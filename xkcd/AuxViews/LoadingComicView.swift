//
//  LoadingComicView.swift
//  xkcd
//
//  Created by Marco Nissen on 23.06.23.
//

import SwiftUI

struct LoadingComicView: View {
    @EnvironmentObject var comicManager: ComicManager
    var body: some View {
        if let comic = comicManager.currentComic {
            ComicCardView(comic: comic)
                .environmentObject(comicManager)
        } else {
            ComicCardProgressView()
        }
    }
}
 
