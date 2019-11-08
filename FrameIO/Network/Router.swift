//
//  Router.swift
//  FrameIO
//
//  Created by Axel Nunez on 11/7/19.
//  Copyright © 2019 Axel Nunez. All rights reserved.
//

import Foundation

enum Router {
    
    case getUserProjects
    
    var scheme: String {
        switch self {
        case .getUserProjects:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .getUserProjects:
            return "frameio-swift-exercise.herokuapp.com"
        }
    }
    
    var path: String {
        switch self {
        case .getUserProjects:
            return "/projects"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getUserProjects:
            return []
        }
    }
    
    var method: String {
        switch self {
        case .getUserProjects:
            return "GET"
        }
    }
}
