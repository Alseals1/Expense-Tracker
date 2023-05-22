import Foundation

extension Double {
    func roundTo2Digits() -> Double { return (self * 100).rounded() / 100 }
}
