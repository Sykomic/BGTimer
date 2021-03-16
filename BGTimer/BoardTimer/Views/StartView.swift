//
//  StartView.swift
//  BoardTimer
//
//  Created by 최대식 on 2021/02/19.
//

import SwiftUI

struct StartView: View {
    @State var p = Players()
    @State var possiblePick: [Int] = [0, 1, 2, 3, 4, 5]
    @State var picked: [String: Int] = [:]
    let record: LocalizedStringKey = "Record"
    let r: LocalizedStringKey = "Red"
    let b: LocalizedStringKey = "Blue"
    let g: LocalizedStringKey = "Green"
    let y: LocalizedStringKey = "Yellow"
    let pur: LocalizedStringKey = "Purple"
    let o: LocalizedStringKey = "Order"
    let nickname: LocalizedStringKey = "Nickname"
    let confirm: LocalizedStringKey = "Confirm"
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                    NavigationLink(destination: RecordView()) {
                        Text(record)
                    }
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Text(r) + Text(": ")
                        TextField(nickname, text: $p.players[0].name)
                        Picker(selection: $p.players[0].order, label: Text(p.players[0].order == 0 ? o :  "\(p.players[0].order)"), content: {
                            ForEach(possiblePick.filter{
                                self.filterOrder(n: $0)
                            }, id: \.self) { i in
                                Text("\(i)")
                            }
                        })
                        .onChange(of: self.p.players[0].order, perform: { value in
                            self.picked["p1"] = self.p.players[0].order
                        })
                        .frame(width: geometry.size.width/4 , height: geometry.size.height/10, alignment: .center)
                        .clipped()
                        .pickerStyle(MenuPickerStyle())
                    }
                    .font(.title)
                
                    HStack {
                        Spacer()
                        Text(b) + Text(": ")
                        TextField(nickname, text: $p.players[1].name)
                        Spacer()
                        Picker(selection: $p.players[1].order, label: Text(p.players[1].order == 0 ? o :  "\(p.players[1].order)"), content: {
                            ForEach(possiblePick.filter{
                                self.filterOrder(n: $0)
                            }, id: \.self) { i in
                                Text("\(i)")
                            }
                        })
                        .onChange(of: self.p.players[1].order, perform: { value in
                            self.picked["p2"] = self.p.players[1].order
                        })
                        .frame(width: geometry.size.width/4 , height: geometry.size.height/10, alignment: .center)
                        .clipped()
                        .pickerStyle(MenuPickerStyle())
                    }
                    .font(.title)
                    
                    HStack {
                        Spacer()
                        Text(g) + Text(": ")
                        TextField(nickname, text: $p.players[2].name)
                        Spacer()
                        Picker(selection: $p.players[2].order, label: Text(p.players[2].order == 0 ? o :  "\(p.players[2].order)"), content: {
                            ForEach(possiblePick.filter{
                                self.filterOrder(n: $0)
                            }, id: \.self) { i in
                                Text("\(i)")
                            }
                        })
                        .onChange(of: self.p.players[2].order, perform: { value in
                            self.picked["p3"] = self.p.players[2].order
                        })
                        .frame(width: geometry.size.width/4 , height: geometry.size.height/10, alignment: .center)
                        .clipped()
                        .pickerStyle(MenuPickerStyle())
                    }
                    .font(.title)
                    
                    HStack {
                        Spacer()
                        Text(y) + Text(": ")
                        TextField(nickname, text: $p.players[3].name)
                        Spacer()
                        Picker(selection: $p.players[3].order, label: Text(p.players[3].order == 0 ? o :  "\(p.players[3].order)"), content: {
                            ForEach(possiblePick.filter{
                                self.filterOrder(n: $0)
                            }, id: \.self) { i in
                                Text("\(i)")
                            }
                        })
                        .onChange(of: self.p.players[3].order, perform: { value in
                            self.picked["p4"] = self.p.players[3].order
                        })
                        .frame(width: geometry.size.width/4 , height: geometry.size.height/10, alignment: .center)
                        .clipped()
                        .pickerStyle(MenuPickerStyle())
                    }
                    .font(.title)
                    
                    HStack {
                        Spacer()
                        Text(pur) + Text(": ")
                        TextField(nickname, text: $p.players[4].name)
                        Spacer()
                        Picker(selection: $p.players[4].order, label: Text(p.players[4].order == 0 ? o :  "\(p.players[4].order)"), content: {
                            ForEach(possiblePick.filter{
                                self.filterOrder(n: $0)
                            }, id: \.self) { i in
                                Text("\(i)")
                            }
                        })
                        .onChange(of: self.p.players[4].order, perform: { value in
                            self.picked["p5"] = self.p.players[4].order
                        })
                        .frame(width: geometry.size.width/4 , height: geometry.size.height/10, alignment: .center)
                        .clipped()
                        .pickerStyle(MenuPickerStyle())
                    }
                    .font(.title)
                    
                    Spacer()
                    
                NavigationLink(destination: TimerView(p: p, from: 1)) {
                        Text(confirm)
                            .font(.title)
                    }
                .disabled(self.impossible())
                    
                    Spacer()
            }
        }
    }
    
    func filterOrder(n: Int) -> Bool {
        if n == 0 {
            return true
        }
        return !self.picked.values.contains(n)
    }
    
    func impossible() -> Bool {
        let name = self.p.players.filter {
            $0.name != ""
        }
        let nameOrder = name.filter {
            $0.order == 0
        }
        let numName = name.count
        let nNameOrder = nameOrder.count
        
        let order = self.p.players.filter {
            $0.order != 0
        }
        let orderName = order.filter {
            $0.name == ""
        }
        
        let nOrderName = orderName.count
        
        if numName < 2 {
            return true
        }
        if nNameOrder > 0 {
            return true
        }
        if nOrderName > 0 {
            return true
        }
        
        return false
    }
}


struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
