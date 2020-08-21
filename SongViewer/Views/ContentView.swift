//
//  ContentView.swift
//  SongViewer
//
//  Created by Matthew Dias on 8/20/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = SongViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.songs, id: \.trackId) { song in
                NavigationLink(destination: SongView(song: song, viewModel: self.viewModel)) {
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
        .onAppear(perform: { self.viewModel.getData() })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
