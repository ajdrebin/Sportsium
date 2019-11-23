//
//  TeamInfo.swift
//  Sportsium_Skeleton
//
//  Created by Gustavo Ramirez on 11/22/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import Foundation

class TeamInfo {
    
    let cityLocation: String
    let league: String
    let dateFounded: String
    var instagram: String
    let currentWins: String
    let twitter: String
    let snapchat: String
    let currentTies: String
    let currentLosses: String
    let fb: String
    let headCoach: String
    let stadium: String
    let playerList: [Player?]
    
    init(cityLocation: String, league: String, dateFounded: String, instagram: String, currentWins: String, twitter: String, snapchat: String, currentTies: String, currentLosses: String, fb: String, headCoach: String, stadium: String, playerList: [Player?]) {
        self.cityLocation = cityLocation
        self.league = league
        self.instagram = instagram
        self.dateFounded = dateFounded
        self.instagram = instagram
        self.currentWins = currentWins
        self.twitter = twitter
        self.snapchat = snapchat
        self.currentTies = currentTies
        self.currentLosses = currentLosses
        self.fb = fb
        self.headCoach = headCoach
        self.stadium = stadium
        self.playerList = playerList
    }

    enum CodingKeys: String, CodingKey {
        case cityLocation = "city_location"
        case league
        case dateFounded = "date_founded"
        case instagram
        case currentWins = "current_wins"
        case twitter, snapchat
        case currentTies = "current_ties"
        case currentLosses = "current_losses"
        case fb
        case headCoach = "head_coach"
        case stadium
        case playerList = "player_list"
    }
}
