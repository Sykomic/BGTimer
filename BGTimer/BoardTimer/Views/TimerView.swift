//
//  TimerView.swift
//  BoardTimer
//
//  Created by Sykomic on 2021/01/20.
//

import SwiftUI
import AVFoundation
import CoreData

struct TimerView: View {
    @Environment (\.managedObjectContext) private var viewContext
    @State var p: Players = Players()
    @State var from: Int = 0
    
    @State var date: Date = Date()
    @State var winner: String = ""
    @State var places: [Int16] = []
    @State var names: [String] = []

    @State var over: Bool = false
    @State var position: Int = 0
    @State var ind: Int = 0
    @State var numPlaying: Int = 0
    @State var timer: Timer? = nil
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var tH = 0
    @State var tM = 0
    @State var tS = 0
    @State var progress: CGFloat = 0
    @State var barIncrement: CGFloat = 0
    @State var isActive: Bool = false
    @State var isPause: Bool = false
    @State var alert: Bool = false
    @State var sound: AVAudioPlayer?
    @State var itsZero: Bool = true
    @State var currPlayer: Player = Player()
    let nn: LocalizedStringKey = "Next"
    let ffinish: LocalizedStringKey = "Finish"
    let startt: LocalizedStringKey = "Start"
    let ppause: LocalizedStringKey = "Pause"
    
    var body: some View {
        VStack {
            Text("")
                .alert(isPresented: $alert) {
                    Alert(title: Text("Time is Over"), dismissButton: .default(Text("Okay"), action: {
                        self.sound?.stop()
                    }))
                }
                .onAppear() {
                    self.reset()
                    self.settingPlayers()
                }
            
            NavigationLink(destination: SetTimeView(p: p, hourSet: hours, minuteSet: minutes, secondSet: seconds))
            {
                Text(String(format: "%02d:%02d:%02d", tH, tM, tS))
                    .font(.title)
            }
            .disabled(isActive || isPause)
            .navigationBarHidden(true)
            
            Spacer()
            Text(currPlayer.name)
                .font(.title)
                .lineLimit(1)
            
            ZStack {
                Circle()
                    .stroke(currPlayer.color, lineWidth: 30)
                    .opacity(0.3)
                    .padding()
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(currPlayer.color, lineWidth: 30)
                    .padding()
                    .rotationEffect(.degrees(-90))
                Button(action: {
                    self.next()
                }) {
                    Text(nn)
                        .font(.system(size: 60))
                        .frame(width: 300, height: 300)
                        .clipShape(Circle())
                }
                .disabled(!isActive)
            }
            
            HStack {
                Spacer()
                NavigationLink(
                    destination: ResultView(date: self.date, p: p, hours: hours, minutes: minutes, seconds: seconds).navigationBarBackButtonHidden(true),
                    isActive: $over) {
                    Text("")
                }
                .navigationBarHidden(true)
                
                Button(ffinish) {
                    self.finish()
                    if self.numPlaying == 1 {
                        over = true
                    }
                }
                .font(.title)
                .disabled(!isActive)
                
                Spacer()
                
                ZStack {
                    Button(startt) {
                        startTimer()
                    }
                    .onAppear() {
                        if self.seconds == 0 && self.minutes == 0 && self.hours == 0 {
                            itsZero = true
                        } else {
                            itsZero = false
                        }
                    }
                    .font(.title)
                    .disabled(itsZero)
                    .opacity(isActive ? 0 : 1)
                    
                    Button(ppause) {
                        self.pause()
                    }
                    .font(.title)
                    .disabled(!isActive)
                    .opacity(isActive ? 1: 0)
                }
                Spacer()
            }
            Spacer()
        }
    }
    
    func alertSound() {
        let path = Bundle.main.path(forResource: "alert.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            self.sound = try AVAudioPlayer(contentsOf: url)
            self.sound?.play()
        } catch {
            print("Couldn't load the file.")
        }
    }
    
    func finish() {
        if self.position == 0 {
            self.winner = self.currPlayer.name
            self.p.players[self.ind].first = true
        } else {
            self.p.players[self.ind].first = false
        }
        self.numPlaying -= 1
        self.position += 1
        self.p.players[self.ind].place = self.position
        self.p.players[self.ind].finish = true
        self.names.append(currPlayer.name)
        self.places.append(Int16(self.p.players[self.ind].place))
        
        if self.numPlaying == 1 {
            self.next()
            self.p.players[self.ind].first = false
            self.p.players[self.ind].place = self.names.count + 1
            self.currPlayer.place = self.names.count + 1
            self.names.append(currPlayer.name)
            self.places.append(Int16(currPlayer.place))
            self.saveRecord()
            self.stopTimer()
        } else {
            self.next()
        }
    }
    
    func next() {
        self.progress = 0
        self.tH = self.hours
        self.tM = self.minutes
        self.tS = self.seconds
        if self.ind + 1 != self.p.players.count {
            self.ind += 1
            if self.p.players[self.ind].finish == false {
                self.currPlayer = self.p.players[self.ind]
            }
            else {
                self.next()
            }
        }
        else {
            self.ind = 0
            if self.p.players[self.ind].finish == false {
                self.currPlayer = self.p.players[self.ind]
            }
            else {
                self.next()
            }
        }
    }
    
    func pause() {
        self.timer?.invalidate()
        self.isActive = false
        self.isPause = true
    }
    
    func reset() {
        for i in 0..<self.p.players.count {
            self.p.players[i].finish = false
            self.p.players[i].place = 0
        }
    }
    
    func running() {
        self.progress += self.barIncrement
        if self.tS == 0 {
            self.tS = 59
            if self.tM == 0 {
                self.tM = 59
                self.tH -= 1
            } else {
                self.tM -= 1
            }
        } else {
            self.tS -= 1
        }
    }
    
    func saveRecord() {
        let newGame = Result(context: viewContext)
        newGame.name = self.names
        newGame.place = self.places
        newGame.date = self.date
        newGame.winner = self.winner
        newGame.id = UUID()
        do {
            try viewContext.save()
            print("Result saved.")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func settingPlayers() {
        let playing = self.p.players.filter {
            $0.name != ""
        }
        self.p = Players(players: playing)
        self.p.players.sort {
            $0.order < $1.order
        }
        if self.from == 1 {
            self.p.players[0].first = true
        }
        self.numPlaying = playing.count
        for i in 0 ..< self.numPlaying {
            if self.p.players[i].first == true {
                self.currPlayer = self.p.players[i]
                self.ind = i
            }
        }
    }
    
    func startTimer() {
        self.isActive = true
        self.isPause = false
        self.barIncrement = 1 / CGFloat(self.hours * 3600 + self.minutes * 60 + self.seconds)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            if self.tH == 0 && self.tM == 0 && self.tS == 0 {
                self.alertSound()
                sleep(1)
                self.sound?.stop()
                self.next()
            } else {
                self.running()
            }
            
        }
    }
    
    func stopTimer() {
        self.next()
        self.timer?.invalidate()
        self.timer = nil
        self.isActive = false
    }
}


struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
