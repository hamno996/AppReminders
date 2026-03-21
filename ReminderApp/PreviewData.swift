//
//  PreviewData.swift
//  ReminderApp
//
//  Created by Hamno Muhsin on 3/2/26.
//

import Foundation
import CoreData

class PreviewData {
    static var myLists: MyList {
        let viewContext = CoreDataProvider.shared.persistentContainer.viewContext
        let request = MyList.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? MyList()
    }
    
}
