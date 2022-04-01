//
//  RoomModel.swift
//  iOSVmTask
//
//  Created by Taresh Jain on 01/04/22.
//

import Foundation

struct RoomModel: Codable {
    let createdAt: String?
    let isOccupied: Bool?
    let maxOccupancy: Int?
    let id: String?

    enum CodingKeys: String, CodingKey {

        case createdAt
        case isOccupied
        case maxOccupancy
        case id
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        isOccupied = try values.decodeIfPresent(Bool.self, forKey: .isOccupied)
        maxOccupancy = try values.decodeIfPresent(Int.self, forKey: .maxOccupancy)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }

}

