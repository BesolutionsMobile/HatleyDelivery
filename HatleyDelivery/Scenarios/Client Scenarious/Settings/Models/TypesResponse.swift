// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let typesResponse = try? newJSONDecoder().decode(TypesResponse.self, from: jsonData)

import Foundation

// MARK: - TypesResponse
struct TypesResponse: Codable {
    let message: String
    let userTypeID: Int

    enum CodingKeys: String, CodingKey {
        case message = "message"
        case userTypeID = "user_type_id"
    }
}
