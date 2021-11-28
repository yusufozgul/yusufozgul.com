//
//  File.swift
//  
//
//  Created by Yusuf Özgül on 1.01.2021.
//

import Foundation

let projects = Projects(items: [
    .init(name: "Wevent",
          code: "wevent",
          subheader: "Events for a better you",
          status: "Published",
          status_css: "published",
          appIcon: "\(YusufozgulCom.url.absoluteString)/upload-images/wevent/wevent.png",
          role: "iOS Developer",
          appStore_link: "https://apps.apple.com/tr/app/wevent/id1483744113",
          gitHub_link: "",
          technologies: ["UIKit", "Combine", "Push Notification", "CloudKit"],
          paragraphs: ["Wevent, sana özel, yepyeni bir etkinlik platformu. Kişisel tercihlerine ​ göre etkinlik önerileri burada. Kendini geliştirmen ​ için aradığın tüm etkinlikler burada. Networking ​ile ilgili her şey burada. ONLINE ​ etkinlikler burada. Arkadaşların​ burada. Peki sen?"],
          screenShotLink: "\(YusufozgulCom.url.absoluteString)/upload-images/wevent/weventSS.jpeg"),
    .init(name: "Deezer Sample",
          code: "deezer",
          subheader: "Sample App",
          status: "Published",
          status_css: "published",
          appIcon: "\(YusufozgulCom.url.absoluteString)/upload-images/deezerSample/icon.png",
          role: "Developer",
          appStore_link: "",
          gitHub_link: "https://github.com/yusufozgul/DeezerSampleApp",
          technologies: ["UIKit", "VIPER Architecture", "MediaPlayerKit", "Deezer API"],
          paragraphs: ["Sample Deezer app with Deezer API written in Swift using VIPER architecture."],
          screenShotLink: "\(YusufozgulCom.url.absoluteString)/upload-images/deezerSample/SS1.png"),
    .init(name: "Github Api App with VIPER",
          code: "github",
          subheader: "Sample App",
          status: "Published",
          status_css: "published",
          appIcon: "\(YusufozgulCom.url.absoluteString)/upload-images/github/icon.png",
          role: "Developer",
          appStore_link: "",
          gitHub_link: "https://github.com/yusufozgul/GithubApiWithVIPER",
          technologies: ["UIKit", "VIPER Architecture", "Modular Design", "Github API"],
          paragraphs: ["Github application written in Swift using VIPER architecture."],
          screenShotLink: "\(YusufozgulCom.url.absoluteString)/upload-images/github/SS1.png"),
])
