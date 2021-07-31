//
//  File.swift
//  
//
//  Created by Yusuf Özgül on 2.01.2021.
//

import Foundation
import Plot
import Publish

struct ThemeHeader<T: Website>: Component {
    var context: PublishingContext<T>
    var selectedSection: T.SectionID?
    
    var body: Component {
        Header {
            Node<T>.raw("<link rel=\"stylesheet\" href=\"/navigationStyle.css\" type=\"text/css\"/>")
                Navigation {
                    Div {
                        Input(type: HTMLInputType(rawValue: "checkbox")!)
                            .id("check")
                        
                        Label("") {
                            Image("/upload-images/base/menu-icon.svg")
                                .attribute(Attribute<T>(name: "width", value: "30"))
                                .attribute(Attribute<T>(name: "height", value: "30"))
                                .class("checkbtn")
                        }
                        .attribute(Attribute<T>(name: "for", value: "check"))
                        
                        Label("") {
                            Link("Yusuf Özgül", url: "/")
                        }
                        .class("logo")
                        
                        List {
                            Link("Home", url: "/")
                                .class(selectedSection?.rawValue == YusufozgulCom.SectionID.home.rawValue ? "active" : "")
                            Link("About", url: "/about")
                                .class(selectedSection?.rawValue == YusufozgulCom.SectionID.about.rawValue ? "active" : "")
                            Link("Contact", url: "/contact")
                                .class(selectedSection?.rawValue == YusufozgulCom.SectionID.contact.rawValue ? "active" : "")
                            Link("Projects", url: "/projects")
                                .class(selectedSection?.rawValue == YusufozgulCom.SectionID.projects.rawValue ? "active" : "")
                            Link("Blog", url: "/blogs")
                                .class(selectedSection?.rawValue == YusufozgulCom.SectionID.blogs.rawValue ? "active" : "")
                        }
                        .class("navContent")
                        .id("hoverEnabled")
                    }
                    .class("navArea")
                }
            .class("header")
            .class("navBar")
        }
    }
}
