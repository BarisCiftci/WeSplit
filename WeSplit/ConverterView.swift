//
//  ConverterView.swift
//  WeSplit
//
//  Created by Baris Ciftci on 25/12/2023.
//

import SwiftUI

struct ConverterView: View {
    
    @State var celsiusInput: Double = 0.0
    @State var specifierDigit: String =  "%.0f"
    
    var body: some View {
        let multiplyByNine = celsiusInput*9.0
        let devidingByFive = multiplyByNine/5.0
        
        let fahrenheitResult = devidingByFive+32.0
        let kelvinResult = celsiusInput+273.15
        
        
        
        Form {
            
            Section("Enter celsuis") {
                TextField("Enter celsius", value: $celsiusInput, format: .number)
                    .keyboardType(.decimalPad)
            }
                Section("resul in celsius") {
                    Text("\(celsiusInput, specifier: specifierDigit) °C")
                        .fontWeight(.black)
                        .foregroundStyle(Color.pink)
                        .font(.system(size: 72))
                }
                
                
                Section("resul in fahrenheit") {
                    Text("\(fahrenheitResult, specifier: specifierDigit) °F")
                        .fontWeight(.black)
                        .foregroundStyle(Color.orange)
                        .font(.system(size: 72))
                }
            
            Section("resul in kelvin") {
                Text("\(kelvinResult, specifier: specifierDigit) °K")
                    .fontWeight(.black)
                    .foregroundStyle(Color.blue)
                    .font(.system(size: 72))
            }
            
               
        }
        
        
        
        
        
        
    }
    
    
}

#Preview {
    ConverterView()
}
