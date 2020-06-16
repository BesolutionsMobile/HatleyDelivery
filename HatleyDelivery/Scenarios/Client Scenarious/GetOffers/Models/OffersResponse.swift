// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let offersResponse = try? newJSONDecoder().decode(OffersResponse.self, from: jsonData)

import Foundation

// MARK: - OffersResponse
struct OffersResponse: Codable {
    let offers: [Offer]
}

// MARK: - Offer
struct Offer: Codable {
    let id, starID, orderID: Int
    let expectedDeliveryTime: String
    let statusID, offerValue, duration: Int?
    let createdAt, updatedAt: String
    let offerStar: OfferStar

    enum CodingKeys: String, CodingKey {
        case id
        case starID = "star_id"
        case orderID = "order_id"
        case expectedDeliveryTime = "expected_delivery_time"
        case statusID = "status_id"
        case offerValue = "offer_value"
        case duration
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case offerStar = "offer_star"
    }
}

// MARK: - OfferStar
struct OfferStar: Codable {
    let id, userTypeID: Int
    let code, name, email, gender: String?
    let address: String?
    let imageID: String
    let phone, emailVerifiedAt, mobileToken, deletedAt: String?
    let createdAt, updatedAt: String
    let totalStarOrders: TotalStarOrders

    enum CodingKeys: String, CodingKey {
        case id
        case userTypeID = "user_type_id"
        case code, name, email, gender, address
        case imageID = "image_id"
        case phone
        case emailVerifiedAt = "email_verified_at"
        case mobileToken = "mobile_token"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case totalStarOrders = "total_star_orders"
    }
}

// MARK: - TotalStarOrders
struct TotalStarOrders: Codable {
    let id, starID, ordersCount: Int
    let totalOrdersValue: Double
    let overAllRate: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case starID = "star_id"
        case ordersCount = "orders_count"
        case totalOrdersValue = "total_orders_value"
        case overAllRate = "over_all_rate"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
