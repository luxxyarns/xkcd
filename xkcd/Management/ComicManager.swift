//
//  ComicManager.swift
//  xkcd
//
//  Created by Marco Nissen on 21.06.23.
//

import Foundation
import Network
import OSLog

/**
 * main management class to perform a session management kind of role
 */
public class ComicManager: NSObject, ObservableObject {

    // holds the current comic model
    @Published public var currentComic: ComicModel?

    // holds all current favorites
    @Published public var currentFavorites = [ComicModel]()
    
    // is true if the current comic is a favorite
    @Published public var isFavorited: Bool = false
    
    // is true if the app is online
    
    @Published public var isOnline: Bool = false
    
    // is true if the user views an image fullscreen
    @Published var showImageViewer: Bool = true
    @Published var showImageURL: String = ""
    
    // network monitoring to check for online / offline
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
   
    private var _currentItem: Int?
    public var currentMax: Int = 1
    
    static var _shared: ComicManager?
    public static var shared: ComicManager {
        if let manager = _shared {
            return manager
        }
        _shared = ComicManager()
        return _shared!
    }
     public func startMonitoringNetwork() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isOnline = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
    public func stopMonitoringNetwork() {
        monitor.cancel()
    }
    
    public var currentItem: Int {
        let defaults = UserDefaults.standard
        if let value = _currentItem {
            return value
        }
        if let lastID = defaults.object(forKey: "lastComicID") as? Int {
            updateComic(newID: lastID)
            return lastID
        }
        updateComic(newID: 1)
        return 1
    }
    
    public override init() {
        super.init()
       
        _ = currentItem
        if let max = UserDefaults.standard.object(forKey: "maxComicID") as? Int {
            self.currentMax = max
        }
        Task {
            do {
                self.currentMax = try await ComicController.shared.fetchLatestComicNumber()
                UserDefaults.standard.set(self.currentMax, forKey: "maxComicID")
                UserDefaults.standard.synchronize()
            } catch let err {
                Logger().error("error in \(#file) \(#line) \(#function): \(err.localizedDescription)")
         
            }
        }
        updateFavorites()
        
    }
    
    private func updateFavorites() {
        DispatchQueue.main.async {
            self.currentFavorites = ComicController.shared.getFavorites()
        }
    }
     
    public func previous() {
        if let value = _currentItem,
           hasPrevious() {
            updateComic(newID: value - 1)
        }
    }
    
    public func toggleFavorite() {
         if let comic = currentComic {
            toggleFavorite(comic: comic)
        }
     }
    
    public func toggleFavorite(comic: ComicModel) {
            ComicController.shared.toggleFavorite(comic: comic)
            self.checkFavorite()
    
        updateFavorites()
    }
    
    public func hasPrevious() -> Bool {
        if let value = _currentItem, value > 1 {
            return true
        }
        return false
    }
    
    public func next() {
        if let value = _currentItem,
           hasNext() {
            updateComic(newID: value + 1)
        }
    }
    
    public func hasNext() -> Bool {
        if let value = _currentItem,
           value < currentMax {
            return true
        }
        return false
    }
    
    public func checkFavorite() {
        DispatchQueue.main.async {
            if let newID  = self._currentItem {
                if ComicController.shared.isFavorite(byID: newID) {
                    self.isFavorited = true
                } else {
                    self.isFavorited = false
                }
            }
        }
    }
    
    public func updateComic(newID: Int) {
        self.currentComic = nil
        self._currentItem = nil
  
        DispatchQueue.main.async {
            let defaults = UserDefaults.standard
            defaults.set(newID, forKey: "lastComicID")
            defaults.synchronize()
            Task {
                do {
                    self._currentItem = newID
                    self.currentComic = try await ComicController.shared.fetchComic(byNumber: newID)
                    self.checkFavorite()
                } catch let err {
                    Logger().error("error in \(#file) \(#line) \(#function): \(err.localizedDescription)")
             
                }
            }
        }
        
    }
    
}
