import Foundation
import Publish
import Plot
import yusufozgul_comTheme
import ReadingTimePublishPlugin
import TwitterPublishPlugin
import Splash
import SplashPublishPlugin
import ImageAttributesPublishPlugin
import LinkAttributesPublishPlugin
import GistPublishPlugin
import VerifyResourcesExistPublishPlugin
import YoutubePublishPlugin
import PublishGallery

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
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://yusufozgul.com")!
    var name = "Yusuf Özgül | Blog | Resume | Portfolio"
    var description = "Blog, Projects, ..."
    var language: Language { .turkish }
    var imagePath: Path? { nil }
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
                            deployedUsing: .git("https://yusuf.ozgul@github.com/yusufozgul/YusufOzgul-Deploys"),
                            additionalSteps: [.installPlugin(.readingTime(wordsPerMinute: 40)),
                                              .generateSiteMap(),
                                              .installPlugin(.verifyResourcesExist()),
                                              .generateRSSFeed(including: [.blogs, .projects]),
                            ],
                            plugins: [.twitter(),
                                      .youtube(),
                                      .gist(renderer: ColorGistRenderer()),
                                      .linkAttributes(),
                                      .imageAttributes(),
                                      .splash(withClassPrefix: ""),
                                      .publishGallery()
                            ])

class ColorGistRenderer: GistRenderer {
    func render(gist: EmbeddedGist) throws -> String {
        let highlighter = SyntaxHighlighter(format: HTMLOutputFormat())
        return gist.files.map { file in
            return "<pre><code>" + highlighter.highlight(file.content) + "</pre></code>"
        }.joined(separator: "")
    }
}
