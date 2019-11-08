//
//  Team.swift
//  FrameIO
//
//  Created by Axel Nunez on 11/7/19.
//  Copyright © 2019 Axel Nunez. All rights reserved.
//

import Foundation

struct Team: Codable {
    
    let id: Int
    let type: String
    let attributes: Attributes
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case attributes
    }
}

struct Attributes: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
