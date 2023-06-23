//
//  ComicView.swift
//  xkcd
//
//  Created by Marco Nissen on 21.06.23.
//

import SwiftUI

struct ComicCardView: View {
    @EnvironmentObject var comicManager: ComicManager
    var comic: ComicModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(comic.title)
                .font(.title)
                .fontWeight(.bold)
            
            HStack {
                Text("Number: \(comic.num) / \(comicManager.currentMax)")
                    .font(.caption)
                Spacer()
                Text("Date: \(comic.month)/\(comic.year)")
                    .font(.caption)
            }
            
            RemoteImage(url: comic.img)
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .onTapGesture {
                    if let img = comic.img {
                        comicManager.showImageURL = img
                        comicManager.showImageViewer.toggle()
                    }
                }
            
            Spacer()
            ScrollView {
                Text(comic.alt)
                    .font(.headline)
                Spacer()
                    .frame(height: 20)
                Text(comic.transcript)
                    .font(.body)
                
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
        
    }
}

struct ComicCardView_Previews: PreviewProvider {
    @ObservedObject static var comicManager = ComicManager.shared
    
    static var previews: some View {
        let comic = ComicModel(month: "7", num: 614, link: "", year: "2009", news: "", safeTitle: "Woodpecker", title: "Woodpecker", transcript: "[[A man with a beret and a woman are standing on a boardwalk, leaning on a handrail.]]\nMan: A woodpecker!\n<<Pop pop pop>>\nWoman: Yup.\n\n[[The woodpecker is banging its head against a tree.]]\nWoman: He hatched about this time last year.\n<<Pop pop pop pop>>\n\n[[The woman walks away.  The man is still standing at the handrail.]]\n\nMan: ... woodpecker?\nMan: It's your birthday!\n\nMan: Did you know?\n\nMan: Did... did nobody tell you?\n\n[[The man stands, looking.]]\n\n[[The man walks away.]]\n\n[[There is a tree.]]\n\n[[The man approaches the tree with a present in a box, tied up with ribbon.]]\n\n[[The man sets the present down at the base of the tree and looks up.]]\n\n[[The man walks away.]]\n\n[[The present is sitting at the bottom of the tree.]]\n\n[[The woodpecker looks down at the present.]]\n\n[[The woodpecker sits on the present.]]\n\n[[The woodpecker pulls on the ribbon tying the present closed.]]\n\n((full width panel))\n[[The woodpecker is flying, with an electric drill dangling from its feet, held by the cord.]]\n\n{{Title text: If you don't have an extension cord I can get that too.  Because we're friends!  Right?}}", alt: "If you don't have an extension cord I can get that too.  Because we're friends!  Right?", img: "https://imgs.xkcd.com/comics/woodpecker.png")
        
        ComicCardView(comic: comic)
            .previewLayout(.sizeThatFits)
            .padding()
            .environmentObject(comicManager)
        
    }
}
