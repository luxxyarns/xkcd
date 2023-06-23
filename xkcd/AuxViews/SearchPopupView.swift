//
//  SearchPopupView.swift
//  xkcd
//
//  Created by Marco Nissen on 21.06.23.
//

import SwiftUI
import SwiftSoup

struct SearchPopupView: View {
    @EnvironmentObject var comicManager: ComicManager
    @Binding var isShowingPopup: Bool
    @State private var searchText = ""
    var searchAction: (String) -> Void
    @State private var foundComics = [ComicModel]()
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    performSearch()
                }) {
                    Text("Search")
                }
            }
            .padding()
            
            if !searchText.isEmpty {
                if foundComics.isEmpty {
                    Text("no results found")
                } else {
                    List {
                        ForEach(foundComics, id: \.self) { comic in
                            Button(action: {
                                comicManager.updateComic(newID: comic.num)
                                isShowingPopup = false
                            }) {
                                Text(comic.title)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            } else {
                Text("Please enter a search term")
            }
            Spacer()
            
            Button(action: {
                searchAction(searchText)
                
                isShowingPopup = false
            }) {
                Text("Close")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }
    
    func performSearch() {
        guard let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        let searchURLString = "https://www.explainxkcd.com/wiki/index.php?search=\(encodedSearchText)&title=Special%3ASearch&go=Go"
        
        guard let searchURL = URL(string: searchURLString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: searchURL) { (data, _, error) in
            if let error = error {
                print("Search error: \(error)")
                return
            }
            
            if let data = data {
                // Process the search results data
                // Implement your logic to extract and parse the search results here
                // let searchResults = parseSearchResults(data: data)
                DispatchQueue.main.async {

                    Task {
                       await parseSearchResults(data: data)
                    }
                // Perform any necessary UI updates with the search results
                    // Update your view with the search results
                    // For example, you can store the search results in a property and use it to populate the list
                    // searchResults = ...
                }
            }
        }
        
        task.resume()
    }
    
    func parseSearchResults(data: Data) async {
        var numbers = [Int]()
        do {
            let html = String(decoding: data, as: UTF8.self)
            let doc: Document = try SwiftSoup.parse(html)

            let headerTitle = try doc.title()

            if headerTitle.count > 1 {
                let components = headerTitle.components(separatedBy: ":")
                if components.count > 1 {
                    if let numberString = components[0].components(separatedBy: .whitespaces).first,
                       let number = Int(numberString) {
                        numbers.append(number)
                    }
                }
            }
            let searchResultLinks: Elements = try doc.select(".mw-search-results .mw-search-result-heading a")
            for link in searchResultLinks {
                let title: String = try link.text()
                let components = title.components(separatedBy: ":")
                if components.count > 1 {
                    if let numberString = components[0].components(separatedBy: .whitespaces).first,
                       let number = Int(numberString) {
                        numbers.append(number)
                    }
                }
            }
        } catch Exception.Error(let type, let message) {
            print(message)
        } catch {
            print("error")
        }
        
        do {
            foundComics = try await withThrowingTaskGroup(of: [ComicModel].self) { group -> [ComicModel] in
                for number in numbers {
                    group.addTask {
                        return [try await ComicController.shared.fetchComic(byNumber: number)]
                    }
                }
                
                let allComics = try await group.reduce(into: [ComicModel]()) { $0 += $1 }
                print(allComics)
                return allComics.sorted { $0.num > $1.num }
            }
        } catch {
            print("Failed to load stories")
        }
         
    }
}
