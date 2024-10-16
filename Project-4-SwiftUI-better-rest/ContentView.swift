//
//  ContentView.swift
//  Project-4-SwiftUI-better-rest
//
//  Created by Kevin Cuadros on 6/10/24.
//
import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    static var defaultWakeTime: Date {
        var component = DateComponents()
        component.hour = 7
        component.minute = 0
        
        return Calendar.current.date(from: component) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        Text("When do you want to wake up?")
                            .font(.headline)
                        
                        HStack {
                            Spacer()
                            DatePicker(
                                "Please enter a time",
                                selection: $wakeUp,
                                displayedComponents: .hourAndMinute
                            )
                            .labelsHidden()
                            .onChange(of: wakeUp) {
                                calculateBedTime()
                            }
                            Spacer()
                        }
                    }
                    
                    Section {
                        Text("Desired amount of sleep")
                            .font(.headline)
                        
                        Stepper(
                            "\(sleepAmount.formatted()) hours",
                            value: $sleepAmount,
                            in: 4...12,
                            step: 0.5
                        )
                        .onChange(of: sleepAmount) {
                            calculateBedTime()
                        }
                    }
                    
                    Section {
                        Text("Daily coffee intake")
                            .font(.headline)
                        
                        Picker("^[\(coffeeAmount) cup](inflect: true)",
                               selection: $coffeeAmount) {
                            ForEach(1..<21, id: \.self) { text in
                                Text("\(text)")
                            }
                        }
                        .onChange(of: coffeeAmount){
                            calculateBedTime()
                        }
                        
                    }
                    
                    
                }
                
                Group {
                    HStack {
                        Spacer()
                        Text(alertTitle)
                            .font(.system(size: 20))
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text(alertMessage)
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
               
                
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("OK") { }
                } message: {
                    Text(alertMessage)
                }
            }
            
            .navigationTitle("BetterRest")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
//                Button("Calculate", action: calculateBedTime)
            }
            
            .onAppear(){
                calculateBedTime()
            }
        }
    }
    
    func calculateBedTime(){
        do {
            
            let config = MLModelConfiguration()
            let model = try BetterRest(configuration: config)
            
            let component  = Calendar.current.dateComponents(
                [.hour, .minute],
                from: wakeUp
            )
            
            let hour = (component.hour ?? 0) * 60 * 60
            let minute = (component.minute ?? 0) * 60
            
            // Prediction return a result as a Seconds
            let prediction = try model.prediction(
                wake: Double(hour + minute),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount)
            )
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
//            showingAlert = true
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            showingAlert = true
        }
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


//                        Stepper(
//                            "^[\(coffeeAmount) cup](inflect: true)",
//                            value: $coffeeAmount,
//                            in: 0...12,
//                            step: 1
//                        )
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
