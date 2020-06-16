// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getOrdersResponse = try? newJSONDecoder().decode(GetOrdersResponse.self, from: jsonData)

import Foundation

// MARK: - GetOrdersResponse
struct GetOrdersResponse: Codable {
    let orders: [Orderr]
}

// MARK: - Order
struct Orderr: Codable {
    let id: Int
    let code: String
    let statusID, uploadID, offerID: Int?
    let deliveryTime, deliveredAt, createdAt, updatedAt: String?
    let orderDetails: OrderDetails
    let orderFinance: OrderFinance

    enum CodingKeys: String, CodingKey {
        case id, code
        case statusID = "status_id"
        case uploadID = "upload_id"
        case offerID = "offer_id"
        case deliveryTime = "delivery_time"
        case deliveredAt = "delivered_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case orderDetails = "order_details"
        case orderFinance = "order_finance"
    }
}

// MARK: - OrderDetails
struct OrderDetails: Codable {
    let id, orderID, userID, starID: Int?
    let userLocation, starLocation, orderDetails, orderFrom: String?
    let orderTo: String
    let orderLocationLat, orderLocationLong, clientLocationLat, clientLocationLong: Double
    let createdAt, updatedAt: String
    let orderClient: OrderClient

    enum CodingKeys: String, CodingKey {
        case id
        case orderID = "order_id"
        case userID = "user_id"
        case starID = "star_id"
        case userLocation = "user_location"
        case starLocation = "star_location"
        case orderDetails = "order_details"
        case orderFrom = "order_from"
        case orderTo = "order_to"
        case orderLocationLat = "order_location_lat"
        case orderLocationLong = "order_location_long"
        case clientLocationLat = "client_location_lat"
        case clientLocationLong = "client_location_long"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case orderClient = "order_client"
    }
}

// MARK: - OrderClient
struct OrderClient: Codable {
    let id, userTypeID: Int
    let code, name, email, gender: String?
    let address: String?
    let imageID: String
    let phone, emailVerifiedAt, mobileToken, deletedAt: String?
    let createdAt, updatedAt: String
    let totalUserOrders: TotalUserOrders

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
        case totalUserOrders = "total_user_orders"
    }
}

// MARK: - TotalUserOrders
struct TotalUserOrders: Codable {
    let id, userID, ordersCount: Int
    let totalOrdersValue: Double
    let overAllRate, totalDiscountValue: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case ordersCount = "orders_count"
        case totalOrdersValue = "total_orders_value"
        case overAllRate = "over_all_rate"
        case totalDiscountValue = "total_discount_value"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - OrderFinance
struct OrderFinance: Codable {
    let id, orderID: Int
    let minimumValue, serviceValue, productExpectedPrice, productRealPrice: Double?
    let promoCodeID: Int?
    let total: Double?
    let createdAt, updatedAt: String?
    let orderPromoCode: OrderPromoCode?

    enum CodingKeys: String, CodingKey {
        case id
        case orderID = "order_id"
        case minimumValue = "minimum_value"
        case serviceValue = "service_value"
        case productExpectedPrice = "product_expected_price"
        case productRealPrice = "product_real_price"
        case promoCodeID = "promo_code_id"
        case total
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case orderPromoCode = "order_promo_code"
    }
}


// MARK: - OrderPromoCode
struct OrderPromoCode: Codable {
    let id, discountPercentage, discountAmount: Int
    let code: String
    let bandwidth: Int
    let startsIn, dueDate: String
    let minimumOrderPrice, maxDiscountAmount, statusID, createdBy: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case discountPercentage = "discount_percentage"
        case discountAmount = "discount_amount"
        case code, bandwidth
        case startsIn = "starts_in"
        case dueDate = "due_date"
        case minimumOrderPrice = "minimum_order_price"
        case maxDiscountAmount = "max_discount_amount"
        case statusID = "status_id"
        case createdBy = "created_by"
        case createdAt = "created_at"
        case updatedAt = "updated_At"
    }
}
