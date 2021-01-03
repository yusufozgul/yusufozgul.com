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
            .wrapper(
                .class("header text-center"),
                .nav(
                    .class("navbar navbar-expand-lg navbar-dark"),
                    .button(
                        .class("navbar-toggler"),
                        .data(named: "toggle", value: "collapse"),
                        .data(named: "target", value: "#navigation"),
                        .data(
                            .attribute(named: "toggle", value: "collapse"),
                            .attribute(named: "target", value: "#navigation")
                        ),
                        .ariaControls("navigation"),
                        .ariaExpanded(false),
                        .ariaLabel("toggle navigation"),
                        .span(
                            .class("navbar-toggler-icon")
                        ),
                        .div(
                            .class("blog-name"),
                            .h2("Yusuf's blog")
                        )
                    ),
                    .div(
                        .id("navigation"),
                        .class("collapse navbar-collapse flex-column"),
                        .div(
                            .class("profile-section pt-3 pt-lg-0"),
                            .img(
                                .class("profile-image mb-3 rounded-circle mx-auto"),
                                .src("/upload-images/base/avatar.jpg"),
                                .alt("image")
                            ),
                            .div(
                                .class("bio mb-3"),
                                .text("Hi, i'm Yusuf"),
                                .br(),
                                .a(
                                    .text("Find out more about me"),
                                    .href(Path("./about"))
                                )
                            ),
                            .ul(
                                .class("social-list list-inline py-3 mx-auto"),
                                .li(
                                    .a(
                                        .class("socialIcon"),
                                        .href("https://twitter.com/ysf_ozgul"),
                                        .i(
                                            .class("fab fa-twitter fa-fw")
                                        )
                                    )
                                ),
                                .li(
                                    .a(
                                        .class("socialIcon"),
                                        .href("https://www.linkedin.com/in/yusufozgul"),
                                        .i(
                                            .class("fab fa-linkedin-in fa-fw")
                                        )
                                    )
                                ),
                                .li(
                                    .a(
                                        .class("socialIcon"),
                                        .href("https://github.com/yusufozgul"),
                                        .i(
                                            .class("fab fa-github-alt fa-fw")
                                        )
                                    )
                                ),
                                .li(
                                    .a(
                                        .class("socialIcon"),
                                        .href("https://www.instagram.com/yusuf.ozgul/"),
                                        .i(
                                            .class("fab fa-instagram fa-fw")
                                        )
                                    )
                                )
                            ),
                            .hr()
                        ),
                        .ul(
                            .class("navbar-nav flex-column text-left"),
                            .li(
                                .class("nav-item active"),
                                .a(
                                    .class("nav-link"),
                                    .href(Path("/")),
                                    .i(
                                        .class("fas fa-home fa-fw mr-2")
                                    ),
                                    .text("Home")
                                )
                            )
                            
                        ),
                        
                        .ul(
                            .class("navbar-nav flex-column text-left"),
                            .li(
                                .class("nav-item active"),
                                .a(
                                    .class("nav-link"),
                                    .href(Path("./about")),
                                    .i(
                                        .class("fas fa-user fa-fw mr-2")
                                    ),
                                    .text("About Me")
                                )
                            )
                            
                        ),
                        .ul(
                            .class("navbar-nav flex-column text-left"),
                            .li(
                                .class("nav-item active"),
                                .a(
                                    .class("nav-link"),
                                    .href(Path("./contact")),
                                    .i(
                                        .class("far fa-id-card fa-fw mr-2")
                                    ),
                                    .text("Contact")
                                )
                            )
                            
                        ),
                        .ul(
                            .class("navbar-nav flex-column text-left"),
                            .li(
                                .class("nav-item active"),
                                .a(
                                    .class("nav-link"),
                                    .href(Path("./projects")),
                                    .i(
                                        .class("fas fa-terminal fa-fw mr-2")
                                    ),
                                    .text("Projects")
                                )
                            )
                            
                        ),
                        .ul(
                            .class("navbar-nav flex-column text-left"),
                            .li(
                                .class("nav-item active"),
                                .a(
                                    .class("nav-link"),
                                    .href(Path("./blogs")),
                                    .i(
                                        .class("fas fa-file-alt fa-fw mr-2")
                                    ),
                                    .text("Blog")
                                )
                            )
                            
                        )
                    )
                )
            ),
            .script(
                .src("https://code.jquery.com/jquery-3.4.1.min.js"),
                .integrity("sha384-vk5WoKIaW/vJyUAd9n/wmopsmNhiy+L2Z+SBxGYnUkunIxVxAv/UtMOhba/xskxh"),
                .attribute(named: "crossorigin", value: "anonymous")
            ),
            .script(
                .src("https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"),
                .integrity("sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"),
                .attribute(named: "crossorigin", value: "anonymous")
            ),
            .script(
                .src("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js")
            )
        )
    }
}
