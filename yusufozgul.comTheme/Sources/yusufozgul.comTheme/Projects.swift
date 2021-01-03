//
//  File.swift
//  
//
//  Created by Yusuf Özgül on 2.01.2021.
//

import Publish
import Plot
import Foundation

extension Node where Context == HTML.BodyContext {
    
    static func indexProjectList<T: Website>(for items: [Project], on site: T) -> Node {
        return .ul(
            .class("ul-project-container"), //compact grid latest item-list
            .forEach(items) { item in
                .li(
                    .class("li-project-item"),
                    .a(
                        .href(Path("\("/projects#\(item.code)")")),
                        .div(
                            .img(.src(item.appIcon), .init(name: "width", value: "70")),
                            .br(),
                            .text(item.name),
                            .p(
                                .class("appSubheader"),
                                .text(item.subheader)
                            )
                        )
                    )
                )
            }
        )
    }
    
    static func projectList<T: Website>(for items: [Project], on site: T) -> Node {
        return .div(
            .h1(
                .text("Projects"),
                .br(),
                .br()
            ),
            .forEach(items) { item in
                .div(
                    .class("project-row"),
                    .div(
                        .class("project-column-left"),
                        .div(
                            .class("video"),
                            .img(
                                .src(item.screenShotLink),
                                .init(name: "width", value: "300")
                            )
                        )
                    ),
                    .div(
                        .class("project-column-right"),
                        .div(
                            .class("app-row"),
                            .div(
                                .class("app-column-left"),
                                .img(.id(item.code), .class("app_icon"),.src("\(item.appIcon)"), .init(name: "width", value: "70"))
                            ),
                            .div(
                                .class("app-column-right"),
                                .h2(.class("app_name"),.text(item.name)),
                                .h6(.class("app_header"), .text(item.subheader))
                            )
                        ),
                        .div(
                            .class("app_description"),
                            .forEach(item.paragraphs) { paragraph in
                                .p(.text(paragraph))
                            },
                            .h4(.text("My Role")),
                            .p(.text(item.role)),
                            .h4(.text("Technologies")),
                            .ul(.class("tech-list"), .forEach(item.technologies) { tech in
                                .li(
                                    .class("tag"),
                                    .text(tech)
                                )
                                }),
                            .table(
                                .tr(
                                    .if(item.gitHub_link != "",
                                        .td(
                                            .a(
                                                .img(
                                                    .class("app_download"),
                                                    .src("/upload-images/base/github.png"),
                                                    .init(name: "width", value: "150")
                                                    
                                                ),
                                                .href(item.gitHub_link)
                                            )
                                            
                                        )
                                    ),
                                    .if(item.appStore_link != "",
                                        .td(
                                            .a(
                                                .img(
                                                    .class("app_download"),
                                                    .src("/upload-images/base/appstore.png"),
                                                    .init(name: "width", value: "150")
                                                ),
                                                .href(item.appStore_link)
                                            )
                                        )
                                    )
                                )
                            ),
                            
                            .br()
                        )
                    )
                )
            }
        )
    }
}

