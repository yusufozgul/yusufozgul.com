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

enum Tags: String {
    case docker
    case swift
    case publish
    case collectionView
    case software
    case codable
    case json
    case rest
    case goLang
    case apple
    case other
    
    static func find(tag: String) -> Tags {
        if tag == "Docker" { return .docker }
        if tag == "Swift" { return .swift }
        if tag == "Publish" { return .publish }
        if tag == "CollectionView" { return .collectionView }
        if tag == "Software" { return .software }
        if tag == "Codable" { return .codable }
        if tag == "JSON" { return .json }
        if tag == "REST" { return .rest }
        if tag == "Go Lang" || tag == "Go" { return .goLang }
        if tag == "Apple" { return .apple }
        return .other
    }
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
public var socialMediaLinks = SocialMediaAccounts(accounts: [])

public extension Theme {
    static var yusufozgulcom: Self {
        Theme(
            htmlFactory: ThemeHTMLFactory(),
            resourcePaths: ["Resources/CSS/styles.css", "Resources/CSS/aboutStyles.css", "Resources/CSS/navigationStyle.css", "Resources/CSS/socialMediaLinks.css"]
        )
    }
}

struct ThemeHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body(
                .component(ThemeHeader(context: context,
                                       selectedSection: context.sections.ids.filter({ $0.rawValue == YusufozgulCom.SectionID.home.rawValue}).first)),
                .class("main-wrapper"),
                //              Articles
                .wrapper(
                    .a(
                        .href("./blogs"),
                        .h1("🚀 Latest Articles")
                    ),
                    .component(ThemeItemList(items: Array(context.allItems(sortedBy: \.date, order: .descending).filter { $0.sectionID.rawValue == YusufozgulCom.SectionID.blogs.rawValue }.prefix(10)), site: context.site)
                    ),
                    .a(
                        .class("browse-all"),
                        .href("./blogs"),
                        .text("Browse all \(context.allItems(sortedBy: \.date, order: .descending).filter { $0.sectionID.rawValue == YusufozgulCom.SectionID.blogs.rawValue }.count) articles")
                    )
                ),
                
                //              Projects
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
                .br(),
                .br(),
                .component(ThemeFooter())
                
            )
        )
    }
    
    func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .if(section.id.rawValue == YusufozgulCom.SectionID.about.rawValue, .head(for: section, on: context.site, stylesheetPaths: ["/aboutStyles.css"])),
            .if(section.id.rawValue == YusufozgulCom.SectionID.contact.rawValue, .head(for: section, on: context.site, stylesheetPaths: ["/socialMediaLinks.css"])),
            .body(
                .component(ThemeHeader(context: context, selectedSection: section.id)),
                .class("main-wrapper"),
                
                .if(section.id.rawValue == YusufozgulCom.SectionID.projects.rawValue,
                    .wrapper(
                        .div(
                            .class("projectListSpacing"),
                            .projectList(for: projects.items, on: context.site)
                        )
                    )
                ),
                .if(section.id.rawValue == YusufozgulCom.SectionID.contact.rawValue,
                    .wrapper(
                        .h1(.text(section.title)),
                        .contactForm(on: context.site)
                    )
                ),
                .if(section.id.rawValue == YusufozgulCom.SectionID.about.rawValue,
                    .wrapper(
                        .h1(.text(section.title)),
                        .aboutPage(on: context.site)
                    )
                ),
                .if(section.id.rawValue == YusufozgulCom.SectionID.blogs.rawValue, .wrapper(
                    .h1(.text(section.title)),
                    .component(ThemeItemList(items: Array(context.allItems(sortedBy: \.date, order: .descending).filter { $0.sectionID.rawValue == "blogs" }), site: context.site)
                    )
                )),
                .component(ThemeFooter())
            )
        )
    }
    
    func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site, stylesheetPaths: ["styles.css", "/gallery.css"]),
            .body(
                .class("item-page"),
                .component(ThemeHeader(context: context, selectedSection: item.sectionID)),
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
                    .component(ThemeTagList(tags: item.tags, site: context.site)),
                    .div(
                        .class("post-description"),
                        .div(
                            .contentBody(item.body)
                        )
                    )
                ),
                .component(ThemeFooter())
            )
        )
    }
    
    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .component(ThemeHeader(context: context, selectedSection: nil)),
                .class("main-wrapper"),
                .wrapper(.contentBody(page.body)),
                .component(ThemeFooter())
            )
        )
    }
    
    func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .component(ThemeHeader(context: context, selectedSection: nil)),
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
                .component(ThemeFooter())
            )
        )
    }
    
    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .component(ThemeHeader(context: context, selectedSection: nil)),
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
                    .component(ThemeItemList(items: context.items(taggedWith: page.tag,
                                                                  sortedBy: \.date,
                                                                  order: .descending),
                                             site: context.site)
                    )
                ),
                .component(ThemeFooter())
            )
        )
    }
}

extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }
}

struct ThemeWrapper: Component {
    var nodes: [Node<HTML.BodyContext>]
    @ComponentBuilder public var content: ContentProvider

    init(nodes: [Node<HTML.BodyContext>], @ComponentBuilder content: @escaping ContentProvider) {
        self.content = content
        self.nodes = nodes
    }
    
    var body: Component {
        Div {
            Node.group(nodes)
            content()
        }
        .class("wrapper")
    }
}

struct ThemeFooter: Component {
    var body: Component {
        Footer {
            Paragraph {
                Link("Generated using Publish", url: "https://github.com/johnsundell/publish")
            }
            
            Paragraph {
                Link("RSS feed", url: "/feed.rss")
            }
            
            Paragraph {
                Link("Developed Yusuf Özgül", url: "https://github.com/yusufozgul")
            }
        }
    }
}

struct ThemeTagList<T: Website>: Component {
    var tags: [Tag]
    var site: T
    var body: Component {
        List {
            for tag in tags {
                ListItem {
                    Link(tag.string, url: "/\(site.path(for: tag))")
                }
                .class(Tags.find(tag: tag.string).rawValue)
            }
        }
        .class("tag-list")
    }
}

struct ThemeItemList<T: Website>: Component {
    var items: [Item<T>]
    var site: T
    
    var body: Component {
        List {
            for item in items {
                ListItem {
                    Article {
                        H1 {
                            Link(item.title, url: "\(item.path.absoluteString)")
                        }
                        Text(DateFormatter.blog.string(from: item.date))
                        Text("Reading \(item.readingTime.minutes) minutes")
                        ThemeTagList(tags: item.tags, site: site)
                        Paragraph {
                            Text(item.description)
                        }
                    }
                }
            }
        }
        .class("item-list")
    }
}
