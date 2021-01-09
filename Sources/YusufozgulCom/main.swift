import Foundation
import Publish
import Plot
import yusufozgul_comTheme
import ReadingTimePublishPlugin
import TwitterPublishPlugin
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

// This will generate your website using the built-in Foundation theme:
try YusufozgulCom().publish(using: [
    .installPlugin(.twitter()),
    .installPlugin(.gist()),
    .installPlugin(.linkAttributes()),
    .installPlugin(.imageAttributes()),
    .installPlugin(.splash(withClassPrefix: "")),
    .installPlugin(.youtube()),
    .installPlugin(.publishGallery()),
    .addMarkdownFiles(),
    .copyFiles(at: "/Resources/upload-images", to: "/upload-images"),
    .installPlugin(.readingTime(wordsPerMinute: 40)),
    .generateHTML(withTheme: .yusufozgulcom),
    .generateSiteMap(),
    .installPlugin(.verifyResourcesExist()),
    .generateRSSFeed(including: [.blogs, .projects]),
    .deploy(using: .git("https://yusuf.ozgul@github.com/yusufozgul/YusufOzgul-Deploys"))
])