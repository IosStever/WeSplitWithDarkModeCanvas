//
//  ContentView.swift
//  WeSplit
//
//  Created by Steven Robertson on 10/8/19.
//  Copyright © 2019 Steven Robertson. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""//1
    @State private var tipPercentage = 2
    
    let tipPercentages = [0, 10, 20, 25, 30]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 1.0//2
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    //3
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("What tip percentage do you want to use?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                }.pickerStyle(SegmentedPickerStyle())

                Section(header: Text("Grand total")) {
                    if tipPercentage == 0
                    {
                        Text("$\(totalPerPerson * (Double(numberOfPeople) ?? 1.0), specifier: "%.2f")").foregroundColor(Color.red)
                    } else {
                        Text("$\(totalPerPerson * (Double(numberOfPeople) ?? 1.0), specifier: "%.2f")")

                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                }
            }.navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\EnvironmentValues.colorScheme, ColorScheme.dark)
    }
}





