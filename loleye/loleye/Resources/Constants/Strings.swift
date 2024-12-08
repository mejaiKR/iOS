//
//  Strings.swift
//  mejai
//
//  Created by 지연 on 10/26/24.
//

import Foundation

struct Strings {
    static let appName = "loleye"
    struct Login {
        static let description = "리그 오브 레전드 전적 모니터링 서비스"
        static let welcomeMessage = "에 오신걸 환영해요!"
        static let socialMessage = "소셜 계정으로 로그인 / 회원가입"
    }
    struct SummonerSearch {
        static let title = "모니터링할 소환사의\n라이엇 ID을 입력해주세요"
        static let descripton = "태그라인까지 모두 입력해야해요"
        static let searchPlaceholder = "소환사이름#태그라인"
        static let emptyMessage = "검색 결과가 없어요"
        static let invalidInputMessage = "소환사 이름과 태그라인을\n정확히 입력해주세요"
    }
    struct Relationship {
        static let title = "이 소환사와 어떤 관계인가요?"
    }
}
