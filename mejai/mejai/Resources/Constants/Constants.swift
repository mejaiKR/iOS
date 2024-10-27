//
//  Constants.swift
//  mejai
//
//  Created by 지연 on 10/25/24.
//

import Foundation

enum Constants {
    enum Layout {
        enum IconImage {
            static let normal: CGFloat = 24
            static let small: CGFloat = 20
        }
        
        enum Component {
            static let navigationBar: CGFloat = 44
            static let button: CGFloat = 52
            static let searchBar: CGFloat = 44
            static let summonerProfileCell: CGFloat = 75
            static let relationshipCell: CGFloat = 52
        }
    }
    
    enum Spacing {
        static let xs: CGFloat = 8
        static let sm: CGFloat = 16
        static let md: CGFloat = 28
        static let lg: CGFloat = 42
        
        enum Content {
            static let padding: CGFloat = 20
            static let cellSpacing: CGFloat = 10
            static let summonerStackViewSpacing: CGFloat = 5
        }
    }
    
    enum Radius {
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 20
    }
    
    enum Typography {
        enum Size {
            static let logo: Double = 24
            static let heading1: Double = 24
            static let heading2: Double = 20
            static let heading3: Double = 18
            static let title1: Double = 20
            static let title2: Double = 16
            static let title3: Double = 14
            static let body1: Double = 16
            static let body2: Double = 14
            static let body3: Double = 14
            static let caption1: Double = 12
            static let caption2: Double = 10
        }
        
        enum LineHeight {
            static let logo: CGFloat = 32
            static let heading1: CGFloat = 32
            static let heading2: CGFloat = 28
            static let heading3: CGFloat = 24
            static let title1: CGFloat = 28
            static let title2: CGFloat = 24
            static let title3: CGFloat = 20
            static let body1: CGFloat = 24
            static let body2: CGFloat = 20
            static let body3: CGFloat = 20
            static let caption1: CGFloat = 16
            static let caption2: CGFloat = 14
        }
    }
}
