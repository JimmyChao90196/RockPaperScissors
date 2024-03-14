//
//  PracticeView.swift
//  SwiftUI-RockPaperScissors
//
//  Created by JimmyChao on 2024/3/14.
//

import SwiftUI

struct PracticeView: View {
    
    @State var selection = 0
    @State var agreeToA = false
    @State var agreeToB = false
    @State var agreeToC = false
    @State var agreeToAll = false
    
    var body: some View {
        
        let binding = Binding {
            selection
        } set: {
            selection = $0
        }
        
        let multipleBinding = Binding<Bool> {
            if agreeToA && agreeToB && agreeToC {
                return true
            } else {
                return false
            }
        } set: {
            agreeToA = $0
            agreeToB = $0
            agreeToC = $0
        }

        ZStack {
            AngularGradient(colors: [.red, .yellow, .blue, .red], center: .center)
            
            VStack {

                Picker("Select one", selection: binding) {
                    ForEach(0..<3) { num in
                        Text("Item \(num)")
                    }
                }.pickerStyle(.segmented)
                
                Text("The selection now is \(selection)")
                
                Toggle("A", isOn: $agreeToA)
                Toggle("B", isOn: $agreeToB)
                Toggle("C", isOn: $agreeToC)
                Toggle("All", isOn: multipleBinding)
            }
            .padding(50)
            .frame(maxWidth: .infinity , maxHeight: 300)
            .background(.ultraThickMaterial)
            .clipShape(.rect(cornerRadius: 20))
            .padding()
        }.ignoresSafeArea()
    }
}

#Preview {
    PracticeView()
}
