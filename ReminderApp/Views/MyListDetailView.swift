//
//  MyListDetailView.swift
//  ReminderApp
//
//  Created by Hamno Muhsin on 3/4/26.
//

import SwiftUI
import CoreData

struct MyListDetailView: View {
    let myList:MyList
    @State private var openAddReminder:Bool = false
    @State private var title:String = ""
    
    @FetchRequest(sortDescriptors: [])
    private var reminderResults: FetchedResults<Reminder>
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    init(myList: MyList){
        self.myList = myList
        _reminderResults = FetchRequest(fetchRequest: ReminderService.getRemindersByList(myList: myList))
    }
    
    var body: some View {
        VStack{
            
            ReminderListView(reminders: reminderResults)
            
            HStack{
                Image(systemName: "plus.circle.fill")
                Button("New Reminder") {
                    openAddReminder = true
                }
            }.foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }.alert("New Reminder", isPresented: $openAddReminder){
            TextField("", text: $title)
            Button("Cancel", role:.cancel){ }
            Button("Done") {
                if isFormValid {
                    do {
                        try ReminderService.saveReminderToMyList(myList: myList, reminderTitle:title)
                    } catch{
                        print(error.localizedDescription)
                    }
                }
            }.disabled(!isFormValid)
        }
    }
}

#Preview {
    MyListDetailView(myList: PreviewData.myLists)
}
