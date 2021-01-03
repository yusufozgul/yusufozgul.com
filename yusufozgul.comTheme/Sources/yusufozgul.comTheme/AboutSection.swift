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
                .i(.class("fas fa-briefcase")),
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
                .i(.class("fa fa-graduation-cap")),
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
                    .style("text-align: right;")
                ),

                .class("cd-timeline-content"),
                .h2(.text(data.title)),
                .h6(.text(data.subtitle)),
                .forEach(data.description) { text in
                    .ul(.li(.p(.text(text))))
                },

                .table(
                    .tr(
                        .forEach(data.refLink ?? []) { link in
                            .td(
                                .a(
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
