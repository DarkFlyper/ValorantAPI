import Foundation

/// Represents the concept of a user, separate from the auth-provided `UserInfo` or the in-match `Player`.
public struct User: Codable {
	public typealias ID = ObjectID<Self, UUID>
	
	public var id: ID
	public var gameName: String
	public var tagLine: String
	
	public var name: String {
		"\(gameName) #\(tagLine)"
	}
	
	public init(id: ID, gameName: String, tagLine: String) {
		self.id = id
		self.gameName = gameName
		self.tagLine = tagLine
	}
	
	public init(_ info: UserInfo) {
		self.id = info.id
		self.gameName = info.account.gameName
		self.tagLine = info.account.tagLine
	}
	
	public init(_ player: Player) {
		self.id = player.id
		self.gameName = player.gameName
		self.tagLine = player.tagLine
	}
}
