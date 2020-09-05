//
//  SongViewModel.swift
//  SongViewer
//
//  Created by Matthew Dias on 8/20/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import UIKit
import Combine

class SongViewModel: ObservableObject {
    @Published var songs = [Song]()
    @Published var albumImage = UIImage()
    
    private var cancellables = [Cancellable]()
    
    func getData() {
        let url = URL(string: "https://itunes.apple.com/search?term=311&entity=song")!
        
        cancellables.append(
            URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: Response.self, decoder: JSONDecoder())
                .map(\.results)
                .replaceError(with: [])
                .receive(on: DispatchQueue.main)
                .assign(to: \.songs, on: self)
        )
    }
    
    func getImage(for song: Song) {
        cancellables.append(
            URLSession.shared.dataTaskPublisher(for: song.artworkUrl100)
                .map({ UIImage(data: $0.data) })
                .replaceError(with: UIImage())
                .replaceNil(with: UIImage())
                .receive(on: DispatchQueue.main)
                .assign(to: \.albumImage, on: self)
        )
    }
}
