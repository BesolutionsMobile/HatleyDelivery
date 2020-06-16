// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let rateResponse = try? newJSONDecoder().decode(RateResponse.self, from: jsonData)

import Foundation

// MARK: - RateResponse
struct RateResponse: Codable {
    let success: String
    let notes: [Note]

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case notes = "notes"
    }
}

// MARK: - Note
struct Note: Codable {
    let id: Int
    let starRateID: Bool
    let note: String
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case starRateID = "star_rate_id"
        case note = "note"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
