//
//  ResultView.swift
//  BoardTimer
//
//  Created by 최대식 on 2021/02/24.
//

import SwiftUI

struct ResultView: View {
    @State var date: Date = Date()
    @State var p: Players
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var from: Double = 1
    let result: LocalizedStringKey = "Result"
    let place: LocalizedStringKey = "Place"
    let nickname: LocalizedStringKey = "Nickname"
    let restart: LocalizedStringKey = "Restart"
    let resume: LocalizedStringKey = "Resume"
    
    var body: some View {
        VStack {
            Text(result)
                .font(.title)
            Text("")
                .onAppear() {
                    self.p.players.sort {
                        $0.place < $1.place
                    }
                }
            
            Spacer()
            
            List(-1..<p.players.count, id: \.self) { item in
                if item == -1 {
                    HStack {
                        Text(place)
                        Spacer()
                        Text(nickname)
                    }
                    .font(.title)
                    .lineLimit(1)
                    
                } else {
                    HStack {
                        Text("\(item + 1).")
                        Spacer()
                        if item == 0 {
                            Image("crown")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                        }
                        Text("\(p.players[item].name)")
                    }
                    .font(.title)
                    .lineLimit(1)
                }
            }
            
            Spacer()
            
            HStack {
                Spacer()
                NavigationLink(destination: StartView().navigationBarBackButtonHidden(true)) {
                    Text(restart)
                        .font(.title)
                }
                .opacity(self.from)
                
                
                Spacer()
                
                NavigationLink(destination: TimerView(p: p, hours: hours, minutes: minutes, seconds: seconds, tH: hours, tM: minutes, tS: seconds)) {
                    Text(resume)
                        .font(.title)
                }
                .opacity(self.from)
                
                Spacer()
            }
            Spacer()
            Text(self.date, style: .date)
            Text(self.date, style: .time)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(p: Players())
    }
}
