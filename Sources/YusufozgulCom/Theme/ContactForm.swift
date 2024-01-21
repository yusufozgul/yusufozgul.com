//
//  File.swift
//  
//
//  Created by Yusuf Özgül on 2.01.2021.
//

import Foundation
import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    static func contactForm<T: Website>(on site: T) -> Node {
        return .div(
            .div(
                .id("socialMedia"),
                .forEach(socialMediaLinks.accounts, { account in
                    .a(
                        .id("socialMedia"),
                        .href(account.link),
                        .target(HTMLAnchorTarget(rawValue: "_blank")!),
                        .raw("<img src=\"/upload-images/base/\(account.icon)\" width=\"30\" height=\"30\">"),
                        .span(
                            .id("socialMedia"),
                            .text(account.name)
                        )
                    )
                })
            ),
            .raw("""
            <iframe src="https://alpha-1.yusufozgul.com/nocodb/dashboard/#/nc/form/26193786-0a3e-47c8-8af4-2a735cec5871" width="100%" height="100%" style="border: none;"></iframe>
            """)
        )
    }
}
