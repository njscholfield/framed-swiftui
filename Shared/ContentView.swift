//
//  ContentView.swift
//  Shared
//
//  Created by Noah Scholfield on 6/28/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var fetch = FetchItems()
    
    var body: some View {
        NavigationView {
                List(fetch.items) { item in
                    ItemCard(item: item)
                }
                .navigationTitle("Items")

            
                VStack {
                    Text("Select an item")
                        .font(.largeTitle)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ItemCard: View {
    var item: Item
    
    var body: some View {
        NavigationLink(destination: ItemDetail(id: item.productID)) {
            HStack {
                NetworkImage(imageURL: item.imageURL + "/300x300")
                    .frame(maxWidth: 50)
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.title2)
                    Text(item.photographer)
                        .foregroundColor(.secondary)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.vertical)
    }
}
