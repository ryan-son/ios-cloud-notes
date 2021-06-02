//
//  Note.swift
//  CloudNotes
//
//  Created by Ryan-Son on 2021/06/01.
//

import Foundation

struct Note: Decodable, Hashable {
    let title: String
    let body: String
    let lastModified: Int
    var uuid = UUID()

    
    enum CodingKeys: String, CodingKey {
        case title, body
        case lastModified = "last_modified"
    }
}
