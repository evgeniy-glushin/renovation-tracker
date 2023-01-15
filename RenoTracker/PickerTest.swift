//
//  PickerTest.swift
//  RenoTracker
//
//  Created by User on 15.01.2023.
//

import SwiftUI

struct PickerTest: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            DatePicker(selection: .constant(Date()), label: { Text("Pick date") })
            DatePicker(
                selection: .constant(Date()),
                displayedComponents: .date) {
                Text("Due data")
            }
            
            Picker(selection: .constant(1), label: Text("Picker")) {
                Text("1").tag(1)
                Text("2").tag(2)
            }.pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct PickerTest_Previews: PreviewProvider {
    static var previews: some View {
        PickerTest()
    }
}
