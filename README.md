# 📰 Vertical News Swipe Animation (Inshorts Style)

 
A SwiftUI demo application that recreates the **Inshorts-style vertical news feed**, where users swipe up and down to navigate between full-screen news cards, one card at a time.

This project focuses on gesture-driven vertical paging, smooth animations, and modern SwiftUI layout techniques.

 

https://github.com/user-attachments/assets/a2623c42-6ad0-4ad3-a7cd-a1725e5482e4


---

## ✨ Features

- 📱 **Full-screen vertical swipe navigation**
- 📰 **One news card per swipe** (Inshorts-style)
- 🎯 **Smooth spring-based animations**
- 🧊 **Glass/blur CTA footer**
- ⚡ **Pure SwiftUI** (No UIKit)
- 🧩 **Clean & readable code structure**

---

## 🧱 Tech Stack

| Technology | Purpose |
|------------|---------|
| SwiftUI | UI Framework |
| DragGesture | Swipe detection |
| ZStack/VStack | Layout management |
| State-driven animations | Smooth transitions |
| Apple Material | Glassmorphism effects |

---

## 📁 Project Structure

```
SwiftUI-VerticalNewsSwipe/
│
├── ContentView.swift          # Main vertical swipe logic
├── NewsItem.swift             # News model
├── Helper.swift               # Additional utilities
└── Assets.xcassets/           # Images and resources
```

---

## 🧠 How It Works

SwiftUI does not provide built-in vertical paging, so this project implements paging manually using:

- **DragGesture** to detect swipe direction
- **@State** to track current card index
- **offset(y:)** to move cards vertically
- **zIndex** to manage card layering

This approach closely mimics the behavior of the **Inshorts app**.

---

## 🔑 Key State Variables

```swift
@State private var currentIndex: Int = 0
@State private var dragOffset: CGFloat = 0
```

### Purpose

- `currentIndex` → Tracks which news card is currently visible
- `dragOffset` → Tracks live drag movement during swipe

---

## 🧮 Card Positioning Logic

```swift
private func calculateOffset(for index: Int) -> CGFloat {
    let screenHeight = UIScreen.main.bounds.height
    
    if index == currentIndex - 1 {
        return -screenHeight + (dragOffset > 0 ? dragOffset : 0)
    }
    if index == currentIndex {
        return dragOffset < 0 ? dragOffset : 0
    }
    return 0
}
```

### What This Achieves

- ✅ Previous card stays above the screen
- ✅ Current card follows the user's finger
- ✅ Next card stays hidden below
- ✅ Creates a realistic stacked vertical swipe effect

---

## 🧲 Gesture Handling

```swift
DragGesture()
    .onChanged { value in
        dragOffset = value.translation.height
    }
    .onEnded { value in
        if value.translation.height < -100 {
            currentIndex += 1
        } else if value.translation.height > 100 {
            currentIndex -= 1
        }
        dragOffset = 0
    }
```

### Why Thresholds Are Used

- Prevents accidental swipes
- Ensures intentional navigation
- Improves user experience

---

## 🎞 Smooth Animations

```swift
withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
    currentIndex += 1
}
```

**Benefits:**
- Natural movement
- Smooth snapping
- Closely matches Inshorts scrolling behavior

---

## 🧊 Glass CTA Footer (Glassmorphism)

The "Tap to know more" section uses Apple's system blur material:

```swift
.background(
    .ultraThinMaterial,
    in: RoundedRectangle(cornerRadius: 16)
)
```

**Benefits:**
- Real blur (not fake opacity)
- Automatically adapts to light/dark mode
- Premium, modern look

---

## 📐 Responsive Layout

Dynamic heights are calculated using screen size:

```swift
UIScreen.main.bounds.height * 0.40
```

**This ensures:**
- Consistent UI across all devices
- No hardcoded sizes
- Better scalability

---

## 🚀 Getting Started

### Prerequisites

- Xcode 15.0+
- iOS 17.0+
- Swift 5.9+

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/SwiftUI-VerticalNewsSwipe.git
```

2. Open the project in Xcode:
```bash
cd SwiftUI-VerticalNewsSwipe
open SwiftUI-VerticalNewsSwipe.xcodeproj
```

3. Build and run the project (⌘ + R)

---

## 📱 Demo

### Swipe Up
Moves to the next news card with smooth animation

### Swipe Down
Returns to the previous news card

### Tap CTA
Placeholder for "Read More" functionality

---

## 🎯 Best Use Cases

✔ Learning advanced SwiftUI gestures  
✔ Understanding manual paging logic  
✔ UI/UX prototypes  
✔ Interview & portfolio projects  

---

## 🔮 Possible Enhancements

- [ ] Infinite scrolling
- [ ] API-based real news integration
- [ ] Haptic feedback on swipe
- [ ] Page indicators
- [ ] Bookmarking functionality
- [ ] Share sheet integration
- [ ] Dark mode optimization
- [ ] Accessibility improvements

---

## 📊 Performance

- **Smooth 60 FPS** scrolling
- **Minimal memory footprint** (only renders visible + adjacent cards)
- **Optimized gesture handling**

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
 
