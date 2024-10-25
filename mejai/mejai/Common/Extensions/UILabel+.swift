//
//  UILabel+.swift
//  mejai
//
//  Created by 지연 on 10/25/24.
//

import UIKit

extension UILabel {
    private func setLineHeight(_ lineHeight: CGFloat) {
        guard let text = self.text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        
        let baselineOffset = (lineHeight - font.lineHeight) / 4
        
        attributedString.addAttributes(
            [.paragraphStyle: paragraphStyle, .baselineOffset: baselineOffset],
            range: NSRange(location: 0, length: attributedString.length)
        )
        
        self.attributedText = attributedString
    }
    
    func applyTypography(with font: UIFont) {
        self.font = font
        
        switch font {
        case .logo:
            setLineHeight(Constants.Font.LineHeight.logo)
        case .heading1:
            setLineHeight(Constants.Font.LineHeight.heading1)
        case .heading2:
            setLineHeight(Constants.Font.LineHeight.heading2)
        case .heading3:
            setLineHeight(Constants.Font.LineHeight.heading3)
        case .title1:
            setLineHeight(Constants.Font.LineHeight.title1)
        case .title2:
            setLineHeight(Constants.Font.LineHeight.title2)
        case .title3:
            setLineHeight(Constants.Font.LineHeight.title3)
        case .body1:
            setLineHeight(Constants.Font.LineHeight.body1)
        case .body2:
            setLineHeight(Constants.Font.LineHeight.body2)
        case .body3:
            setLineHeight(Constants.Font.LineHeight.body3)
        case .caption1:
            setLineHeight(Constants.Font.LineHeight.caption1)
        case .caption2:
            setLineHeight(Constants.Font.LineHeight.caption2)
        default:
            break
        }
    }
}
