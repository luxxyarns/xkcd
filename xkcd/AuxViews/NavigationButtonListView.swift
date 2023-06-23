//
//  NavigationButtonListView.swift
//  xkcd
//
//  Created by Marco Nissen on 21.06.23.
//
import SwiftUI

struct NextButtonView: View {
    @EnvironmentObject var comicManager: ComicManager
    var idiom: UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    var action: () -> Void
    var body: some View {
        if idiom == .phone {
            if comicManager.hasNext() {
                Button(action: action) {
                    Image(systemName: "chevron.right.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }
            } else {
                Button(action: action) {
                    Image(systemName: "chevron.right.circle")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }
            }
        } else {
            if comicManager.hasNext() {
                Button(action: action) {
                    Label("show next", systemImage: "chevron.right.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }
            } else {
                Button(action: action) {
                    Label("show next", systemImage: "chevron.right.circle")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }
            }
        }
    }
}
struct PreviousButtonView: View {
    @EnvironmentObject var comicManager: ComicManager
    var idiom: UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    var action: () -> Void
    var body: some View {
        if idiom == .phone {
            if comicManager.hasPrevious() {
                Button(action: action) {
                    Image(systemName: "chevron.left.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }
            } else {
                Button(action: action) {
                    Image(systemName: "chevron.left.circle")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }
            }
        } else {
            if comicManager.hasPrevious() {
                Button(action: action) {
                    Label("show previous", systemImage: "chevron.left.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }
            } else {
                Button(action: action) {
                    Label("show previous", systemImage: "chevron.left.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }
            }
        }
    }
}

struct NumberButtonView: View {
    @EnvironmentObject var comicManager: ComicManager
    var idiom: UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    var action: () -> Void
    var body: some View {
        if idiom == .phone {
            Button(action: action) {
                Image(systemName: "number")
                    .foregroundColor(.blue)
                    .font(.system(size: 30))
            }
        } else {
            Button(action: action) {
                Label("enter comic id", systemImage: "number")
                    .foregroundColor(.blue)
                    .font(.system(size: 30))
            }
        }
    }
}

struct SearchButtonView: View {
    @EnvironmentObject var comicManager: ComicManager
    var idiom: UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    var action: () -> Void
    var body: some View {
        if idiom == .phone {
            Button(action: action) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.blue)
                    .font(.system(size: 30))
            }
        } else {
            Button(action: action) {
                Label("search comic", systemImage: "magnifyingglass")
                    .foregroundColor(.blue)
                    .font(.system(size: 30))
            }
        }
    }
}

struct FavoriteButtonView: View {
    @EnvironmentObject var comicManager: ComicManager
    var idiom: UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    var action: () -> Void
    var body: some View {
        if idiom == .phone {
            if comicManager.isFavorited {
                Button(action: action) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }
            } else {
                Button(action: action) {
                    Image(systemName: "heart")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }
            }
        } else {
            if comicManager.isFavorited {
                Button(action: action) {
                    Label("unfavorite comic", systemImage: "heart.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }
            } else {
                Button(action: action) {
                    Label("favorite comic", systemImage: "heart")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }
            }
        }
    }
}

struct SafariButtonView: View {
    @EnvironmentObject var comicManager: ComicManager
    var idiom: UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    var action: () -> Void
    var body: some View {
        if idiom == .phone {
            Button(action: action) {
                Image(systemName: "safari")
                    .foregroundColor(.blue)
                    .font(.system(size: 30))
            }
        } else {
            Button(action: action) {
                Label("open details", systemImage: "safari")
                    .foregroundColor(.blue)
                    .font(.system(size: 30))
            }
        }
    }
}

struct NavigationButtonListView: View {
    @EnvironmentObject var comicManager: ComicManager
    var previousAction: () -> Void
    var nextAction: () -> Void
    var enterIDAction: () -> Void
    var searchAction: () -> Void
    var favoriteAction: () -> Void
    var safariAction: () -> Void
    var idiom: UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    
    var body: some View {
        if idiom == .phone {
            HStack {
                PreviousButtonView(action: previousAction)
                NextButtonView(action: nextAction)
                Spacer()
                NumberButtonView(action: enterIDAction)
                SearchButtonView(action: searchAction)
                FavoriteButtonView(action: favoriteAction)
                SafariButtonView(action: safariAction)
                
            }
            .padding()
        } else {
            VStack(alignment: .leading) {
                PreviousButtonView(action: previousAction)
                    .padding(5)
                NextButtonView(action: nextAction)
                    .padding(5)
                Spacer()
                    .frame(height: 20)
                NumberButtonView(action: enterIDAction)
                    .padding(5)
                SearchButtonView(action: searchAction)
                    .padding(5)
                FavoriteButtonView(action: favoriteAction)
                    .padding(5)
                SafariButtonView(action: safariAction)
                    .padding(5)
                
            }
            .padding()
        }
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
