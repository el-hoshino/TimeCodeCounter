//
//  ContentView.swift
//  TimeCodeCounter
//
//  Created by 史 翔新 on 2022/11/16.
//

import SwiftUI
import TimeCodeCounterPackage

struct ContentView: View {
    
    @StateObject private var counter = Counter()
    
    var body: some View {
        
        VStack {
            
            Text("Elapsed Time: \(counter.elapsedTimeString)")
            Text("Frames: \(counter.frameCount(under: .f59_94_ndf))")
            Text("Time Code: \(counter.timeCode(under: .f59_94_ndf))")
            
            Spacer()
                .frame(maxHeight: 100)
            
            Button {
                counter.isRunning ? counter.stop() : counter.start()
            } label: {
                counter.isRunning ? Text("Stop") : Text("Start")
            }
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
