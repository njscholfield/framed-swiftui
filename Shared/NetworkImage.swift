//
//  NetworkImage.swift
//  Framed
//
//  Created by Noah Scholfield on 6/28/20.
//

import SwiftUI

#if os(macOS)
import Cocoa
#endif

struct NetworkImage: View {
    var imageURL: String
    @ObservedObject var imageData: ImageData
    
    init(imageURL: String) {
        self.imageURL = imageURL
        imageData = ImageData(imageURL: imageURL)
    }
    
    var body: some View {
        VStack {
            if imageURL.isEmpty {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if imageData.data.isEmpty {
                ProgressView()
            } else {
                #if os(macOS)
                Image(nsImage: NSImage(data: imageData.data)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                #else
                Image(uiImage: UIImage(data: imageData.data)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                #endif
            }
        }
    }
}

class ImageData: ObservableObject {
    @Published var data = Data();
    
    init(imageURL: String) {
        if let url = URL(string: imageURL) {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                  do {
                    DispatchQueue.main.async {
                        self.data = data
                    }
                  }
              } else {
                print("NOTHING")
              }
           }.resume()
        }
    }
}

struct NetworkImage_Previews: PreviewProvider {
    static var previews: some View {
        NetworkImage(imageURL: "https://placehold.it/500x500")
    }
}
