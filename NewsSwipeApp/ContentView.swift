
import SwiftUI

struct NewsItem: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let imageName: String
    let TapToKnow: String
}

struct ContentView: View {
    @State private var newsList = [
        NewsItem(title: "As Deepinder Goyal generates buzz with ‘Temple’ device on forehead, experts advice caution: ‘The biggest worry is that", content: "Deepinder Goyal’s recent appearance on a podcast drew public attention and sparked curiosity, as he was seen wearing a small device — named Temple — fixed near the temple region of the head. According to several reports, the experimental wearable health gadget, developed by a private research initiative backed by the Zomato founder and CEO, continuously measures brain oxygenation, which indirectly reflects blood flow to the brain when the person is upright and moving, or sitting for long durations.", imageName: "Dipendar" , TapToKnow: "Lockheed Martin Agreement"),
        NewsItem(title: "I spent a week with Motorola’s Edge 70, an absolutely thin smartphone that is too hard to ignore ", content: "The Motorola Edge 70 focuses on sleek design and comfort while still delivering all-day battery life. Priced at Rs 29,999, it offers a premium build, bright display, reliable everyday performance, and strong durability, but compromises on camera quality and flagship-level power.", imageName: "Moto" , TapToKnow: "noman"),
        NewsItem(title: "Foreign tourist dances around ‘protective’ circle on New Year’s Eve in Shillong, video wins hearts: ‘the respect for personal space and dignity’", content: "Amid several incidents of concern over women’s safety in India, a video of a foreign tourist dancing in Shillong during New Year celebrations has caught the Internet’s attention, drawing widespread appreciation on social media.", imageName: "Dance" , TapToKnow: "noman")
    ]
    
    @State private var currentIndex: Int = 0
    @State private var dragOffset: CGFloat = 0

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ForEach(0..<newsList.count, id: \.self) { index in
                // Only render the current, the next, AND the previous card
                if index >= currentIndex - 1 && index <= currentIndex + 1 {
                    NewsCardView(news: newsList[index])
                        .offset(y: calculateOffset(for: index))
                        .zIndex(calculateZIndex(for: index))
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let dragHeight = value.translation.height
                                    
                                    // 1. Swiping UP (to next) - only if not on last card
                                    if dragHeight < 0 && currentIndex < newsList.count - 1 {
                                        dragOffset = dragHeight
                                    }
                                    // 2. Swiping DOWN (to previous) - only if not on first card
                                    else if dragHeight > 0 && currentIndex > 0 {
                                        dragOffset = dragHeight
                                    }
                                }
                                .onEnded { value in
                                    let dragHeight = value.translation.height
                                    let screenHeight = UIScreen.main.bounds.height
                                    
                                    // Swipe UP logic
                                    if dragHeight < -100 && currentIndex < newsList.count - 1 {
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                            currentIndex += 1
                                            dragOffset = 0
                                        }
                                    }
                                    // Swipe DOWN logic
                                    else if dragHeight > 100 && currentIndex > 0 {
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                            currentIndex -= 1
                                            dragOffset = 0
                                        }
                                    }
                                    // Snap back
                                    else {
                                        withAnimation(.interactiveSpring()) {
                                            dragOffset = 0
                                        }
                                    }
                                }
                        )
                }
            }
        }
    }
    
    // MARK: - Helper Functions
    
    private func calculateOffset(for index: Int) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        
        // The card before the current one (sitting above the screen)
        if index == currentIndex - 1 {
            return -screenHeight + (dragOffset > 0 ? dragOffset : 0)
        }
        // The current card
        if index == currentIndex {
            return dragOffset < 0 ? dragOffset : 0
        }
        // The card after (stays still behind)
        return 0
    }
    
    private func calculateZIndex(for index: Int) -> Double {
        // The previous card must have the highest ZIndex when pulling down
        if index == currentIndex - 1 { return 2.0 }
        // The current card is middle
        if index == currentIndex { return 1.0 }
        // The next card is bottom
        return 0.0
    }
}

struct NewsCardView: View {
    let news: NewsItem
    
    var body: some View {
        VStack(spacing: 0) {
            // IMAGE SECTION
            ZStack {
                Rectangle()
                    .fill(LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom))
                
                // Using system image for demo, replace with yours
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .foregroundColor(.white)
                
                Image(news.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(height: UIScreen.main.bounds.height * 0.40)
            .clipped()
            
            // CONTENT SECTION
            VStack(alignment: .leading, spacing: 15) {
                Text(news.title)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.primary)
                
                Text(news.content)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineSpacing(1)
                
//                Spacer()
            }
            .padding(25)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: UIScreen.main.bounds.height * 0.50)
            .background(Color(UIColor.systemBackground))
            
            // FOOTER SECTION
            VStack {
                Spacer()
                Text(news.TapToKnow)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.gray.opacity(0.8))
            }
            .frame(height: UIScreen.main.bounds.height * 0.10)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color(UIColor.systemBackground))
        .ignoresSafeArea()
    }
}
#Preview {
    ContentView()
}
