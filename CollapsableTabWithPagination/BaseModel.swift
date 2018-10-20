import Foundation
class BaseModel: NSObject {
    var title: String = ""
    var icon: String = ""
    init(title: String, icon: String) {
        self.title = title
        self.icon = icon
    }
}
