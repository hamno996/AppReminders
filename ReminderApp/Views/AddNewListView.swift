//
//  AddNewListView.swift
//  ReminderApp
//
//  Created by Hamno Muhsin on 2/28/26.
//

import SwiftUI

struct AddNewListView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var selectedColor: Color = .yellow
    
    let onSave: (String, UIColor) -> Void
    
    private var isFormValid: Bool {
        !name.isEmpty
    }
    
    var body: some View {
        VStack{
            VStack{
                Image(systemName: "line.3.horizontal.circle.fill")
                    .foregroundColor(selectedColor)
                    .font(.system(size: 100))
                TextField("New List", text: $name)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(colorScheme == .dark ? Color(.systemGray3) : Color(.systemGray6))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(name.isEmpty ? Color.clear : Color.blue, lineWidth: 1.5)
                    )
                    .padding(.horizontal)
            }
            .padding(30)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            
            ColorPickerView(selectedColor: $selectedColor)
            
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("New List")
                        .font(.headline)
                }
                
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Close"){
                        dismiss()
                    }
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Done"){
                        onSave(name, UIColor(selectedColor))
                        dismiss()
                    }.disabled(!isFormValid)
                }
            }
    }
}

#Preview {
    NavigationView{
        AddNewListView(onSave: {_,_ in})
    }
}
