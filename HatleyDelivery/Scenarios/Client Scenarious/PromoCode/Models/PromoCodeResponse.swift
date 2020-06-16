// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let promoCodeResponse = try? newJSONDecoder().decode(PromoCodeResponse.self, from: jsonData)

import Foundation

// MARK: - PromoCodeResponse
struct PromoCodeResponse: Codable {
    let message: String
    let codeInfo: CodeInfo

    enum CodingKeys: String, CodingKey {
        case message = "message"
        case codeInfo = "codeInfo"
    }
}

// MARK: - CodeInfo
struct CodeInfo: Codable {
    let discountAmount: Int

    enum CodingKeys: String, CodingKey {
        case discountAmount = "discount_amount"
    }
}
