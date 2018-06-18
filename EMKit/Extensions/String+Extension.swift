

import Foundation

extension String {
    
    // Verifies if an string is a valid email format. Nice for login screens.
    
    func checkIfValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        
        return emailPredicate.evaluate(with: self)
    }
    
    // It's common to get back server data with underscores in it. This removes them.
    // Example: "new_movies" will change to "New Movies"
    
    func titleize() -> String {
        return self.replacingOccurrences(of: "_", with: " ").capitalized
    }
    
    static let empty = ""
    
    var asDate: Date? {
        
        // Make formatter for the date
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.date(from: self)
        
    }
    
    func asDateUsing(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> Date? {
        
        // Make formatter for the date
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        
        return formatter.date(from: self)
        
    }
    
    func asDateUsing(dateFormat: String, defaultDate: Date? = nil) -> Date? {
        
        // Make formatter for the date
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.dateFormat = dateFormat
        formatter.defaultDate = defaultDate
        
        return formatter.date(from: self)
        
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    typealias SimpleToFromRepalceList = [(fromSubString: String, toSubString: String)]
    
    var glyphCount: Int {
        
        let richText = NSAttributedString(string: self)
        let line = CTLineCreateWithAttributedString(richText)
        return CTLineGetGlyphCount(line)
    }
    
    var isSingleEmoji: Bool {
        
        return glyphCount == 1 && containsEmoji
    }
    
    var containsEmoji: Bool {
        
        return unicodeScalars.contains { $0.isEmoji }
    }
    
    var containsOnlyEmoji: Bool {
        
        return !isEmpty
            && !unicodeScalars.contains(where: {
                !$0.isEmoji
                    && !$0.isZeroWidthJoiner
            })
    }
    
    // The next tricks are mostly to demonstrate how tricky it can be to determine emoji's
    // If anyone has suggestions how to improve this, please let me know
    var emojiString: String {
        
        return emojiScalars.map { String($0) }.reduce("", +)
    }
    
    var emojis: [String] {
        
        var scalars: [[UnicodeScalar]] = []
        var currentScalarSet: [UnicodeScalar] = []
        var previousScalar: UnicodeScalar?
        
        for scalar in emojiScalars {
            
            if let prev = previousScalar, !prev.isZeroWidthJoiner && !scalar.isZeroWidthJoiner {
                
                scalars.append(currentScalarSet)
                currentScalarSet = []
            }
            currentScalarSet.append(scalar)
            
            previousScalar = scalar
        }
        
        scalars.append(currentScalarSet)
        
        return scalars.map { $0.map { String($0) } .reduce("", +) }
    }
    
    fileprivate var emojiScalars: [UnicodeScalar] {
        
        var chars: [UnicodeScalar] = []
        var previous: UnicodeScalar?
        for cur in unicodeScalars {
            
            if let previous = previous, previous.isZeroWidthJoiner && cur.isEmoji {
                chars.append(previous)
                chars.append(cur)
                
            } else if cur.isEmoji {
                chars.append(cur)
            }
            
            previous = cur
        }
        
        return chars
    }
    
    func simpleReplace(mapList: SimpleToFromRepalceList ) -> String {
        
        var string = self
        
        for (fromStr, toStr) in mapList {
            let separatedList = string.components(separatedBy: fromStr)
            if separatedList.count > 1 {
                string = separatedList.joined(separator: toStr)
            }
        }
        
        return string
    }
    
    func xmlSimpleUnescape() -> String {
        
        let mapList: SimpleToFromRepalceList = [
            ("&amp;", "&"),
            ("&quot;", "\""),
            ("&#x27;", "'"),
            ("&#39;", "'"),
            ("&#x92;", "'"),
            ("&#x96;", "-"),
            ("&gt;", ">"),
            ("&lt;", "<")]
        
        return self.simpleReplace(mapList: mapList)
        
    }
    
    func xmlSimpleEscape() -> String {
        
        let mapList: SimpleToFromRepalceList = [
            ("&", "&amp;"),
            ("\"", "&quot;"),
            ("'", "&#x27;"),
            (">", "&gt;"),
            ("<", "&lt;")]
        
        return self.simpleReplace(mapList: mapList)
        
    }
    
    func withLineHeight(_ height: CGFloat) -> NSMutableAttributedString {
        
        let attributedString = NSMutableAttributedString(string: self)
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = height
        
        // *** Apply attribute to string ***
        attributedString.addAttribute(kCTParagraphStyleAttributeName as NSAttributedStringKey, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        
        return attributedString
        
    }
    
}
