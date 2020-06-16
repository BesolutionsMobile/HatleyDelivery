// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let acceptOffersResponse = try? newJSONDecoder().decode(AcceptOffersResponse.self, from: jsonData)

import Foundation

// MARK: - AcceptOffersResponse
struct AcceptOffersResponse: Codable {
    let success: String

    enum CodingKeys: String, CodingKey {
        case success = "success"
    }
}
