//
//  Player.swift
//  Overlay_test
//
//  Created by Claire Drebin on 11/24/19.
//  Copyright © 2019 Claire Drebin. All rights reserved.
//

import Foundation
import SwiftUI

struct Player: Identifiable {
    
    /// unique id
    var id: String = UUID().uuidString
    
    /// user name
    let name: String
    
    /// user profile avatar
    let avatar: String
    
    /// player number
    let number: String
    
    let team: String
    
    /// Init
    init(name: String, avatar: String, number: String, team: String) {
        self.name = name
        self.avatar = avatar
        self.number = number
        self.team = team
    }
}
