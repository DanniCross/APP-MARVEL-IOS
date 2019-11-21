//
//  Model.swift
//  Marvel
//
//  Created by Prog on 18/10/19.
//  Copyright © 2019 Prog. All rights reserved.
//

import Foundation

struct Root: Decodable {
    let data: Data
}

struct Data: Decodable {
    let results: [Results]
}

struct Results: Decodable {
    let name: String
    let description: String
    let thumbnail: Thumbnail
    let comics: Comics
    let series: Series
    let stories: Stories
    let events: Events
}

struct Thumbnail: Decodable {
    let path: String
}

struct Comics: Decodable {
    let available: Int
}

struct Series: Decodable {
    let available: Int
}

struct Stories: Decodable {
    let available: Int
}

struct Events: Decodable {
    let available: Int
}
