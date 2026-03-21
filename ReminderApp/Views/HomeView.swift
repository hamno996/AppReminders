//
//  ContentView.swift
//  ReminderApp
//
//  Created by Hamno Muhsin on 2/25/26.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isPressed: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Hello, World!")
                Spacer()
                
                Button {
                    isPressed = true
                } label: {
                    Text("Add List")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.default)
                }.padding()
            }.sheet(isPresented: $isPressed){
                NavigationView{
                    AddNewListView{ name, color in
                        
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
