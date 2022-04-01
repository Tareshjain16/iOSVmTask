//
//  PeopleModel.swift
//  iOSVmTask
//
//

import Foundation

struct PeopleModel: Codable {
    let createdAt: String?
    let firstName: String?
    let avatar: String?
    let lastName: String?
    let email: String?
    let jobtitle: String?
    let favouriteColor: String?
    let peopleId: String?

    enum CodingKeys: String, CodingKey {

        case createdAt
        case firstName
        case avatar
        case lastName
        case email
        case jobtitle
        case favouriteColor
        case peopleId = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        jobtitle = try values.decodeIfPresent(String.self, forKey: .jobtitle)
        favouriteColor = try values.decodeIfPresent(String.self, forKey: .favouriteColor)
        peopleId = try values.decodeIfPresent(String.self, forKey: .peopleId)
    }

}
