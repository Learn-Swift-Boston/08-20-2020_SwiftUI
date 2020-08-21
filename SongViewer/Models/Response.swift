//
//  Response.swift
//  SongViewer
//
//  Created by Matthew Dias on 8/20/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import Foundation

struct Response: Codable {
    var results: [Song]
}
