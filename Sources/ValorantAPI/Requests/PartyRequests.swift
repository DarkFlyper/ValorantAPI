import Protoquest

extension ValorantClient {
	public func getPartyID() async throws -> Party.ID? {
		do {
			return try await send(PlayerPartyRequest(playerID: userID, location: location))
				.currentPartyID
		} catch APIError.badResponseCode(404, _, _), APIError.resourceNotFound {
			return nil
		}
	}
	
	public func getPartyInfo(for id: Party.ID) async throws -> Party {
		try await send(PartyInfoRequest(partyID: id, location: location))
	}
	
	public func getPartyInfo() async throws -> Party? {
		guard let id = try await getPartyID() else { return nil }
		return try await getPartyInfo(for: id)
	}
	
	public func setReady(to isReady: Bool, in party: Party.ID) async throws -> Party {
		try await send(SetReadyRequest(
			partyID: party, playerID: userID, location: location,
			isReady: isReady
		))
	}
	
	public func changeQueue(to queue: QueueID, in party: Party.ID) async throws -> Party {
		try await send(ChangeQueueRequest(
			partyID: party, location: location,
			queueID: queue
		))
	}
	
	public func joinMatchmaking(in party: Party.ID) async throws -> Party {
		try await send(JoinMatchmakingRequest(partyID: party, location: location))
	}
	
	public func leaveMatchmaking(in party: Party.ID) async throws -> Party {
		try await send(LeaveMatchmakingRequest(partyID: party, location: location))
	}
}

private struct PlayerPartyRequest: GetJSONRequest, LiveGameRequest {
	var playerID: Player.ID
	var location: Location
	
	var path: String {
		"/parties/v1/players/\(playerID)"
	}
	
	struct Response: Decodable {
		var currentPartyID: Party.ID
		// TODO: this also has a requests and invites property, could support that later on
		
		private enum CodingKeys: String, CodingKey {
			case currentPartyID = "CurrentPartyID"
		}
	}
}

private struct PartyInfoRequest: GetJSONRequest, LiveGameRequest {
	var partyID: Party.ID
	var location: Location
	
	var path: String {
		"/parties/v1/parties/\(partyID)"
	}
	
	typealias Response = Party
}

private struct SetReadyRequest: JSONJSONRequest, Encodable, LiveGameRequest {
	var partyID: Party.ID
	var playerID: Player.ID
	var location: Location
	
	var path: String {
		"/parties/v1/parties/\(partyID)/members/\(playerID)/setReady"
	}
	
	var isReady: Bool
	
	private enum CodingKeys: String, CodingKey {
		case isReady = "ready"
	}
	
	typealias Response = Party
}

private struct ChangeQueueRequest: JSONJSONRequest, Encodable, LiveGameRequest {
	var partyID: Party.ID
	var location: Location
	
	var path: String {
		"/parties/v1/parties/\(partyID)/queue"
	}
	
	var queueID: QueueID
	
	private enum CodingKeys: String, CodingKey {
		case queueID = "queueID"
	}
	
	typealias Response = Party
}

private struct JoinMatchmakingRequest: JSONJSONRequest, Encodable, LiveGameRequest {
	var partyID: Party.ID
	var location: Location
	
	var path: String {
		"/parties/v1/parties/\(partyID)/matchmaking/join"
	}
	
	typealias Response = Party
}

private struct LeaveMatchmakingRequest: JSONJSONRequest, Encodable, LiveGameRequest {
	var partyID: Party.ID
	var location: Location
	
	var path: String {
		"/parties/v1/parties/\(partyID)/matchmaking/leave"
	}
	
	typealias Response = Party
}