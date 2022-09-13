//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Maikon Ferreira on 03/12/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            let game = EmojiiMemoryGame()
            EmojiiMemoryGameView( viewModel: game)
        }
    }
}
