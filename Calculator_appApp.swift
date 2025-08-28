//
//  Calculator_appApp.swift
//  Calculator app
//
//  Created by Anwitha R
//

import SwiftUI

struct ContentView: View {
    @State private var display = "0"
    @State private var firstNumber: Double? = nil
    @State private var currentOperation: String? = nil
    @State private var isTyping = false
    
    let buttons: [[String]] = [
        ["7", "8", "9", "÷"],
        ["4", "5", "6", "×"],
        ["1", "2", "3", "−"],
        ["0", "C", "=", "+"]
    ]
    
    var body: some View {
        VStack {
            Spacer()
            
            // Display
            Text(display)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            
            // Buttons Grid
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            buttonTapped(button)
                        }) {
                            Text(button)
                                .font(.title)
                                .frame(width: 70, height: 70)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(35)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    // Button logic
    func buttonTapped(_ button: String) {
        switch button {
        case "0"..."9":
            if isTyping {
                display += button
            } else {
                display = button
                isTyping = true
            }
        case "+", "−", "×", "÷":
            firstNumber = Double(display)
            currentOperation = button
            isTyping = false
        case "=":
            if let first = firstNumber, let op = currentOperation, let second = Double(display) {
                var result: Double = 0
                switch op {
                case "+": result = first + second
                case "−": result = first - second
                case "×": result = first * second
                case "÷": result = second != 0 ? first / second : 0
                default: break
                }
                display = String(result)
                isTyping = false
            }
        case "C":
            display = "0"
            firstNumber = nil
            currentOperation = nil
            isTyping = false
        default:
            break
        }
    }
}

#Preview {
    ContentView()
}
