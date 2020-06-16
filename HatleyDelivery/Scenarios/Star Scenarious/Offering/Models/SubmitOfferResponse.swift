// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let submitOfferResponse = try? newJSONDecoder().decode(SubmitOfferResponse.self, from: jsonData)

import Foundation

// MARK: - SubmitOfferResponse
struct SubmitOfferResponse: Codable {
    let success: String

    enum CodingKeys: String, CodingKey {
        case success = "success"
    }
}
