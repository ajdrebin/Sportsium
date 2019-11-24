//
//  Card.swift
//  Overlay_test
//
//  Created by Claire Drebin on 11/24/19.
//  Copyright © 2019 Claire Drebin. All rights reserved.
//

import Foundation
import SwiftUI

struct Card: Identifiable {
    
    /// unique id
    var id: String = UUID().uuidString
    
    /// user
    let player: Player
    
    /// Init
    init(player: Player) {
        self.player = player
    }
}
