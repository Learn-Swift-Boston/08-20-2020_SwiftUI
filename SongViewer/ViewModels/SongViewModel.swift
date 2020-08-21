//
//  SongViewModel.swift
//  SongViewer
//
//  Created by Matthew Dias on 8/20/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import UIKit

class SongViewModel: ObservableObject {
    @Published var songs = [Song]()
    @Published var albumImage = UIImage()
    
    func getData() {
        let url = URL(string: "https://itunes.apple.com/search?term=311&entity=song")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("something went wrong!\n\(error?.localizedDescription)")
                return
            }
            
            guard let results = try? JSONDecoder().decode(Response.self, from: data) else {
                print("something went wrong while decoding")
                return
            }
            
            DispatchQueue.main.async {
                self.songs = results.results
            }
            
        }.resume()
    }
    
    func getImage(for song: Song) {
        URLSession.shared.dataTask(with: song.artworkUrl100) { (data, response, error) in
            guard let data = data else {
                print("bad image maybe?")
                return
            }
            
            DispatchQueue.main.async {
                self.albumImage = UIImage(data: data) ?? UIImage()
            }
        }.resume()
    }
}
