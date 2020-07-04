//
//  ItemDetail.swift
//  Framed
//
//  Created by Noah Scholfield on 6/28/20.
//

import SwiftUI

struct ItemDetail: View {
    var id: String
    @ObservedObject var itemDetails: FetchItemDetails
    init(id: String) {
        self.id = id;
        itemDetails = FetchItemDetails(id: id)
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .leading) {
                    NetworkImage(imageURL: itemDetails.item.imageURL)
                    Text("By: \(itemDetails.item.photographer)")
                        .font(.title2)
                    Text(itemDetails.item.description)
                        .padding(.top)
                    HStack {
                        Text("\(itemDetails.item.color ?? "None"), \(itemDetails.item.category ?? "None")")
                    }
                    .padding(.top)
                    Spacer()
                }
                
            .padding()
            Spacer()
        }
        .navigationTitle(itemDetails.item.name)
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ItemDetail(id: "5")
        }
    }
}
