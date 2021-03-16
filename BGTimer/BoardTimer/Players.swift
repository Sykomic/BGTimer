//
//  Players.swift
//  BoardTimer
//
//  Created by 최대식 on 2021/02/22.
//

import SwiftUI

struct Players {
    var players: [Player] = [
        Player(name: "", color: Color.red),
        Player(name: "", color: Color.blue),
        Player(name: "", color: Color.green),
        Player(name: "", color: Color.yellow),
        Player(name: "", color: Color.purple)
    ]
    
    init() {
        self.players = [
            Player(name: "", color: Color.red),
            Player(name: "", color: Color.blue),
            Player(name: "", color: Color.green),
            Player(name: "", color: Color.yellow),
            Player(name: "", color: Color.purple)
        ]
    }
    
    init(players: [Player]) {
        self.players = players
    }
    
    init(names: [String], places: [Int16]) {
        var p: [Player] = []
        for i in 0 ..< names.count {
            p.append(Player(name: names[i], place: Int(places[i])))
        }
        self.players = p
    }
}
