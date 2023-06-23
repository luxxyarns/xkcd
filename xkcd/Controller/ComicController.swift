//
//  Networking.swift
//  xkcd
//
//  Created by Marco Nissen on 21.06.23.
//

import Foundation
import Cache

public class ComicController {
    var storage: Storage<String, [ComicModel]>?
    
    private static var _shared: ComicController?
    public static var shared: ComicController {
        if _shared == nil {
            _shared = ComicController()
        }
        if let value = _shared {
            return value
        }
        return ComicController()
    }
    
    init() {
        let diskConfig = DiskConfig(name: "disk")
        let memoryConfig = MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10)
        
        storage = try? Storage<String, [ComicModel]>(
            diskConfig: diskConfig,
            memoryConfig: memoryConfig,
            transformer: TransformerFactory.forCodable(ofType: [ComicModel].self)
        )
        do {
            if try storage?.existsObject(forKey: "favorites") == false {
                storage?.async.setObject([], forKey: "favorites", completion: { _ in
                    
                })
            }
        } catch {
            
        }
    }
    
    public func getFavorites() -> [ComicModel] {
        do {
            if let array = try storage?.object(forKey: "favorites") {
                return array
            }
        } catch {
            
        }
        return []
    }
    
    public func isFavorite(byID: Int) -> Bool {
        do {
            if let array = try storage?.object(forKey: "favorites") {
                if array.contains(where: { comic in
                    return comic.num == byID
                }) {
                    return true
                }
                return false
            }
        } catch {
            
        }
        return false
    }
    public func toggleFavorite(comic: ComicModel) {
        if !isFavorite(byID: comic.num) {
            do {
                if let array = try storage?.object(forKey: "favorites") {
                    var newArray = array
                    newArray.append(comic)
                    try storage?.setObject(newArray, forKey: "favorites")
                   
                }
            } catch {
                
            }
        } else {
            do {
                if let array = try storage?.object(forKey: "favorites") {
                    var newArray = array
                    newArray.removeAll(where: { currentComic in
                        return comic.num == currentComic.num
                    })
                    try storage?.setObject(newArray, forKey: "favorites")
                }
            } catch {
                
            }
        }
    }
    
    public func fetchLatestComicNumber() async throws -> Int {
        let comic = try await fetchLatestComic()
        return comic.num
    }
    
    public func fetchLatestComic() async throws -> ComicModel {
        let endpointURL = URL(string: "https://xkcd.com/info.0.json")!
        let (data, _) = try await URLSession.shared.data(from: endpointURL)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(ComicModel.self, from: data)
    }
    
    public func fetchComic(byNumber number: Int) async throws -> ComicModel {
        let endpointURL = URL(string: "https://xkcd.com/\(number)/info.0.json")!
        let (data, _) = try await URLSession.shared.data(from: endpointURL)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(ComicModel.self, from: data)
    }
    
}
