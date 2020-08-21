//
//  SongView.swift
//  SongViewer
//
//  Created by Matthew Dias on 8/20/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import SwiftUI

struct SongView: View {
    let song: Song
    @ObservedObject var viewModel: SongViewModel
    
    var body: some View {
        VStack {
            Spacer(minLength: 30)
            Image(uiImage: viewModel.albumImage)
            VStack(alignment: .leading, spacing: 8) {
                Text("Artist: ")
                    .bold()
                    + Text(song.artistName)
                Text("Album: ")
                    .bold()
                    + Text(song.collectionName)
                Spacer()
            }
        }
        .onAppear(perform: { self.viewModel.getImage(for: self.song) })
        .navigationBarTitle(Text(verbatim: song.trackName), displayMode: .inline)
    }
}

struct SongView_Previews: PreviewProvider {
    static let song = Song(trackId: 1,
                           artistName: "Matt",
                           collectionName: "Greatest hits",
                           trackName: "that one about place when navigating",
                           artworkUrl100: URL(string: "https://is2-ssl.mzstatic.com/image/thumb/Music113/v4/59/9f/ff/599fffaa-f48f-0a99-3258-5550af06415f/source/100x100bb.jpg")!
    )
    
    static var previews: some View {
        NavigationView {
            SongView(song: song, viewModel: SongViewModel())
        }
    }
}
