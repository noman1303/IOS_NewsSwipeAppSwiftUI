Below is a clean, professional, FINAL README file ONLY for the SwiftUI project.
You can directly paste this into your SwiftUI repo without any changes.

⸻

📰 Vertical News Swipe Animation (Inshorts Style) — SwiftUI

A SwiftUI demo application that recreates the Inshorts-style vertical news feed, where users swipe up and down to navigate between full-screen news cards, one card at a time.

This project focuses on gesture-driven vertical paging, smooth animations, and modern SwiftUI layout techniques.

⸻

✨ Features
	•	📱 Full-screen vertical swipe navigation
	•	📰 One news card per swipe (Inshorts-style)
	•	🎯 Smooth spring-based animations
	•	🧊 Glass / blur CTA footer
	•	⚡ Pure SwiftUI (No UIKit)
	•	🧩 Clean & readable code structure

⸻

🧱 Tech Stack
	•	SwiftUI
	•	DragGesture
	•	ZStack / VStack
	•	State-driven animations
	•	Apple Material (Glassmorphism)

⸻

📁 Project Structure

SwiftUI-VerticalNewsSwipe
│
├── ContentView.swift     // Main vertical swipe logic
├── NewsItem.swift        // News model
└── Assets.xcassets       // Images


⸻

🧠 How It Works (Core Concept)

SwiftUI does not provide built-in vertical paging, so this project implements paging manually using:
	•	DragGesture to detect swipe direction
	•	@State to track current card index
	•	offset(y:) to move cards vertically
	•	zIndex to manage card layering

This approach closely mimics the behavior of the Inshorts app.

⸻

🔑 Key State Variables

@State private var currentIndex: Int = 0
@State private var dragOffset: CGFloat = 0

Purpose
	•	currentIndex → Tracks which news card is currently visible
	•	dragOffset → Tracks live drag movement during swipe

⸻

🧮 Card Positioning Logic (Most Important Part)

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

What This Achieves
	•	Previous card stays above the screen
	•	Current card follows the user’s finger
	•	Next card stays hidden below
	•	Creates a realistic stacked vertical swipe effect

⸻

🧲 Gesture Handling (Swipe Detection)

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

Why Thresholds Are Used
	•	Prevents accidental swipes
	•	Ensures intentional navigation
	•	Improves user experience

⸻

🎞 Smooth Animations

.withAnimation(.spring(response: 0.4, dampingFraction: 0.8))

	•	Natural movement
	•	Smooth snapping
	•	Closely matches Inshorts scrolling behavior

⸻

🧊 Glass CTA Footer (Glassmorphism)

The “Tap to know more” section uses Apple’s system blur material:

.background(
    .ultraThinMaterial,
    in: RoundedRectangle(cornerRadius: 16)
)

Benefits
	•	Real blur (not fake opacity)
	•	Automatically adapts to light/dark mode
	•	Premium, modern look

⸻

📐 Responsive Layout

Dynamic heights are calculated using screen size:

UIScreen.main.bounds.height * 0.40

This ensures:
	•	Consistent UI across all devices
	•	No hardcoded sizes
	•	Better scalability

⸻

🏁 Best Use Cases

✔ Learning advanced SwiftUI gestures
✔ Understanding manual paging logic
✔ UI/UX prototypes
✔ Interview & portfolio projects

⸻

🏷 Suggested Repository Name

InshortsStyleVerticalNews-SwiftUI


⸻

📌 Conclusion

This SwiftUI project demonstrates how complex vertical swipe interactions can be built without UIKit, using only SwiftUI gestures, state, and animations.

It is ideal for:
	•	Developers learning SwiftUI internals
	•	Gesture-based UI experimentation
	•	Modern iOS app design

⸻

🚀 Possible Enhancements
	•	Infinite scrolling
	•	API-based real news
	•	Haptic feedback
	•	Page indicators 
