//
//  File.swift
//  YoMeda
//
//  Created by Ahmed Hussien on 22/10/2022.
//

import Foundation
// MARK: - Posts
struct Posts: Codable {
    let complaints: [Complaint]?
    let success: Bool?
    let code: Int?
    let englishMessage: String?
    let arabicMessage: String?
    let currentPage: Int?
    let pageCount: Int?

    enum CodingKeys: String, CodingKey {
        case complaints = "complaints"
        case success = "Success"
        case code = "Code"
        case englishMessage = "EnglishMessage"
        case arabicMessage = "ArabicMessage"
        case currentPage = "CurrentPage"
        case pageCount = "PageCount"
    }
}
// MARK: - Complaint
struct Complaint: Codable {
    let id: String?
    let code: String?
    let arabicName: String?
    let englishName: String?
    let pagesCount: Int?
    let rnum: Int?
    let quantity: Int?
    let indexCount: Int?
    let isLimited: Int?
    let groupCode: String?
    let complaintDescription: String?
    let picURL: String?
    let price: Double?
    let isDrug: Bool?
    let covidGroupName: String?
    let covidGroupNameEN: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case code = "code"
        case arabicName = "ArabicName"
        case englishName = "EnglishName"
        case pagesCount = "pages_count"
        case rnum = "rnum"
        case quantity = "Quantity"
        case indexCount = "indexCount"
        case isLimited = "IsLimited"
        case groupCode = "GroupCode"
        case complaintDescription = "Description"
        case picURL = "PicUrl"
        case price = "Price"
        case isDrug = "IsDrug"
        case covidGroupName = "CovidGroupName"
        case covidGroupNameEN = "CovidGroupNameEN"
    }
}
