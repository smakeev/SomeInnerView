# SomeInnerView
![Farmers Market Finder Demo](demo/demo.gif)

SimeInnerView is a UIView allows you to select a part of an image using a part of another image.
As in example this could be the same image.
In example I jus added blur effect view above the background image and when the selection part is an image without any effects.
The resalt of a selection is stored in properties x, y, right, bottom.
They present rectangle of coordinates (from 0 to 1) 

```swift
		innerView = InnerView()
		innerView.backgroundColor = .black
		innerView.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(innerView)
		innerView.leadingAnchor.constraint (equalTo: self.view.leadingAnchor).isActive  = true
		innerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		innerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive           = true
		innerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive     = true
		
		guard let sourceImage = UIImage(named: "image") else { return }
	

		innerView.mainImage = sourceImage
		innerView.background.backgroundColor = .red
		
		let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		
		blurEffectView.translatesAutoresizingMaskIntoConstraints = false
		innerView.background.addSubview(blurEffectView)
		
		blurEffectView.leadingAnchor.constraint(equalTo: innerView.background.leadingAnchor).isActive = true
		blurEffectView.trailingAnchor.constraint(equalTo: innerView.background.trailingAnchor).isActive = true
		blurEffectView.topAnchor.constraint(equalTo: innerView.background.topAnchor).isActive = true
		blurEffectView.bottomAnchor.constraint(equalTo: innerView.background.bottomAnchor).isActive = true
		
		
		innerView.selectionView.backgroundColor = .white
		innerView.secondaryImage = sourceImage
	
		innerView.x = 0.25
		innerView.y = 0.25
		innerView.bottom = 0.7
		innerView.right  = 0.7
		innerView.isSelectionInitialized = true
		
		innerView.selectionView.layer.cornerRadius = 45
		innerView.selectionView.layer.masksToBounds = true
```

To show the selection view you need to set some visible rectangle and call
```swift
  innerView.isSelectionInitialized = true
```
setting this to false will hide the selection view

You may move the selection by setting properties x, y, bottom, right.
To allow user interaction with selection view:
```swift
  innerView.selectionView.isUserInteractionEnabled = true
```

to fix the selection view on part of an image
```swift
innerView.isSelectionFixed = true
```

# How to use:
```
pod "SomeInnerView"	
```

```swift
import SomeInnerView
```
