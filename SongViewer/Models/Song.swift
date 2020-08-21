//
//  Song.swift
//  SongViewer
//
//  Created by Matthew Dias on 8/20/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import Foundation

struct Song: Codable {
    var trackId: Int
    var artistName: String
    var collectionName: String // album name
    var trackName: String
    var artworkUrl100: URL
}
