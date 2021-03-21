import Foundation
import SwiftUI

extension Font {
    
    public static var largeTitle: Font {
        return Font.custom("DIN Alternate Bold", size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
    }
    
    public static var Title: Font {
        return Font.custom("DIN Alternate Bold", size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
    }
    
    public static var headline: Font {
        return Font.custom("DIN Alternate Bold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize)
    }
    
    public static var subheadline: Font {
        return Font.custom("DIN Alternate Bold", size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize)
    }
    
    public static var body: Font {
        return Font.custom("DIN Alternate Bold", size: UIFont.preferredFont(forTextStyle: .body).pointSize)
    }
    
    public static var callout: Font {
        return Font.custom("DIN Alternate Bold", size: UIFont.preferredFont(forTextStyle: .callout).pointSize)
    }
    
    public static var footnote: Font {
        return Font.custom("DIN Alternate Bold", size: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
    }
    
    public static var caption: Font {
        return Font.custom("DIN Alternate Bold", size: UIFont.preferredFont(forTextStyle: .caption1).pointSize)
    }
    
    public static func system(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
        var font = "DIN Alternate Bold"
        switch weight {
        case .bold: font = "DIN Alternate Bold"
        case .heavy: font = "DIN Alternate Bold"
        case .light: font = "DIN Alternate Bold"
        case .medium: font = "DIN Alternate Bold"
        case .semibold: font = "DIN Alternate Bold"
        case .thin: font = "DIN Alternate Bold"
        case .ultraLight: font = "DIN Alternate Bold"
        default: break
        }
        return Font.custom(font, size: size)
    }
}
