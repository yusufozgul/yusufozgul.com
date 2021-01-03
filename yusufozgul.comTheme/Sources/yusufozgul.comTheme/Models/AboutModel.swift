//
//  File.swift
//  
//
//  Created by Yusuf Özgül on 2.01.2021.
//

import Foundation

public enum AboutLinkType {
    case link
    case name
}

public struct About {
    public init(title: String, subtitle: String, date: String, description: [String], refLink: [[AboutLinkType : String]]?) {
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.description = description
        self.refLink = refLink
    }
    
    let title: String
    let subtitle: String
    let date: String
    let description: [String]
    let refLink: [[AboutLinkType: String]]?
}

public struct Abouts {
    public init(education: [About], experience: [About]) {
        self.education = education
        self.experience = experience
    }
    
    let education: [About]
    let experience: [About]
    
}
