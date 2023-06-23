//
//  RemoteImage.swift
//  xkcd
//
//  Created by Marco Nissen on 21.06.23.
//

import SwiftUI

struct RemoteImage: View {
    @StateObject private var imageLoader: ImageLoader
    
    init(url: String?) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(urlString: url))
    }
    
    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
        } else {
            Color.gray
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    init(urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(url: "https://example.com/image.jpg")
            .frame(width: 200, height: 200)
    }
}
