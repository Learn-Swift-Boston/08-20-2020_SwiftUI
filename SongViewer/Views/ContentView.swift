//
//  ContentView.swift
//  SongViewer
//
//  Created by Matthew Dias on 8/20/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import SwiftUI

struct Response: Codable {
    var results: [Song]
}

struct Song: Codable {
    var trackId: Int
    var artistName: String
    var collectionName: String // album name
    var trackName: String
    var artworkUrl100: URL
}

struct ContentView: View {
    @State var songs = [Song]()
    
    var body: some View {
        NavigationView {
            List(songs, id: \.trackId) { song in
                NavigationLink(destination: SongView(song: song)) {
                    VStack(alignment: .leading) {
                        Text(song.trackName)
                            .font(.headline)
                        Text(song.collectionName)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationBarTitle("Songs")
        }
        .onAppear(perform: { self.getData() })
    }
    
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
            
            self.songs = results.results
            
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
