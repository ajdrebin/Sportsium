//
//  CardView.swift
//  Overlay_test
//
//  Created by Claire Drebin on 11/24/19.
//  Copyright © 2019 Claire Drebin. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

/// StatusView
struct CardView: View {
    
    /// status
    let player: Player
    
    /// body
    var body: some View {
    
        // status image
        Image(player.team)
            
            .resizable()  // resizable image
            .frame(width: 100, height: 100) // image frame
            
             // create outer view with border (color, width)
            .border(Color.gray.opacity(0.5), width: 0.5)
            
             // apply cornerRadius to hide visible cut out after applying border
            .cornerRadius(8)
            
            // for creating dark shadow behind the text
            .overlay(NameOverlay(name: player.name, number: player.number))
    }
}


/// NameOverlay
struct NameOverlay: View {
    
    /// name
    let name: String
    let number: String
    
    /// gradient colors
    let colors: [Color] = [Color.gray.opacity(0.5), Color.gray.opacity(0)]
    
    /// gradient
    var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: colors),
                       startPoint: .bottomLeading, endPoint: .center)
    }
    
    /// body
    var body: some View {
        
        // ZStack - places views above each other
        ZStack(alignment: .bottomLeading) {
            
            // create a rectagular gradient from bottomLeading edge to center edge
            Rectangle().fill(gradient).cornerRadius(8)
            
            // create text above the gradient
            Text(number + " " + name).font(.footnote).bold().lineLimit(2).padding(5)
        }
        .foregroundColor(.white)
    }
}

