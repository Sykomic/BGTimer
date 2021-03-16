//
//  Game.swift
//  BoardTimer
//
//  Created by 최대식 on 2021/03/02.
//
import SwiftUI

struct Game {
    var date: Date
    var winner: Player
    
    init() {
        date = Date()
        winner = Player()
    }
}
