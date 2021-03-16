//
//  RecordView.swift
//  BoardTimer
//
//  Created by 최대식 on 2021/02/26.
//

import SwiftUI
import CoreData

struct RecordView: View {
    @Environment (\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Result.entity(), sortDescriptors: [])
    var results: FetchedResults<Result>
    @State var p: [Player] = []
    var body: some View {
        VStack {
            List {
                ForEach(results) { result in
                    NavigationLink(destination: ResultView(date: result.date, p: Players(names: result.name, places: result.place), from: 0)) {
                        HStack {
                            Text(result.date, style: .date)
                            Text(result.date, style: .time)
                            Image("crown")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                            Text("\(result.winner)")
                        }
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        viewContext.delete(results[index])
                    }
                    do {
                        try viewContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            Text("\(p.count)")
                .opacity(0)
            // W/o this line, nothing is shown, but w/ this line, shows what I expected.... why???!!
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
