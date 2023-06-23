//
//  xkcdApp.swift
//  xkcd
//
//  Created by Marco Nissen on 21.06.23.
//

import SwiftUI

@main
struct xkcdApp: App {
    @ObservedObject var comicManager = ComicManager.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(comicManager)
        }
    }
}
