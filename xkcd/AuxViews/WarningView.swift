//
//  WarningView.swift
//  xkcd
//
//  Created by Marco Nissen on 23.06.23.
//

import SwiftUI

struct WarningView: View {
    let message: String
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(.yellow)
            
            Text(message)
                .font(.body)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct WarningView_Previews: PreviewProvider {
    static var previews: some View {
        WarningView(message: "caution")
    }
}
