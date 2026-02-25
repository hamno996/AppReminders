import Foundation
import CoreData
import UIKit

extension MyList {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyList> {
        return NSFetchRequest<MyList>(entityName: "MyList")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var color: UIColor
}
    
extension MyList: Identifiable {
        
}
    
extension MyList {

}
