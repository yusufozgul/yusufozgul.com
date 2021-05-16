---
title: Docker Swift Package cache
date: 2021-05-16 10:08
tags: Swift, Docker
description: How can we cache swift packages while building on docker?
---

I deployed a small Vapor project I made using Docker. Every build re-downloads all dependencies, but dependencies do not change. It was time and network wasting.

### So what can we do to solve this?

Actually, it is quite easy, Docker makes the decision according to the changes of the files at every step. So if we never changed our project, it would take the libraries using the cache not re-download, but our files are changing. So what if we just copy the unchanged ones first and then copy the rest?

```docker
# Copy entire repo into container
COPY . .

# Compile
RUN swift build -c release -Xswiftc -g
```

We copied all the files into the container and called the swift build command. Since it will build completely from begin, it will first download libraries and then build.

```docker
# Copy swift package file
COPY Package.swift .

# Download swift packages
RUN swift package resolve
```

Before copying all files, only copy Package.swift file and call swift package resolve command so that only the libraries download. Then, during build, these libraries are not downloaded again and continue to be used.

So what happens during the next build?

We just copied Package.swift and to download libraries. Same file as the previous build has not changed because. In this case, the docker will go read this from the cache and save time and network.

In this short article, I explained the optimization for swift package in Docker, thank you for reading.
