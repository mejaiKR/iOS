//
//  UIFont+.swift
//  mejai
//
//  Created by 지연 on 10/25/24.
//

import UIKit

private enum PretendardWeight: String {
    case bold = "Bold"
    case medium = "Medium"
    case regular = "Regular"
    case semibold = "SemiBold"
}

extension UIFont {
    private static func pretendard(weight: PretendardWeight, size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-\(weight.rawValue)", size: size)!
    }
    
    static var logo: UIFont {
        return UIFont(name: "GmarketSansBold", size: 24)!
    }

    static var heading1: UIFont {
        return pretendard(weight: .bold, size: 24)
    }

    static var heading2: UIFont {
        return pretendard(weight: .bold, size: 20)
    }

    static var heading3: UIFont {
        return pretendard(weight: .bold, size: 18)
    }

    static var title1: UIFont {
        return pretendard(weight: .semibold, size: 20)
    }

    static var title2: UIFont {
        return pretendard(weight: .semibold, size: 16)
    }

    static var title3: UIFont {
        return pretendard(weight: .semibold, size: 14)
    }

    static var body1: UIFont {
        return pretendard(weight: .regular, size: 16)
    }

    static var body2: UIFont {
        return pretendard(weight: .medium, size: 14)
    }

    static var body3: UIFont {
        return pretendard(weight: .regular, size: 14)
    }

    static var caption1: UIFont {
        return pretendard(weight: .regular, size: 12)
    }

    static var caption2: UIFont {
        return pretendard(weight: .regular, size: 10)
    }
}
