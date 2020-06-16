// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getUserResponse = try? newJSONDecoder().decode(GetUserResponse.self, from: jsonData)

import Foundation

// MARK: - GetUserResponse
struct GetUserResponse: Codable {
    let success: Success

    enum CodingKeys: String, CodingKey {
        case success = "success"
    }
}

// MARK: - Success
struct Success: Codable {
    let id: Int
    let userTypeID: Int
    let code: String
    let name: String
    let email: String
    let gender: String?
    let address: String?
    let imageID: String?
    let phone: String?
    let emailVerifiedAt: String?
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userTypeID = "user_type_id"
        case code = "code"
        case name = "name"
        case email = "email"
        case gender = "gender"
        case address = "address"
        case imageID = "image_id"
        case phone = "phone"
        case emailVerifiedAt = "email_verified_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
