// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let orderResponse = try? newJSONDecoder().decode(OrderResponse.self, from: jsonData)

import Foundation

// MARK: - OrderResponse
struct OrderResponse: Codable {
    let order: Order

    enum CodingKeys: String, CodingKey {
        case order = "order"
    }
}

// MARK: - Order
struct Order: Codable {
    let code: String
    let statusID: Int
    let deliveryTime: String
    let updatedAt: String
    let createdAt: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case statusID = "status_id"
        case deliveryTime = "delivery_time"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id = "id"
    }
}
