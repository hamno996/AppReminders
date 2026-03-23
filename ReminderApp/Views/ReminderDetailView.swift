//
//  ReminderDetailView.swift
//  ReminderApp
//
//  Created by Hamno Muhsin on 3/10/26.
//

import SwiftUI

struct ReminderDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var reminder: Reminder
    @State var editconfig: ReminderEditConfig = ReminderEditConfig()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $editconfig.title)
                        TextField("Notes", text: $editconfig.notes ?? "")
                    }
                    Section {
                        Toggle(isOn: $editconfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundColor(.blue)
                        }
                        
                        if editconfig.hasDate {
                            DatePicker("Select Date", selection: $editconfig.reminderDate ?? Date(),
                                       displayedComponents: .date
                            )
                        }
                        
                        Toggle(isOn: $editconfig.hasTime) {
                            Image(systemName: "clock").foregroundColor(.blue)
                        }
                        
                        if editconfig.hasTime {
                            DatePicker("Select Time", selection: $editconfig.reminderTime ?? Date(),
                                       displayedComponents: .hourAndMinute
                            )
                        }
                    }
                }.listStyle(.insetGrouped)
            }.onAppear {
                editconfig = ReminderEditConfig(reminder: reminder)
            }
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Done"){
                        
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
