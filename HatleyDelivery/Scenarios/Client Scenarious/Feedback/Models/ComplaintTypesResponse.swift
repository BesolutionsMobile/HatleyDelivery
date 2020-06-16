// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let complaintTypesResponse = try? newJSONDecoder().decode(ComplaintTypesResponse.self, from: jsonData)

import Foundation

// MARK: - ComplaintTypesResponse
struct ComplaintTypesResponse: Codable {
    let compliantTypes: [CompliantType]

    enum CodingKeys: String, CodingKey {
        case compliantTypes = "compliantTypes"
    }
}

// MARK: - CompliantType
struct CompliantType: Codable {
    let id: Int
    let type: String
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
