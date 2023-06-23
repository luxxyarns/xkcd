//
//  FavoritesView.swift
//  xkcd
//
//  Created by Marco Nissen on 21.06.23.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var comicManager: ComicManager
    @State private var selectedComic: ComicModel?
    
    var body: some View {
        NavigationView {
            if comicManager.currentFavorites.isEmpty {
                VStack(alignment: .leading) {
                    HStack {
                        Text("You have not yet selected any comics as favorites. Please browse the library and if you find a comic, click on the heart icon")
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
                .navigationTitle("Favorites")

            } else {
                List {
                    ForEach(comicManager.currentFavorites) { comic in
                        NavigationLink(destination: FocusedComicView(comic: comic)) {
                            HStack {
                                RemoteImage(url: comic.img ?? "")
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(4)
                                
                                VStack(alignment: .leading) {
                                    Text(comic.title)
                                        .font(.headline)
                                    
                                    Text("Creation Date: \(comic.month)/\(comic.year)")
                                        .font(.subheadline)
                                }
                                
                                Spacer()
                                
                                Text("\(comic.num)")
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                                    .padding(.trailing)
                            }
                            .swipeActions {
                                Button(action: {
                                    removeComic(comic)
                                }) {
                                    Label("Remove", systemImage: "trash")
                                }
                                .tint(.red)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Favorites")
            }
        }
    }
    
    func removeComic(_ comic: ComicModel) {
        comicManager.toggleFavorite(comic: comic)
    }
}
