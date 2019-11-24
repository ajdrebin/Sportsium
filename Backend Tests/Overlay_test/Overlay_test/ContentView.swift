//
//  ContentView.swift
//  Overlay_test
//
//  Created by Claire Drebin on 11/24/19.
//  Copyright © 2019 Claire Drebin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    /// statuses
    let cards = TestData.cards()
    let identified = TestData.identified()
    
    func getIdPlayers() -> [Player] {
        var subCards: [Player] = []
        
        
        for id in identified {
            for player in cards {
                if player.team == id.team && player.number == id.number {
                    subCards.append(player)
                }
            }
        }
        return subCards
    }
    
    /// view body
    var body: some View {
        
        NavigationView {
            List {
                
                // statuses
                ScrollView(Axis.Set.horizontal, content: {
                    HStack(spacing: 10) {
                        ForEach(getIdPlayers()) { player in
                            CardView(player: player)
                        }
                    }
                    .padding(.leading, 10)
                })
                .frame(height: 190)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
