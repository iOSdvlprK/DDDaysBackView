//
//  DaysBackView.swift
//  DDDaysBackView
//
//  Created by joe on 4/29/25.
//

import SwiftUI

struct TimePicker: View {
    @Binding var time: Date
    let scale: CGFloat
    
    var body: some View {
        DatePicker("", selection: $time)
            .scaleEffect(scale)
            .labelsHidden()
    }
}

extension Date {
    func addDays(numDays: Int) -> Date {
        self.addingTimeInterval(TimeInterval(numDays * 60 * 60 * 24))
    }
    
    func subtractDays(numDays: Int) -> Date {
        addDays(numDays: -1 * numDays)
    }
    
    func isWithinLastSevenDays() -> Bool {
        let oneWeekAgo = Date().subtractDays(numDays: 7)
        return self > oneWeekAgo && self <= Date()
    }
}

struct DateView: View {
    let date: Date
    
    var body: some View {
        Text("\(date.formatted(.dateTime.month().day().year()))")
            .font(.title)
            .fontWeight(.semibold)
    }
}

struct DaysBackView: View {
    @State private var theDate = Date()
    var dateInfo: String {
        theDate.isWithinLastSevenDays() ? "Date is within last seven days" : "Date is NOT within last seven days"
    }
    
    var bgColor: LinearGradient {
        let mainColor: Color = theDate.isWithinLastSevenDays() ? .green : .red
        return LinearGradient(colors: [mainColor, .white, mainColor], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    var body: some View {
        ZStack {
            bgColor
                .opacity(0.6)
                .ignoresSafeArea()
            
            VStack {
                Text(dateInfo)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                VStack {
                    Text("Current Date")
                        .font(.title)
                    
                    DateView(date: theDate)
                }
                
                Spacer()
                Spacer()
                Spacer()
                
                Text("Select a date")
                    .font(.title)
                    .fontWeight(.semibold)
                TimePicker(time: $theDate, scale: 1.2)
            }
            .padding()
        }
    }
}

#Preview {
    DaysBackView()
}
