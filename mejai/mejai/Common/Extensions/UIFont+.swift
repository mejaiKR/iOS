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
        return UIFont(name: "GmarketSansBold", size: Constants.Font.Size.logo)!
    }

    static var heading1: UIFont {
        return pretendard(weight: .bold, size: Constants.Font.Size.heading1)
    }

    static var heading2: UIFont {
        return pretendard(weight: .bold, size: Constants.Font.Size.heading2)
    }

    static var heading3: UIFont {
        return pretendard(weight: .bold, size: Constants.Font.Size.heading3)
    }

    static var title1: UIFont {
        return pretendard(weight: .semibold, size: Constants.Font.Size.title1)
    }

    static var title2: UIFont {
        return pretendard(weight: .semibold, size: Constants.Font.Size.title2)
    }

    static var title3: UIFont {
        return pretendard(weight: .semibold, size: Constants.Font.Size.title3)
    }

    static var body1: UIFont {
        return pretendard(weight: .regular, size: Constants.Font.Size.body1)
    }

    static var body2: UIFont {
        return pretendard(weight: .medium, size: Constants.Font.Size.body2)
    }

    static var body3: UIFont {
        return pretendard(weight: .regular, size: Constants.Font.Size.body3)
    }

    static var caption1: UIFont {
        return pretendard(weight: .regular, size: Constants.Font.Size.caption1)
    }

    static var caption2: UIFont {
        return pretendard(weight: .regular, size: Constants.Font.Size.caption2)
    }
}
