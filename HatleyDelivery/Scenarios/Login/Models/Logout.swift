// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let logout = try? newJSONDecoder().decode(Logout.self, from: jsonData)

import Foundation

// MARK: - Logout
struct Logout: Codable {
    let message: String

    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}
