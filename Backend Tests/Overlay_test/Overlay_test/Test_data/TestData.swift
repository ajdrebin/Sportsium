//
//  TestData.swift
//  Overlay_test
//
//  Created by Claire Drebin on 11/24/19.
//  Copyright © 2019 Claire Drebin. All rights reserved.
//

import Foundation

/// Test Data
struct TestData {
    
    /// users
    static let playerAliKrieger     =   Player(name: "Ali Krieger", avatar: "ali", number: "11", team: "orlando_pride")
    static let playerKelleyOhara   =   Player(name: "Kelley O'Hara", avatar: "kelley", number: "5", team: "utah_royals" )
    static let playerSydneyLeroux       =   Player(name: "Sydney Leroux", avatar: "sydney", number: "2", team: "orlando_pride")
    static let playerMarta    =   Player(name: "Marta", avatar: "marta", number: "4", team: "orlando_pride")
    
    
    
    
    /// statuses
    static func cards() -> [Player] {
        let card1 = playerAliKrieger
        let card2 = playerKelleyOhara
        let card3 = playerSydneyLeroux
        let card4 = playerMarta
        
        return [card1, card2, card3, card4]
    }
    
    static func identified() -> [(team: String, number: String)] {
        let player1 = (team: "orlando_pride", number: "11")
        let player2 = (team: "utah_royals", number: "5")
        
        return [player1, player2]
    }
}
