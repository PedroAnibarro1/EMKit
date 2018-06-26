
import Foundation
import UIKit

// These next 2 structs work together, and it's how I adjust for screen size when necessary
// Most of the time auto-layout handles things, but sometimes to need a fine adjustment for one screen size
// How it's used:  If DeviceTypes.iPhone5 { // do iPhone5 specific stuff }

struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceTypes {
    static let iPhone4              = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let iPhone5              = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let iPhone7Standard      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0 && UIScreen.main.nativeScale == UIScreen.main.scale
    static let iPhone7Zoomed        = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0 && UIScreen.main.nativeScale > UIScreen.main.scale
    static let iPhone7PlusStandard  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let iPhone7PlusZoomed    = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0 && UIScreen.main.nativeScale < UIScreen.main.scale
    static let iPad                 = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    
    // TODO: Add iPad Pro 12inch, and iPad Mini
}


