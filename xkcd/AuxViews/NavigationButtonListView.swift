//
//  NavigationButtonListView.swift
//  xkcd
//
//  Created by Marco Nissen on 21.06.23.
//
import SwiftUI

struct NavigationButtonListView: View {
    @EnvironmentObject var comicManager: ComicManager
    var previousAction: () -> Void
    var nextAction: () -> Void
    var enterIDAction: () -> Void
    var searchAction: () -> Void
    var favoriteAction: () -> Void
    var safariAction: () -> Void
    
    var body: some View {
        HStack {
            if comicManager.hasPrevious() {
                Button(action: previousAction) {
                    Image(systemName: "chevron.left.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }
            } else {
                Button(action: previousAction) {
                    Image(systemName: "chevron.left.circle")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }
            }
            if comicManager.hasNext() {
                Button(action: nextAction) {
                    Image(systemName: "chevron.right.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }
            } else {
                Button(action: nextAction) {
                    Image(systemName: "chevron.right.circle")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }  
            }
            Spacer()
            Button(action: enterIDAction) {
                Image(systemName: "number")
                    .foregroundColor(.blue)
                    .font(.system(size: 30))
            }
            Button(action: searchAction) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.blue)
                    .font(.system(size: 30))
            }
            if comicManager.isFavorited {
                Button(action: favoriteAction) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }
            } else {
                Button(action: favoriteAction) {
                    Image(systemName: "heart")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }
            }
            Button(action: safariAction) {
                Image(systemName: "safari")
                    .foregroundColor(.blue)
                    .font(.system(size: 30))
            }
        }
        .padding()
    }
}

struct NavigationButtonListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationButtonListView(
            previousAction: {},
            nextAction: {},
            enterIDAction: {},
            searchAction: {},
            favoriteAction: {},
            safariAction: {}
        )
    }
}
