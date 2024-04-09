//
//  Data.swift
//  SofascoreAcademy
//
//  Created by Akademija on 18.03.2024..
//

import Foundation

enum matchStatus {
    case upcoming
    case inProgress
    case homeTeamWin
    case awayTeamWin
    case draw
}

struct matchData{
    let matchId: Int
    let homeTeam: String
    let awayTeam: String
    let homeLogo: String
    let awayLogo: String
    let status: matchStatus
    let timeStamp: TimeInterval
    let homeTeamScore: Int?
    let awayTeamScore: Int?
}

struct LeagueInfo {
    let countryName: String
    let leagueName: String
    let leagueLogo: String
    let matches: [matchData]
}

let matchData1 = matchData(matchId: 1, homeTeam: "Real Madrid", awayTeam: "Barcelona", homeLogo: "rmLogo", awayLogo: "fcb_logo", status: .awayTeamWin, timeStamp: 1710331200, homeTeamScore: 1, awayTeamScore: 2)

let matchData2 = matchData(matchId: 2, homeTeam: "Real Madrid", awayTeam: "Barcelona", homeLogo: "rmLogo", awayLogo: "fcb_logo", status: .inProgress, timeStamp: 1710342000, homeTeamScore: 0, awayTeamScore: 1)

let matchData3 = matchData(matchId: 3, homeTeam: "Real Madrid", awayTeam: "Barcelona", homeLogo: "rmLogo", awayLogo: "fcb_logo", status: .upcoming, timeStamp: 1710349200, homeTeamScore: nil, awayTeamScore: nil)

let matchData4 = matchData(matchId: 4, homeTeam: "Real Madrid", awayTeam: "Barcelona", homeLogo: "rmLogo", awayLogo: "fcb_logo", status: .upcoming, timeStamp: 1710354600, homeTeamScore: nil, awayTeamScore: nil)

let matchData5 = matchData(matchId: 5, homeTeam: "Bayern Munich", awayTeam: "RB Leipzig", homeLogo: "bayernLogo", awayLogo: "leipzigLogo", status: .draw, timeStamp: 1710331200, homeTeamScore: 3, awayTeamScore: 3)

let matchData6 = matchData(matchId: 6, homeTeam: "Bayern Munich", awayTeam: "RB Leipzig", homeLogo: "bayernLogo", awayLogo: "leipzigLogo", status: .inProgress, timeStamp: 1710342000, homeTeamScore: 1, awayTeamScore: 1)

let matchData7 = matchData(matchId: 7, homeTeam: "Bayern Munich", awayTeam: "RB Leipzig", homeLogo: "bayernLogo", awayLogo: "leipzigLogo", status: .upcoming, timeStamp: 1710349200, homeTeamScore: nil, awayTeamScore: nil)

let matchData8 = matchData(matchId: 8, homeTeam: "Bayern Munich", awayTeam: "RB Leipzig", homeLogo: "bayernLogo", awayLogo: "leipzigLogo", status: .upcoming, timeStamp: 1710354600, homeTeamScore: nil, awayTeamScore: nil)

let matchData9 = matchData(matchId: 9, homeTeam: "Arsenal", awayTeam: "Manchester United", homeLogo: "arsenalLogo", awayLogo: "mutd_logo", status: .awayTeamWin, timeStamp: 1710331200, homeTeamScore: 1, awayTeamScore: 3)

let matchData10 = matchData(matchId: 10, homeTeam: "Arsenal", awayTeam: "Manchester United", homeLogo: "arsenalLogo", awayLogo: "mutd_logo", status: .homeTeamWin, timeStamp: 1710342000, homeTeamScore: 2, awayTeamScore: 1)

let matchData11 = matchData(matchId: 11, homeTeam: "Arsenal", awayTeam: "Manchester United", homeLogo: "arsenalLogo", awayLogo: "mutd_logo", status: .draw, timeStamp: 1710349200, homeTeamScore: 2, awayTeamScore: 2)

let matchData12 = matchData(matchId: 12, homeTeam: "Arsenal", awayTeam: "Manchester United", homeLogo: "arsenalLogo", awayLogo: "mutd_logo", status: .upcoming, timeStamp: 1710354600, homeTeamScore: nil, awayTeamScore: nil)

let matches1: Array<matchData> = [matchData1, matchData4, matchData3, matchData2].sorted(by: { $0.timeStamp < $1.timeStamp })

let matches2: Array<matchData> = [matchData5, matchData6, matchData7, matchData8].sorted(by: { $0.timeStamp < $1.timeStamp })

let matches3: Array<matchData> = [matchData9, matchData10, matchData11, matchData12].sorted(by: { $0.timeStamp < $1.timeStamp })

let matches = matches1 + matches2 + matches3

let leagueInfo1 = LeagueInfo(countryName: "Spain", leagueName: "LaLiga", leagueLogo: "LaLigaLogo", matches: matches1)
let leagueInfo2 = LeagueInfo(countryName: "Germany", leagueName: "Bundesliga", leagueLogo: "BundesligaLogo", matches: matches2)
let leagueInfo3 = LeagueInfo(countryName: "England", leagueName: "Premier League", leagueLogo: "plLogo", matches: matches3)
let leaguesData1 = [leagueInfo1, leagueInfo1, leagueInfo1]
let leaguesData2 = [leagueInfo2, leagueInfo2, leagueInfo2]
let leaguesData3 = [leagueInfo3, leagueInfo3, leagueInfo3]
