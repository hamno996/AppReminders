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
    
    private var isFormValid: Bool {
        !editconfig.title.isEmpty
    }
    
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
                        if let _ = reminder.list {
                            Section {
                                NavigationLink {
                                    SelectListView(selectList: Binding(
                                        get: { reminder.list! },
                                        set: { reminder.list = $0 }
                                    ))
                                } label: {
                                    HStack{
                                        Text("List")
                                        Spacer()
                                        Text(reminder.list!.name!)
                                    }
                                }
                            }
                        }
                    }
                  
                }.onChange(of: editconfig.hasDate) {
                    if editconfig.hasDate {
                        editconfig.reminderDate = Date()
                    }
                }
                .onChange(of: editconfig.hasTime) {
                    if editconfig.hasTime {
                        editconfig.reminderTime = Date()
                    }
                }
                .listStyle(.insetGrouped)
            }
        }.onAppear {
            editconfig = ReminderEditConfig(reminder: reminder)
        }.toolbar {
            ToolbarItem(placement: .principal) {
                Text("Details")
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                        do {
                            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editconfig)
                        } catch {
                            print(error)
                        }
                        reminder.title = editconfig.title
                        reminder.notes = editconfig.notes
                        reminder.reminderDate = editconfig.hasDate ? editconfig.reminderDate : nil
                        reminder.reminderTime = editconfig.hasTime ? editconfig.reminderTime : nil
                        reminder.isCompleted = editconfig.isCompleted
                    dismiss()
                }.disabled(!isFormValid)
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
