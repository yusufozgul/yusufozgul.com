//
//  AboutMe.swift
//  
//
//  Created by Yusuf Özgül on 1.01.2021.
//

import Foundation

let aboutMe = Abouts(education: [
    About(title: "Software Engineering Undergraduate Education",
          subtitle: "Celal Bayar University",
          date: "2017 - 2021",
          description: ["Software Engineering Undergraduate Courses",
                        "C courses for university students.",
                        "Software and technology trainings for middle school students at the Hour of Code event.",
                        "Mip Hackthon second prize. Organized by Manisa Celal Bayar University and Manisa Organized Industry. Mobile application with useful features for daily life."], refLink: nil)],
                    
                    experience: [
                        About(title: "iOS Developer",
                              subtitle: "Trendyol",
                              date: "Sep 2020 - now",
                              description: ["I work in Trendyol mobile application development team."],
                              refLink: [[.link: "https://apps.apple.com/us/app/trendyol-alışveriş-moda/id524362642", .name: "AppStore"]]),
                        About(title: "iOS Developer",
                              subtitle: "ILAO",
                              date: "May 2019 - Jul 2020",
                              description: ["I coded the designs of mobile applications, developed the backend connection.",
                                            "IOS features such as Push Notification, in-app purchases, iCloud, keychain were used.",
                                            "I published the apps to testers via Test Flight and on the AppStore."], refLink: nil),
                        
                        About(title: "iOS Developer",
                              subtitle: "WEVENT",
                              date: "Sep 2019 - Jul 2020",
                              description: ["Design implementation, integration and development for the Wevent iOS application.",
                                            "iOS accessibility, push notification, backend integration features.",
                                            "Wevent is the platform that enables users to reach events and event organizations to reach users.",
                                            "Wevent includes features purchasing tickets for events, recommending events for user’s interests."
                        ], refLink: [[.link: YusufozgulCom.url.absoluteString + "/projects/#wevent", .name: "Project"]]),
                        About(title: "Mobile Developer Intern",
                              subtitle: "VBT",
                              date: "Aug 2020 - Sep 2020",
                              description: ["Flutter with iOS and Android apps,",
                                "Unit Tests with Go Lang,",
                                "Design patterns,",
                                "Advanced Git course,",
                                "User Interface design: UI, UX,"], refLink: [[.link: "https://github.com/VBT-Intership/YusufOzgul-FlutterUI", .name: "Github"],
                                                                             [.link: "https://github.com/VBT-Intership/YusufOzgul-DiceRoller", .name: "Github"],
                                                                             [.link: "https://github.com/VBT-Intership/YusufOzgul-Calculator", .name: "Github"]])
                        
                        
])
