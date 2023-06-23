//
//  ComicModel.swift
//  xkcd
//
//  Created by Marco Nissen on 21.06.23.
//

import Foundation

public struct ComicModel: Codable, Identifiable, Comparable, Hashable, Equatable, CustomStringConvertible {
    public let id = UUID()
    let month: String
    let num: Int
    let link: String
    let year: String
    let news: String
    let safeTitle: String?
    let title: String
    let transcript: String
    let alt: String
    let img: String?
    
    enum CodingKeys: String, CodingKey {
        case id, month, num, link, year, news, alt, title, transcript, img
        case safeTitle = "safe_title"
    }
    
    public static func < (lhs: ComicModel, rhs: ComicModel) -> Bool {
        return lhs.num < rhs.num
    }
    
    public static func == (lhs: ComicModel, rhs: ComicModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    public var images: [URL] {
        guard let img = img else {
            return []
        }
        
        let imageURLs = img.components(separatedBy: " ")
        return imageURLs.compactMap { URL(string: $0) }
    }
    
    public var imagesURLsAsString: String {
        return images.map { url in
            return url.absoluteString
        }.joined(separator: ", ")
    }
    
    public var description: String {
        var description = ""
        description += "Month: \(month)\n"
        description += "Number: \(num)\n"
        description += "Link: \(link)\n"
        description += "Year: \(year)\n"
        description += "News: \(news)\n"
        description += "Safe Title: \(safeTitle ?? "")\n"
        description += "Title: \(title)\n"
        description += "Transcript: \(transcript)\n"
        description += "Alt: \(alt)\n"
        description += "Image URLs: \(imagesURLsAsString)\n"
        return description
    }
    
    public var explainURL: URL? {
        if let url = URL(string: "https://www.explainxkcd.com/wiki/index.php/\(num)" ) {
            return url
        }
        return nil 
    }
}
