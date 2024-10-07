//
//  ContentView.swift
//  Project-4-SwiftUI-better-rest
//
//  Created by Kevin Cuadros on 6/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("When do you want to wake up?")
                    .font(.headline)
                
                DatePicker(
                    "Please enter a time",
                    selection: $wakeUp,
                    displayedComponents: .hourAndMinute
                )
                .labelsHidden()
                
                Text("Desired amount of sleep")
                    .font(.headline)
                
                Stepper(
                    "\(sleepAmount.formatted()) hours",
                    value: $sleepAmount,
                    in: 4...12,
                    step: 0.5
                )
                
                Text("Daily coffee intake")
                    .font(.headline)
                
                Stepper(
                    "\(coffeeAmount) cup(s)",
                    value: $coffeeAmount,
                    in: 1...12,
                    step: 1
                )
            }
            
            .navigationTitle("BetterRest")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Button("Calculate", action: calculateBedTime)
            }
        }
    }
    
    func calculateBedTime(){
        
    }
    
}

#Preview {
    ContentView()
}


//struct ContentView: View {
//    
//    @State private var wakeUp = Date.now
//    @State private var sleepAmount = 8.0
//    @State private var coffeeAmount = 8.0
//    
//    var body: some View {
//        Stepper(
//            "\(sleepAmount.formatted()) hours",
//            value: $sleepAmount,
//            in: 4...12,
//            step: 0.5
//        )
//        
//        Text(Date.now, format: .dateTime.hour().day().month().year())
//        
//        Text(Date.now.formatted(date: .long, time: .shortened))
//        
//        DatePicker(
//            "Please enter a date",
//            selection: $wakeUp,
//            in: dateFromNow()
//        )
//            .labelsHidden()
//    }
//    
//    // This is not good idea why have change in the calendar
//    // depending of the season, zone an more.
//    // Best idea uses `DateComponents`
//    func rangeDate() -> ClosedRange<Date> {
//        // create a second Date instance set to one day in seconds from now
//        let tomorrow = Date.now.addingTimeInterval(86400)
//        // create a range from those two
//        let range = Date.now...tomorrow
//        return range
//    }
//    
//    func dateComponent() {
////        var dateComponents = DateComponents()
////        dateComponents.hour = 8
////        dateComponents.minute = 0
////
////        let date = Calendar.current.date(from: dateComponents) ?? .now
//        
//        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//        let hour = components.hour ?? 0
//        let minute = components.minute ?? 0
//        print(hour, minute)
//    }
//    
//    
//    func dateFromNow() -> PartialRangeFrom<Date> {
//        return Date.now...
//    }
//}
//
