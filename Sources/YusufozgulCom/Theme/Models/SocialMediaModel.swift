//
//  File.swift
//  
//
//  Created by Yusuf Özgül on 7.03.2021.
//

import Foundation

public struct SocialMedia {
    let link: String
    let icon: String
    let name: String
    
    public init(link: String, icon: String, name: String) {
        self.link = link
        self.icon = icon
        self.name = name
    }
}

public struct SocialMediaAccounts {
    let accounts: [SocialMedia]
    
    public init(accounts: [SocialMedia]) {
        self.accounts = accounts
    }
}
