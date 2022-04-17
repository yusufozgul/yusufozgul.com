---
title: Async operation in Main Thread
date: 2022-04-17 18:14
tags: Swift, Async, Await, WebView
description: What, why would we need async operation in main thread. Generally yes we wouldn't need. But sometimes we need, this blog about async operation in main thread.

---

What, why would we need async operation in main thread. Generally yes we wouldn't need. But sometimes we need, this blog about async operation in main thread.

Async - await introduced in Swift 5.5 also supports iOS 13 and above. Async - await is simple than closures.

This is simple async await code:

```swift
func fetchMovie() async throws -> MovieResponse {
    let (data, response) = try await URLSession.shared.data(from: url)
        return try decoder.decode(MovieResponse.self, from: data)
}
```

In this case we don't need main thread while requesting. Ok, when would we need? Have you ever use Webview and connect your swift code and webview. You must use `evaluateJavaScript` . This method return result inside closure. 

```swift
webView.evaluateJavaScript("document.getElementById('someElement').innerText") { (result, error) in
    if let error = error {
        print(error)
    }
}
```

Also, it has a new async method. But there is a problem, `evaluateJavaScript` must run in main thread. How we use `evaluateJavaScript` in main thread.

We can use `withUnsafeThrowingContinuation`. This method gives a closure and waits until we call it. We can run our code in main thread.

```swift
extension WKWebView {
    @discardableResult
    func runJavaScript(_ javaScript: String) async throws -> Any? {
        try await withUnsafeThrowingContinuation({ continuation in
            DispatchQueue.main.async {
                self.evaluateJavaScript(javaScript) { result, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(with: .success(result))
                    }
                }
            }
        })
    }
}
```

Note: Until `withUnsafeThrowingContinuation` finishes, main thread is blocked. So our UI will be freeze and not respond. You should use it carefully.

Thanks for reading, if you are interested you can read my other blogs.
