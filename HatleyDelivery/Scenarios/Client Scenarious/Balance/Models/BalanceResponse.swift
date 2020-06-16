// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let balanceResponse = try? newJSONDecoder().decode(BalanceResponse.self, from: jsonData)

import Foundation

// MARK: - BalanceResponse
struct BalanceResponse: Codable {
    let success: String
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case data = "data"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let promotedValue: Int
    let fromEarned: Int
    let credit: Int

    enum CodingKeys: String, CodingKey {
        case promotedValue = "promoted_value"
        case fromEarned = "from_earned"
        case credit = "credit"
    }
}
