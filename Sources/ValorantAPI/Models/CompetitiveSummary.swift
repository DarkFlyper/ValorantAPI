import Foundation

public struct CompetitiveSummary: Codable, Identifiable {
	public var userID: User.ID
	public var newPlayerExperienceFinished: Bool
	@_StringKeyedDictionary
	public var skillsByQueue: [QueueID: QueueInfo]
	public var latestUpdate: CompetitiveUpdate?
	public var isAnonymizedOnLeaderboard: Bool
	public var isActRankBadgeHidden: Bool
	
	public var id: User.ID { userID }
	
	private enum CodingKeys: String, CodingKey {
		case userID = "Subject"
		case newPlayerExperienceFinished = "NewPlayerExperienceFinished"
		case skillsByQueue = "QueueSkills"
		case latestUpdate = "LatestCompetitiveUpdate"
		case isAnonymizedOnLeaderboard = "IsLeaderboardAnonymized"
		case isActRankBadgeHidden = "IsActRankBadgeHidden"
	}
	
	public struct QueueInfo: Codable {
		public var totalGamesNeededForRating: Int
		public var totalGamesNeededForLeaderboard: Int
		public var gamesNeededForRatingThisSeason: Int
		
		@_StringKeyedDictionary
		public var bySeason: [Season.ID: SeasonInfo]
		
		private enum CodingKeys: String, CodingKey {
			case totalGamesNeededForRating = "TotalGamesNeededForRating"
			case totalGamesNeededForLeaderboard = "TotalGamesNeededForLeaderboard"
			case gamesNeededForRatingThisSeason = "CurrentSeasonGamesNeededForRating"
			case bySeason = "SeasonalInfoBySeasonID"
		}
	}
	
	public struct SeasonInfo: Codable {
		public var seasonID: Season.ID
		public var winCount: Int
		public var winCountIncludingPlacements: Int
		public var gameCount: Int
		public var rank: Int
		public var capstoneWins: Int
		public var leaderboardRank: Int
		public var competitiveTier: Int
		public var rankedRating: Int
		public var winsByTier: [Int: Int]?
		public var gamesNeededForRating: Int
		public var totalWinsNeededForRank: Int
		
		private enum CodingKeys: String, CodingKey {
			case seasonID = "SeasonID"
			case winCount = "NumberOfWins"
			case winCountIncludingPlacements = "NumberOfWinsWithPlacements"
			case gameCount = "NumberOfGames"
			case rank = "Rank"
			case capstoneWins = "CapstoneWins"
			case leaderboardRank = "LeaderboardRank"
			case competitiveTier = "CompetitiveTier"
			case rankedRating = "RankedRating"
			case winsByTier = "WinsByTier"
			case gamesNeededForRating = "GamesNeededForRating"
			case totalWinsNeededForRank = "TotalWinsNeededForRank"
		}
	}
}