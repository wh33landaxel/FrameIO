//
//  ProjectsAndTeams.swift
//  FrameIO
//
//  Created by Axel Nunez on 11/8/19.
//  Copyright © 2019 Axel Nunez. All rights reserved.
//

import Foundation

struct ProjectsAndTeams: Codable {
    var projects: [Project]?
    let teams: [Team]?
    
    enum CodingKeys: String, CodingKey {
        case projects = "data"
        case teams = "included"
    }
}
