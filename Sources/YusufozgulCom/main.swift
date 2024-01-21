import Foundation
import Publish
import Plot
import ReadingTimePublishPlugin
//import TwitterPublishPlugin
import Splash
import SplashPublishPlugin
import ImageAttributesPublishPlugin
import LinkAttributesPublishPlugin
import GistPublishPlugin
import VerifyResourcesExistPublishPlugin
import YoutubePublishPlugin
import CNAMEPublishPlugin
//import PublishGallery

// This type acts as the configuration for your website.
struct YusufozgulCom: Website {
    enum SectionID: String, WebsiteSectionID {
        case home
        case about
        case contact
        case projects
        case blogs
    }
    
    struct ItemMetadata: WebsiteItemMetadata {
        let isDraft: Bool?
        let date: String
        var shouldDelete: Bool { isDraft ?? false }
    }
    
    // Update these properties to configure your website:
    var url = URL(string: "https://yusufozgul.com")!
    var name = "Yusuf Özgül | Blog | Resume | Portfolio"
    var description = "Blog, Projects, ..."
    var language: Language { .turkish }
    var imagePath: Path? { "/upload-images/" }
    var favicon: Favicon? = .init(path: "/upload-images/favicon.png", type: "image/png")
    
    init() {
        LoadData.load()
    }
}

try YusufozgulCom().publish(withTheme: .yusufozgulcom,
                            indentation: nil,
                            at: nil,
                            rssFeedSections: [.blogs, .projects],
                            rssFeedConfig: nil,
                            additionalSteps: [
                                .installPlugin(.readingTime(wordsPerMinute: 40)),
                                .generateSiteMap(),
                                .installPlugin(.verifyResourcesExist()),
                                .generateRSSFeed(including: [.blogs, .projects]),
                                .removeAllItems(in: .blogs, matching: .init(matcher: \.metadata.shouldDelete)),
                                .installPlugin(.generateCNAME(with: ["yusufozgul.com", "www.yusufozgul.com"])),
                            ],
                            plugins: [
                                //.twitter(),
                                .youtube(),
                                .gist(renderer: ColorGistRenderer()),
                                .linkAttributes(),
                                .imageAttributes(),
                                .splash(withClassPrefix: ""),
                                //.publishGallery()
                            ])

class ColorGistRenderer: GistRenderer {
    func render(gist: EmbeddedGist) throws -> String {
        let highlighter = SyntaxHighlighter(format: HTMLOutputFormat())
        return gist.files.map { file in
            return "<pre><code>" + highlighter.highlight(file.content) + "</pre></code>"
        }.joined(separator: "")
    }
}
