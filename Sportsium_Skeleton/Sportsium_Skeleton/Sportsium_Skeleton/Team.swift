//
//  Team.swift
//  Sportsium_Skeleton
//
//  Created by Gustavo Ramirez on 11/22/19.
//  Copyright © 2019 Alina Drebin. All rights reserved.
//

import Foundation

struct Constants {

    let orlandoPride: TeamInfo
    let skyBlue: TeamInfo
    let houstonDash: TeamInfo
    let washingtonSpirit: TeamInfo
    let northCarolinaCourage: TeamInfo
    let reign: TeamInfo
    let portlandThorns: TeamInfo
    let chicagoRedStars: TeamInfo
    let utahRoyals: TeamInfo

  struct TeamInfo {
    
    let cityLocation: String
    let league: String
    let dateFounded: String
    let instagram: String
    let currentWins: String
    let twitter: String
    let snapchat: String
    let currentTies: String
    let currentLosses: String
    let fb: String
    let headCoach: String
    let stadium: String
    let playerList: [Player]

  }

  struct Player {
    
    let firstName: String
    let lastName: String
    let instagram: String
    let hometown: String
    let twitter: String
    let number: String
    let snapchat: String
    let height: String
    let fb: String
    let DOB: String
    let country: String
    let playerId: Int
    let position: String

  }

}






    
