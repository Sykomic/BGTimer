//
//  SetTimeView.swift
//  BoardTimer
//
//  Created by Sykomic on 2021/01/19.
//

import SwiftUI

struct SetTimeView: View {
    @State var p: Players = Players()
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var hourSet: Int = 0
    @State var minuteSet: Int = 0
    @State var secondSet: Int = 0
    let setTime: LocalizedStringKey = "Set Time"
    let sstart: LocalizedStringKey = "Start"
    let cancel: LocalizedStringKey = "Cancel"
    
    var body: some View {
            ZStack {
                Color.black
                    .opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text(setTime)
                        .font(.title)

                    HStack {
                        Spacer()
                        Picker(selection: $hours, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/, content: {
                            ForEach(0...23, id: \.self) { i in
                                Text("\(i) h")
                            }
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                        .clipped()
                        
                        Picker(selection: $minutes, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/, content: {
                            ForEach(0...59, id: \.self) { i in
                                Text("\(i) m")
                            }
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                        .clipped()
                        
                        Picker(selection: $seconds, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/, content: {
                            ForEach(0...59, id: \.self) { i in
                                Text("\(i) s")
                            }
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .clipped()
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        NavigationLink(
                            destination: TimerView(p: p, hours: hours, minutes: minutes, seconds: seconds, tH: hours, tM: minutes, tS: seconds)) {
                            Text(sstart)
                                .font(.title)
                        }
                        .navigationBarHidden(true)
                            
                        Spacer()
                        NavigationLink(destination: TimerView(p: p, hours: hourSet, minutes: minuteSet, seconds: secondSet, tH: hourSet, tM: minuteSet, tS: secondSet)) {
                            Text(cancel)
                                .font(.title)
                        }
                        Spacer()
                    }
                }
                .background(Color.orange)
            }
        }
    }

struct SetTimeView_Previews: PreviewProvider {
    static var previews: some View {
        SetTimeView()
    }
}
