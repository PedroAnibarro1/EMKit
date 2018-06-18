

import Foundation

extension Date {
    
    // I usually have specific date format conversion in here, but they are very project specific
    
    
    
    // Simple properties telling you when a date is.
    var isInFuture: Bool {
        return self > Date()
    }
    
    var isInPast: Bool {
        return self < Date()
    }
    
    var isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    var isInYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    var isInTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    var isInWeekend: Bool {
        return Calendar.current.isDateInWeekend(self)
    }
    
    var isInWeekday: Bool {
        return !Calendar.current.isDateInWeekend(self)
    }
    
        
     
        
    // Property that shows time ago as a string. This was used for a social media app. Think twitter when you see "52m ago".
    
    var timeAgo: String {
        
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute {
            return "\(secondsAgo) sec ago"
        } else if secondsAgo < hour {
            return timeSinceString(secondsAgo: secondsAgo, timeFrame: minute, timeLabel: "min")
        } else if secondsAgo < day {
            return timeSinceString(secondsAgo: secondsAgo, timeFrame: hour, timeLabel: "hr")
        } else if secondsAgo < week {
            return timeSinceString(secondsAgo: secondsAgo, timeFrame: day, timeLabel: "day")
        } else {
            return timeSinceString(secondsAgo: secondsAgo, timeFrame: week, timeLabel: "week")
        }
    }
    
    
    // Determins whether it should be "day" or "days"
    func timeSinceString(secondsAgo: Int, timeFrame: Int, timeLabel: String) -> String {
        
        return (secondsAgo/timeFrame > 1) ? "\(secondsAgo/timeFrame) \(timeLabel)s ago" : "\(secondsAgo/timeFrame) \(timeLabel) ago"
    }
    
    var asString: String {
        
        // Make formatter for the date
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
        
    }
    
    func asStringUsing(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        
        // Make formatter for the date
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        
        return formatter.string(from: self)
        
    }
    
    func asStringUsing(dateFormat: String) -> String {
        
        // Make formatter for the date
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        
        return formatter.string(from: self)
        
    }
    
    func asStringUsing(dateStyle: DateFormatter.Style, dateFormat: String) -> String {
        
        // Make formatter for the date
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.dateFormat = dateFormat
        
        return formatter.string(from: self)
        
    }
    
    var startOfDay: Date {
        
        let calendar = Calendar.autoupdatingCurrent
        return calendar.startOfDay(for: self)
        
    }
    
    var endOfDay: Date {
        
        var components = DateComponents()
        components.day = 1
        components.second = -1
        let calendar = Calendar.autoupdatingCurrent
        return calendar.date(byAdding: components, to: self.startOfDay) ?? self
        
    }
    
}
