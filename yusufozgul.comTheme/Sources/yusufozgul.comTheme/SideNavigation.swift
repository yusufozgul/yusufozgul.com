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
    static func header<T: Website>(for context: PublishingContext<T>, selectedSection: T.SectionID? ) -> Node {
        return .header(
            .raw("<link rel=\"stylesheet\" href=\"/navigationStyle.css\" type=\"text/css\"/>"),
            .wrapper(
                .class("header navBar"),
                .nav(
                    .div(
                        .class("navArea"),
                        .input(
                            .type(HTMLInputType(rawValue: "checkbox")!),
                            .id("check")
                        ),
                        .label(
                            .for("check"),
                            .class("checkbtn"),
                            .raw("<img src=\"/upload-images/base/menu-icon.svg\" width=\"30\" height=\"30\">")
                        ),
                        .label(
                            .class("logo"),
                            .a(
                                .text("Yusuf Özgül"),
                                .href("/")
                            )
                        ),
                        .ul(
                            .class("navContent"),
                            .id("hoverEnabled"),
                            .li(
                                .a(
                                    .if(selectedSection?.rawValue == SectionID.home.rawValue, .class("active")),
                                    .href("/"),
                                    .text("Home")
                                )
                            ),
                            .li(
                                .a(
                                    .if(selectedSection?.rawValue == SectionID.about.rawValue, .class("active")),
                                    .href("/about"),
                                    .text("About")
                                )
                            ),
                            .li(
                                .a(
                                    .if(selectedSection?.rawValue == SectionID.contact.rawValue, .class("active")),
                                    .href("/contact"),
                                    .text("Contact")
                                )
                            ),
                            .li(
                                .a(
                                    .if(selectedSection?.rawValue == SectionID.projects.rawValue, .class("active")),
                                    .href("/projects"),
                                    .text("Projects")
                                )
                            ),
                            .li(
                                .a(
                                    .if(selectedSection?.rawValue == SectionID.blogs.rawValue, .class("active")),
                                    .href("/blogs"),
                                    .text("Blog")
                                )
                            )
                        )
                    )
                    
                )
            )
        )
    }
}
