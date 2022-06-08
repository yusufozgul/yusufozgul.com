---
title: How to Resize Cell Without Reload - Self Resizing (iOS 16)
date: 2022-06-07 18:14
tags: swift, collection view
description: iOS 16 brings new function to resize our cell without reload. Also support animation.

---

WWDC 2022 brings a lot of new features. One of them self resizing cell (it supports Collection View and Table View). Now we can easily resize cell with just one line code. Ok, let's see.

iOS 16 has new variable for UICollectionView and UITableView `selfSizingInvalidation`. Its default value is enabled. If you use UIListContentConfiguration cell automatically resize when the configuration changed. Also, you can resize it whenever you want.
This blog is only for manual self resizing. If you use UIListContentConfiguration it updates automatically.

### How to resize cell


I create simple collection view and setup. 

```swift
import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CustomCollectionViewCell")
    }
}
// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath)
    }
}
```


Also here is Cell. After cell awake random seconds later it updates and I called `invalidateIntrinsicContentSize` function. Cell resize with animation. 

```swift
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var label: UILabel!

    private let lorems: [String] = [
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.",
        "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.",
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
        "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
    ]

    override func awakeFromNib() {
        super.awakeFromNib()

        DispatchQueue.main.asyncAfter(deadline: .now() + ([1.0, 2.0, 3.0].randomElement() ?? 1.0)) { [weak self] in
            self?.label.text = self?.lorems.randomElement() ?? ""

            // Manually self resize
            self?.invalidateIntrinsicContentSize()
        }
    }
}

```

![](/upload-images/SelfResizingCell/SelfResizingCell.gif width=30%)

Also you can disable animation:

```other
// Manually self resize
UIView.performWithoutAnimation {
	self?.invalidateIntrinsicContentSize()
}
```


Note: Xcode 14 beta-1 has a glitch when used without animation self resizing.
