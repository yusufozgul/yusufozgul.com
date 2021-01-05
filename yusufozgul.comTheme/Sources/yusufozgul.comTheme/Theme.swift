//
//  Theme.swift
//  
//
//  Created by Yusuf Özgül on 1.01.2021.
//

import Foundation
import Plot
import Publish
import ReadingTimePublishPlugin

enum SectionID: String, WebsiteSectionID {
    case home
    case about
    case contact
    case projects
    case blogs
}

extension DateFormatter {
    static var blog: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
}

public var abouts = Abouts(education: [], experience: [])
public var projects = Projects(items: [])

public extension Theme {
    static var yusufozgulcom: Self {
        Theme(
            htmlFactory: ThemeHTMLFactory(),
            resourcePaths: ["Resources/CSS/styles.css", "Resources/CSS/aboutStyles.css"]
        )
    }
}

struct ThemeHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .class("main-wrapper"),
                
                // Projects
                .div(
                    .class("index page wrapper content clearfix "),
                    .div(
                        .class("section-header float-container"),
                        .h1("👨‍💻 Projects")
                    ),
                    .div(
                        .class("projects-ul"),
                        .indexProjectList(for: projects.items, on: context.site)
                    )
                ),
//                 Articles
                .wrapper(
                    .a(
                        .href("./blogs"),
                        .h1("🚀 Latest articles")
                    ),
                    .itemList(
                        for: Array(context.allItems(sortedBy: \.date, order: .descending).filter { $0.sectionID.rawValue == SectionID.blogs.rawValue }.prefix(3)),
                        on: context.site
                    ),
                    .a(
                        .class("browse-all"),
                        .href("./blogs"),
                        .text("Browse all \(context.allItems(sortedBy: \.date, order: .descending).filter { $0.sectionID.rawValue == SectionID.blogs.rawValue }.count) articles")
                    )
                ),
                .br(),
                .br(),
                .footer(for: context.site)
                
            )
        )
    }
    
    func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .if(section.id.rawValue == SectionID.about.rawValue, .head(for: section, on: context.site, stylesheetPaths: ["/aboutStyles.css"])),
            .body(
                .header(for: context, selectedSection: nil),
                .class("main-wrapper"),
                
                .if(section.id.rawValue == SectionID.projects.rawValue,
                    .wrapper(
                        .div(
                            .class("projectListSpacing"),
                            .projectList(for: projects.items, on: context.site)
                        )
                    )
                ),
                .if(section.id.rawValue == SectionID.contact.rawValue,
                    .wrapper(
                        .h1(.text(section.title)),
                        .contactForm(on: context.site)
                    )
                ),
                .if(section.id.rawValue == SectionID.about.rawValue,
                    .wrapper(
                        .h1(.text(section.title)),
                        .aboutPage(on: context.site)
                    )
                ),
                .if(section.id.rawValue == SectionID.blogs.rawValue, .wrapper(
                    .h1(.text(section.title)),
                    .itemList(for: Array(context.allItems(sortedBy: \.date, order: .descending).filter { $0.sectionID.rawValue == "blogs" }), on: context.site)
                )),
                .footer(for: context.site)
            )
        )
    }
    
    func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site, stylesheetPaths: ["/styles.css", "/gallery.css"]),
            .body(
                .class("item-page"),
                .header(for: context, selectedSection: item.sectionID),
                .class("main-wrapper"),
                .wrapper(
                    .h2(
                        .class("post-title"),
                        .text(item.title)
                    ),
                    .a(
                        .p(
                           .text(DateFormatter.blog.string(from: item.date)),
                            .br(),
                            .text("Reading \(item.readingTime.minutes) minutes")
                        )
                    ),
                    .tagList(for: item, on: context.site),
                    .div(
                        .class("post-description"),
                        .div(
                            .contentBody(item.body)
                        )
                    )
                ),
                .footer(for: context.site)
            )
        )
    }
    
    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .class("main-wrapper"),
                .wrapper(.contentBody(page.body)),
                .footer(for: context.site)
            )
        )
    }
    
    func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .class("main-wrapper"),
                .wrapper(
                    .h1("Browse all tags"),
                    .ul(
                        .class("all-tags"),
                        .forEach(page.tags.sorted()) { tag in
                            .li(
                                .class("tag.colorfiedClass"),
                                .a(
                                    .href(Path("./\(context.site.path(for: tag))")),
                                    .text(tag.string)
                                )
                            )
                        }
                    )
                ),
                .footer(for: context.site)
            )
        )
    }
    
    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .class("main-wrapper"),
                .wrapper(
                    .h1(
                        "Tagged with ",
                        .span(.class("tag.colorfiedClass"), .text(page.tag.string))
                    ),
                    .a(
                        .class("browse-all"),
                        .text("Browse all tags"),
                        .href(Path("./\(context.site.tagListPath)"))
                    ),
                    .itemList(
                        for: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site
                    )
                ),
                .footer(for: context.site)
            )
        )
    }
}

extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }
    
    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(.article(
                    .h1(.a(
                        .href(Path(".\(item.path.absoluteString)")),
                        .text(item.title)
                        )),
                    .a(
                        .text(DateFormatter.blog.string(from: item.date)),
                        .br(),
                        .text("Reading \(item.readingTime.minutes) minutes")
                    ),
                    .tagList(for: item, on: site),
                    .p(.text(item.description))
                    ))
            }
        )
    }
    
    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(
                .class("variant-\(Int.random(in: 0...7))"),
                .a(
                    .text(tag.string),
                    .href(Path("./\(site.path(for: tag))"))
                ))
            })
    }
    
    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .p(
                .text("Generated using "),
                .a(
                    .text("Publish"),
                    .href("https://github.com/johnsundell/publish")
                )
            ),
            .p(
                .a(
                .text("RSS feed"),
                .href("/feed.rss")
                )
            ),
            .p(
                .a(
                    .text("Developed Yusuf Özgül"),
                    .href("https://github.com/yusufozgul")
                )
            )
        )
    }
}


