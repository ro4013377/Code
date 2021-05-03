//
//  Model.swift
//  iTunes_Search
//
//  Created by Rohit Agrawal on 02/05/21.
//  Copyright © 2021 Rohit Agrawal. All rights reserved.
//

import SwiftUI


struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    
    var trackId: Int
    var trackName: String
    var artwork : String
    var name: String
    var genre: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        
        case trackId
        case trackName
        case artwork =  "artworkUrl60"
        case name = "kind"
        case genre = "primaryGenreName"
        case url = "trackViewUrl"
        
        
    }
}

