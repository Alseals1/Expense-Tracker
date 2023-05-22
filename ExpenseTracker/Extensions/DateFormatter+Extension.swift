import Foundation

extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        print("Inializing DateFormatter")
        let fomatter = DateFormatter()
        fomatter.dateFormat = "MM/dd/yyyy"
        
        return fomatter
    }()
}

