//
//  OAuthError.swift
//  mejai
//
//  Created by 지연 on 11/26/24.
//

import AuthenticationServices
import Foundation

import KakaoSDKCommon

enum OAuthError: Error {
    // OAuth Provider 관련 에러
    case unsupportedProvider
    // 소셜 로그인 관련 에러
    case kakaoError(SdkError)
    case appleError(ASAuthorizationError)
    // 회원 상태 관련 에러
    case userNotFound          // 회원이 아닌 경우
    case userAlreadyExists     // 이미 가입된 회원인 경우
    // 토큰 관련 에러
    case tokenSaveFailed       // 키체인 저장 실패
    case invalidToken          // 토큰이 유효하지 않음
    case tokenExpired          // 토큰 만료
    // 네트워크 관련 에러
    case networkError(NetworkError)
    case invalidResponse
    case invalidRequest
    case unauthorized
    case clientError
    case serverError
    // 기타 에러
    case unknown(Error)
    
    var errorDescription: String {
        switch self {
        case .unsupportedProvider:
            return "지원하지 않는 로그인 방식입니다."
        case .kakaoError(let error):
            return "카카오 로그인 오류: \(error.localizedDescription)"
        case .appleError(let error):
            return "애플 로그인 오류: \(error.localizedDescription)"
        case .userNotFound:
            return "등록되지 않은 회원입니다."
        case .userAlreadyExists:
            return "이미 가입된 회원입니다."
        case .tokenSaveFailed:
            return "로그인 정보 저장에 실패했습니다."
        case .invalidToken:
            return "유효하지 않은 인증 정보입니다."
        case .tokenExpired:
            return "인증이 만료되었습니다. 다시 로그인해주세요."
        case .networkError(let error):
            return "네트워크 오류: \(error.localizedDescription)"
        case .invalidResponse:
            return "서버 응답이 올바르지 않습니다."
        case .invalidRequest:
            return "서버 요청이 올바르지 않습니다."
        case .unauthorized:
            return "인증에 실패했습니다."
        case .clientError:
            return "클라이언트 오류가 발생했습니다."
        case .serverError:
            return "서버 오류가 발생했습니다."
        case .unknown(let error):
            return "알 수 없는 오류가 발생했습니다: \(error.localizedDescription)"
        }
    }
}
