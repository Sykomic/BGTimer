//
//  Player.swift
//  BoardTimer
//
//  Created by 최대식 on 2021/02/19.
//
import SwiftUI

struct Player {
    var name: String = "name"
    var color: Color = Color.red
    var place: Int = 0
    var finish: Bool = false
    var first: Bool = false
    var order: Int = 0
    var entered: Bool = false
    
    init() {
        self.name = "name"
        self.color = Color.red
        self.place = 0
        self.finish = false
        self.first = false
        self.order = 0
        self.entered = false
    }
    
    init(name: String = "name", color: Color = Color.red, first: Bool = false, order: Int = 0) {
        self.name = name
        self.color = color
        self.first = first
        self.order = order
    }
    
    init(name: String = "name", place: Int = 0) {
        self.name = name
        self.place = place
    }
}
