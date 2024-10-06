//
//  ContentView.swift
//  Project-4-SwiftUI-better-rest
//
//  Created by Kevin Cuadros on 6/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    
    var body: some View {
        Stepper(
            "\(sleepAmount.formatted()) hours",
            value: $sleepAmount,
            in: 4...12,
            step: 0.5
        )
        
        DatePicker(
            "Please enter a date",
            selection: $wakeUp,
            in: dateFromNow()
        )
            .labelsHidden()
    }
    
    func rangeDate() -> ClosedRange<Date> {
        let tomorrow = Date.now.addingTimeInterval(86400) // 1 day in seconds
        let range = Date.now...tomorrow
        return range
    }
    
    func dateFromNow() -> PartialRangeFrom<Date> {
        return Date.now...
    }
}

#Preview {
    ContentView()
}
