//
//  GetSummonerDetailUseCase.swift
//  mejai
//
//  Created by 지연 on 11/14/24.
//

import Combine
import Foundation

final class GetSummonerDetailUseCase {
    private let repository: SummonerRepositoryProtocol
    
    init(repository: SummonerRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<HomeViewData, Error> {
        repository.getSummonerDetail()
            .map { summonerDetail in
                HomeViewData(
                    profile: .init(
                        relationship: summonerDetail.summoner.relationship.rawValue,
                        name: summonerDetail.summoner.summonerName,
                        tagLine: summonerDetail.summoner.tag,
                        image: summonerDetail.summoner.profileIcon
                    ),
                    rankTiers: [
                        .init(
                            cellType: .flex,
                            rankTier: summonerDetail.summoner.flexRankTier,
                            image: summonerDetail.summoner.flexRankIconUrl
                        ),
                        .init(
                            cellType: .solo,
                            rankTier: summonerDetail.summoner.soloRankTier,
                            image: summonerDetail.summoner.soloRankIconUrl
                        )
                    ],
                    todayLogs: [
                        .init(cellType: .count, data: summonerDetail.today.playCount),
                        .init(cellType: .time, data: summonerDetail.today.playTime)
                    ],
                    todayPlayLogs: summonerDetail.todayPlayLogs.enumerated().map { index, log in
                        .init(
                            startTime: log.startTime,
                            endTime: log.endTime,
                            isWin: log.win,
                            isFirst: index == 0,
                            isLast: index == summonerDetail.todayPlayLogs.count - 1
                        )
                    },
                    weekPlayLogs: summonerDetail.thisWeek.enumerated().map { index, status in
                        .init(
                            day: ["월", "화", "수", "목", "금", "토", "일"][index],
                            count: status.playCount
                        )
                    }
                )
            }
            .eraseToAnyPublisher()
    }
}
