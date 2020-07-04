//
//  Item.swift
//  Framed
//
//  Created by Noah Scholfield on 6/28/20.
//

import Foundation

struct Item: Codable, Identifiable {
    var productID: String
    var name: String
    var photographer: String
    var description: String
    var imageURL: String
    var category: String?
    var color: String?
    
    var id: Int { return Int(productID) ?? 0 }
    
    init() {
        productID = "0"
        name = "Placeholder"
        photographer = "Placeholder"
        description = "Placeholder"
        imageURL = ""
        category = ""
        color = ""
    }
}

struct ItemsResponse: Codable {
    var successful: Bool
    var items: [Item]
}

struct ItemDetailsResponse: Codable {
    var successful: Bool
    var itemInfo: Item
}


class FetchItems: ObservableObject {
    @Published var items = [Item]()
    
    init() {
        if let url = URL(string: "https://framed.noahscholfield.com/item/info.php") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                  do {
                    let res = try JSONDecoder().decode(ItemsResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.items = res.items
                    }
                  } catch let error {
                     print(error)
                  }
              } else {
                print("NOTHING")
              }
           }.resume()
        }
    }
}

class FetchItemDetails: ObservableObject {
    @Published var item = Item()
    
    init(id: String) {
        if let url = URL(string: "https://framed.noahscholfield.com/item/info.php?id=\(id)") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                  do {
                    let res = try JSONDecoder().decode(ItemDetailsResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.item = res.itemInfo
                    }
                  } catch let error {
                     print(error)
                  }
              } else {
                print("NOTHING")
              }
           }.resume()
        }
    }
}

//let testData = [
//    Item(productID: "4", name: "Moonrise", photographer: "Casey Horner", description: "Moonrise over half dome in Yosemite Valley", imageURL: nil),
//    Item(productID: "5", name: "Test 2", photographer: "Casey Horner", description: "Moonrise over half dome in Yosemite Valley", imageURL: nil),
//    Item(productID: "6", name: "Test 3", photographer: "Casey Horner", description: "Moonrise over half dome in Yosemite Valley", imageURL: nil),
//    Item(productID: "7", name: "Test 4", photographer: "Casey Horner", description: "Moonrise over half dome in Yosemite Valley", imageURL: nil),
//]
