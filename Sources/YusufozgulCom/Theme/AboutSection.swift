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
    static func aboutPage<T: Website>(on site: T) -> Node {
        return .div(
            .class("item-page"),
            .educationSection(on: site, with: abouts.experience),
            .br(),
            .br(),
            .br(),
            .br(),
            .experienceSection(on: site, with: abouts.education)
        )
    }

    static func educationSection<T: Website>(on site: T, with datas: [About]) -> Node {
        return .div(
            .h1(
                .text("Experience"),
                .style("text-align: center;")
            ),
            .section(
                .id("cd-timeline"),
                .forEach(datas) { about in
                    .aboutItem(on: site, with: about)
                }
            )
        )
    }

    static func experienceSection<T: Website>(on site: T, with datas: [About]) -> Node {
        return .div(
            .h1(
                .text("Education"),
                .style("text-align: center;")
            ),
            .section(
                .id("cd-timeline"),
                .forEach(datas) { about in
                    .aboutItem(on: site, with: about)
                }
            )
        )
    }


    static func aboutItem<T: Website>(on site: T, with data: About) -> Node {
        return .div(
            .class("cd-timeline-block"),
            .div(.class("cd-timeline-img cd-movie")),
            .div(
                .div(
                    .text(data.date),
                    .style("text-align: right; color: white;")
                ),

                .class("cd-timeline-content"),
                .h2(
                    .text(data.title),
                    .style("color: white;")
                ),
                .h6(
                    .text(data.subtitle),
                    .style("color: white;")),
                
                .forEach(data.description) { text in
                    .ul(
                        .li(
                            .p(
                                .text(text)
                            )
                        ),
                        .style("color: white;")
                    )
                },

                .table(
                    .tr(
                        .forEach(data.refLink ?? []) { link in
                            .td(
                                .a(
                                    .style("color: white;"),
                                    .text(link[AboutLinkType.name] ?? ""),
                                    .text(" "),
                                    .href(link[AboutLinkType.link] ?? "")
                                )
                            )
                        }
                    )
                )
            )
        )
    }
}
