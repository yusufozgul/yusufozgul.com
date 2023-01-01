----
title: How I Automated Tracking My Habits
date: DATE - 2023-01-01 20:00
tags: Automation
description: Quick look my automations about regular habits
----

I have several habits and I try to not break the chain, but I’m lazy to check I did that. Because all my habits are digital, reading a book (e-reader), and learning language (apps). So I can track automatically my habits. But if I do not check them how do I see my chain? Let’s figure it out.

##### Automation for Reading


Last year I bought an e-reader. Very powerful device because it logs my reading statistics, but I couldn’t find a way to share this data so I changed my reader app to [Koreader](https://github.com/koreader/koreader). Koreader has more data and cloud sync feature. I created a simple service it collects my reading data.

Koreader logs book, page, reading time per page, and date. I also created a simple go server and serve koreader data.

```json
[
  {
    "id": 1,
    "name": "KOReader Quickstart Guide",
    "readings": [
      {
        "page": 1,
        "startTime": 1672072693,
        "duration": 13
      },
      {
        "page": 2,
        "startTime": 1672072706,
        "duration": 11
      },
      {
        "page": 3,
        "startTime": 1672072717,
        "duration": 6
      },
      {
        "page": 6,
        "startTime": 1672072728,
        "duration": 14
      }
    ]
  }
]
```


##### Automation for Blog Posts


Yeah yeah, I said I’m lazy. I can’t write regularly, but I added a new habit: blog posts every month. It looks easy and affordable. Anyway, the topic is automation. This blog has RSS feed, and I can read the last post date 🚀

```xml
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:content="http://purl.org/rss/1.0/modules/content/">
    <channel>
        <title>Yusuf Özgül | Blog | Resume | Portfolio</title>
        <description>Blog, Projects, ...</description>
        <link>https://yusufozgul.com</link>
        <language>tr</language>
        <lastBuildDate>Sat, 20 Aug 2022 11:19:52 +0000</lastBuildDate>
        <pubDate>Sat, 20 Aug 2022 11:19:52 +0000</pubDate>
        <ttl>250</ttl>
	</channel>
</rss>
```


##### Automation for Learn Language


No none of my using apps has API about learning stats, even my app ☹️I found another method, tracking spending time on the app. I create iOS Shortcuts automation when the app opened and closed. I save the date and I know I much time spend on an app. 

```json
{
  "app-lastOpenedDate": "2022-12-31T20:01:10.731Z",
  "app-isOpened": false,
  "app-duration": 11811.355
}
```


##### Last Thing 


I needed just combine all of them. So I can run and log every night. I use Scriptable and Shortcuts, shortcuts trigger Scriptable every night, and scriptable reads daily reminders folder, and check each of them. I also create a simple log server, scriptable to log every reminder with state and I’ll make UI for my past logs. I’ll see if I break the chain or not.

Thank you for reading, see other posts
