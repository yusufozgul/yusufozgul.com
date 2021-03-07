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
    static func contactForm<T: Website>(on site: T) -> Node {
        return .div(
            .div(
                .id("socialMedia"),
                .forEach(socialMediaLinks.accounts, { account in
                    .a(
                        .id("socialMedia"),
                        .href(account.link),
                        .i(
                            .class(account.icon)
                        ),
                        .span(
                            .id("socialMedia"),
                            .text(account.name)
                        )
                    )
                })
            ),
            .raw("""
            <div class="typeform-widget" data-url="https://form.typeform.com/to/SaLQUJ4s" style="width: 100%; height: 500px;"></div> <script> (function() { var qs,js,q,s,d=document, gi=d.getElementById, ce=d.createElement, gt=d.getElementsByTagName, id="typef_orm", b="https://embed.typeform.com/"; if(!gi.call(d,id)) { js=ce.call(d,"script"); js.id=id; js.src=b+"embed.js"; q=gt.call(d,"script")[0]; q.parentNode.insertBefore(js,q) } })() </script> <div style="font-family: Sans-Serif;font-size: 12px;color: #999;opacity: 0.5; padding-top: 5px;"> powered by <a href="https://admin.typeform.com/signup?utm_campaign=SaLQUJ4s&utm_source=typeform.com-01EHS50042A5BWTQZCVYAKBTB3-free&utm_medium=typeform&utm_content=typeform-embedded-poweredbytypeform&utm_term=EN" style="color: #999" target="_blank">Typeform</a> </div>
            """),
            .script(
                .src("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css")
            )
        )
    }
}
 // <i class="fab fa-github"></i>
